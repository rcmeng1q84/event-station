# event-station
stations that have active components to engage the exchange of resources. some can be mobile.

# Memo working with audio comm
## toneAC
Replacement to the standard Arduino tone library with twice the volume, higher quality and higher frequency.
According to this [Arduino Playground](http://playground.arduino.cc/Code/ToneAC) It is a library that produces an alternating current (AC) between two pins. But which two? It is not in a convenient location to find. 

We were able to find [some clue](https://codebender.cc/example/toneAC/toneAC_demo#toneAC_demo.ino) that
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


![Circuit](/hardware/circuit.png?raw=true "Circuit")

![PCB](/hardware/PCB.png?raw=true "PCB")
