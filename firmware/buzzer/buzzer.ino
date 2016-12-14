/**
 * For toneAC to work on Aruduino pro mini (ATmega328), the buzzer should be 
 * connected to Pins 9 & 10. 
 * 
 * We also attach interrupt to A0 changes. 
 */

#include <toneAC.h>
#include <MorseEnDecoder.h>
#include <avr/pgmspace.h>

#include "pitches.h"

const int OUT_TONES[] = {
  //16700, 18100, 17400 };
  20231, 21231 };
const int IN_TONES[] = {
  //16700, 18100, 17400 };
  19231, 20765 };


boolean ready = 0;
#define ADC_CENTER 127
#define WINDOW_SIZE 128
#define BIT_PERIOD 8
#define BIT_PERIOD_2 16
#define NUM_BYTES 5
#define NUM_MSGS 5

const unsigned int ON_THRESHOLD = 110; // Was 50000, has to lower it to decode something out
const unsigned int OFF_THRESHOLD = ON_THRESHOLD/2;

enum {
  IDLE,START,HIGH_PULSE,LOW_PULSE,DONE} 
state = IDLE;

const float SAMPLE_RATE = 38461.5385; // 76923.0769;//38461.5385 //8928.57143
const float STAMP_MS = (float)WINDOW_SIZE/(SAMPLE_RATE/1000);

byte bytei = 0;
byte biti = 0;
byte lastSmpl = 0;
byte bankIn = 0;
byte bankProc = 0;

unsigned short samplei=0;
unsigned long stamp=0;
unsigned long lastStamp=0;

struct msg_t {
  byte bytes[NUM_BYTES];
  boolean ready;
  byte len;
};

struct msg_t msgs[NUM_MSGS];

// For Goertzel calculations
int Q1,Q2;

const int LEDs[] = {5, 3}; // PWM pins
int life = 10;
boolean processBytes();

// Start of the MorseEncoder

/** provide an alternate implemtnation to the default digitalWrite with tone and text instead 
*/
class morseEncoderTone: public morseEncoder {
public:
  morseEncoderTone(int encodePin);
protected:
  void setup_signal();
  void start_signal(bool startOfChar, char signalType);
  void stop_signal(bool endOfChar, char signalType);
};


morseEncoderTone::morseEncoderTone(int encodePin) : morseEncoder(encodePin) {
}

void morseEncoderTone::setup_signal() {
  pinMode(morseOutPin, OUTPUT);
  digitalWrite(morseOutPin, LOW);
}

void morseEncoderTone::start_signal(bool startOfChar, char signalType) 
{
  noTone(this->morseOutPin);
  if(startOfChar)
    Serial.print('!');
    
  switch (signalType) {
    case '.':
      Serial.print("dit");
      break;
    case '-':
      Serial.print("dah");
      break;
    default:
      Serial.print(signalType);
      break;
  }
  tone(this->morseOutPin, NOTE_A3);
}

void morseEncoderTone::stop_signal(bool endOfChar, char signalType) 
{
  noTone(this->morseOutPin);
  if (endOfChar) {
    Serial.println(' ');
  } else {
    Serial.print(' ');
  }
}
// End of MorseEncoder

// Pin mapping 
const byte morseOutPin = 13;  // make sure this is compatible with the Tone class!
morseEncoderTone morseOutput(morseOutPin);

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200); 
  
  // life of the station
  pinMode(LEDs[0], OUTPUT);
  pinMode(LEDs[1], OUTPUT);
  
  Serial.println(STAMP_MS);
  int x = -10;
  Serial.println(x>>2); // What is this for? Testing bit rotation for negatives? 
  x = 10;
  Serial.println(x>>2);
  Serial.println(sizeof(byte));
  Serial.println(sizeof(short));
  Serial.println(sizeof(int));
  Serial.println(sizeof(long));  
  initADC();

  Serial.println("Setting up morse output!");
  morseOutput.setspeed(13);
}
int tcount = 0;
bool use_goertzel = true;
int team = 0; // TO be set by some button

void loop() {
  analogWrite(LEDs[team], life * 255 / 10);
  analogWrite(LEDs[1 - team], 0);
  if (use_goertzel) {
    byte msg[] = { // Headling
      (byte)'T', (byte)String(team)[0], (byte) 'H', (byte)'E', (byte)'A'};
    FMSimpleSend(msg,sizeof(msg));
    delay(2000);
  } else {
    morseOutput.encode();
    morseOutput.write('T');
    
    morseOutput.encode();
    morseOutput.write(String(team)[0]);
    
    morseOutput.encode(); // power up weapons
    morseOutput.write('P');
    morseOutput.encode();
    morseOutput.write('O');
    morseOutput.encode();
    morseOutput.write('W');
  }
}

void initADC() {
  cli();//diable interrupts

  //set up continuous sampling of analog pin 0

  //clear ADCSRA and ADCSRB registers
  ADCSRA = 0;
  ADCSRB = 0;

  ADMUX |= (1 << REFS0); //set reference voltage
  ADMUX |= (1 << ADLAR); //left align the ADC value- so we can read highest 8 bits from ADCH register only

  ADCSRA |= (1 << ADPS2) ;//| (1 << ADPS0); //set ADC clock with 32 prescaler- 16mHz/32=500kHz
  ADCSRA |= (1 << ADATE); //enabble auto trigger
  enableADCInterrupt();//ADCSRA |= (1 << ADIE); //enable interrupts when measurement complete
  ADCSRA |= (1 << ADEN); //enable ADC
  ADCSRA |= (1 << ADSC); //start ADC measurements

  sei();//enable interrupts
}

void enableADCInterrupt() {
  ADCSRA |= (1 << ADIE); //enable interrupts when measurement complete
}
void disableADCInterrupt() {
  ADCSRA &= ~(1 << ADIE); //enable interrupts when measurement complete
}


ISR(ADC_vect) {
  int Q0 = -Q2 + ((int)ADCH-ADC_CENTER);
  Q2 = Q1;
  Q1 = Q0;

  samplei++;
  if(samplei == WINDOW_SIZE) { 
    samplei = 0;
    unsigned long mag = (unsigned long)((long)Q1)*Q1+(unsigned long)((long)Q2)*Q2;
//    Serial.println(mag);
    Q1=Q2=0;

    if(mag > ON_THRESHOLD) {
      FMSimpleRecv(1);
    }
    else if (mag < OFF_THRESHOLD) {
      FMSimpleRecv(0);
    }
  }
}

byte block;
byte *bytes;
void FMSimpleRecv(byte smpl) {
  byte newBit;
  unsigned long stamp = millis();
  unsigned int diff = stamp - lastStamp;

  if(state != IDLE && diff > BIT_PERIOD*4) {
    state = IDLE;
    if(bytei>0) {
      msgs[bankIn].len = bytei;
      msgs[bankIn].ready = true;
      Serial.print("Block ready:");
      Serial.print(bankIn);
      Serial.print(" ");
      Serial.println(bytei);

      bankIn = (bankIn + 1)%NUM_MSGS;
      if(bankIn == bankProc || msgs[bankIn].ready==true) {
        Serial.println("TOO SLOW!");
      }
      msgs[bankIn].ready = false;
    }
    bytei = block = biti = 0;
  }  

  if(lastSmpl!=smpl){
    lastSmpl = smpl;
    //unsigned long stamp = millis();
    //Serial.print(smpl);
    //Serial.print(" ");
    //Serial.println(diff);
    //Serial.println(diff);
    switch(state) {
    case IDLE:
      if(smpl == 1) {
        lastStamp = stamp;
        state = HIGH_PULSE;
      }
      break;
    case LOW_PULSE:
      //newBit = 0;
      if(diff > BIT_PERIOD_2) {
        //newBit = 1;
        block |= 1<<biti;
      }
      lastStamp = stamp;
      state = HIGH_PULSE;

      if(++biti==8) {
        state = HIGH_PULSE;
        Serial.print(block,HEX);
        Serial.print(" ");
        Serial.println((char)block);
        msgs[bankIn].bytes[bytei++] = block;
        biti = block = 0;
        //if(bytei == bytej) Serial.println("TOO SLOW");
      }
      break;
    case HIGH_PULSE:
      state = LOW_PULSE;
      break;
    }
  }
}  


void FMSimpleSend(byte msg[], byte len) {

  disableADCInterrupt();
  #define INC_SIZE 1
  
  toneAC(OUT_TONES[1]);
  delay(BIT_PERIOD);

  for (int m = 0; m < len; m++) {
    for(int b = 0; b<8; b++) {
    
      for(int f=INC_SIZE; f<=BIT_PERIOD; f+=INC_SIZE) {
        toneAC(OUT_TONES[1] - ((OUT_TONES[1]-OUT_TONES[0])*f)/BIT_PERIOD);
        delay(INC_SIZE);
      }

      for(int f=INC_SIZE; f<=BIT_PERIOD; f+=INC_SIZE) {
        toneAC(OUT_TONES[0] + ((OUT_TONES[1]-OUT_TONES[0])*f)/BIT_PERIOD);
        delay(INC_SIZE);
      }
   
      if(((msg[m] >> b) & 0x1)) delay(BIT_PERIOD);
    }
  }

  for(int f=INC_SIZE; f<=BIT_PERIOD; f+=INC_SIZE) {
    toneAC(OUT_TONES[1] - ((OUT_TONES[1]-OUT_TONES[0])*f)/BIT_PERIOD);
    delay(INC_SIZE);
  }
  delay(BIT_PERIOD);
  noToneAC();

  enableADCInterrupt();

}
