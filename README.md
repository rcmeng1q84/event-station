# event-station
stations that have active components to engage the exchange of resources. some can be mobile.
# Conceptual Components

A switch to toggle "healing" and "power-up";

Life indicator of a station. 

# Memo working with audio comm
## toneAC, required by the Geortzel approach
Replacement to the standard Arduino tone library with twice the volume, higher quality and higher frequency.
According to this [Arduino Playground](http://playground.arduino.cc/Code/ToneAC) It is a library that produces an alternating current (AC) between two pins. But which two? It is not in a convenient location to find. 

We managed to find [some clue](https://codebender.cc/example/toneAC/toneAC_demo#toneAC_demo.ino) indicating that pins 9 and 10 for Arduino Pro Mini that we have been having so much fun with. 
```
// ---------------------------------------------------------------------------
// Connect your piezo buzzer (without internal oscillator) or speaker to these pins:
//   Pins  9 & 10 - ATmega328, ATmega128, ATmega640, ATmega8, Uno, Leonardo, etc.
//   Pins 11 & 12 - ATmega2560/2561, ATmega1280/1281, Mega
//   Pins 12 & 13 - ATmega1284P, ATmega644
//   Pins 14 & 15 - Teensy 2.0
//   Pins 25 & 26 - Teensy++ 2.0
// Be sure to include an inline 100 ohm resistor on one pin as you normally do when connecting a piezo or speaker.
// ---------------------------------------------------------------------------
//...
```
The connection is illustrated by the pin9-R1-SP1-pin10 part in the whole circuit. 

![Circuit](/hardware/circuit.png?raw=true "Circuit")

![PCB](/hardware/PCB.png?raw=true "PCB")

## Encoding and decoding with the Goertzel Algorithm
Basically, we are trying to replicate the approach [posted here](http://blog.theultimatelabs.com/2013/05/wirelessly-communicating-with-arduino.html), using 2 frequencies to indicate 1 or 0, then every 8 bit represent a byte. The author tried FFT, DTMF and finally suggested Goertzel is the best option based on the initial experiment. It is still a back-and-forth between time-domain and frequency-domain. 

Preview of the [The mathmatical models](https://en.wikipedia.org/wiki/Goertzel_algorithm)
![Digital Filter](https://wikimedia.org/api/rest_v1/media/math/render/svg/4cc5e858f5999c11b56059a70d6ca78368e6cf5d "Digital Filter")

Ideally, it should work like the following:
```
// From the station, loop this message constantly to heal members of team 0. 
sendCommand("T0HEL");
// At the receiving end (Vest or weapons like Rod)
if (new_byte_arrived) {
  Serail.print(char_decoded)
}
// And we get the exact "T0HEL"
```
### ADC Interrupt to sample audio
Way more fast than analogRead, but has to keep the interrupt handling routine short in execution time. Just simple evaluation or basic interger arithmetic ops. 

It would be every exciting to have got it to work. However, it is not successfully reproduced. 

## Endcoding and Decoding with Morse code
Follow the similar high level procedure, also unsuccessful. 
