EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:ST-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Label 4400 3600 0    60   ~ 0
10
Text Label 4400 3500 0    60   ~ 0
11
Text Label 4400 3400 0    60   ~ 0
12
Text Label 4400 3300 0    60   ~ 0
13
NoConn ~ 4400 3500
NoConn ~ 4400 3400
Text Label 4400 3200 0    60   ~ 0
A0
Text Label 4400 3100 0    60   ~ 0
A1
Text Label 4400 3000 0    60   ~ 0
A2
Text Label 4400 2900 0    60   ~ 0
A3
Text Label 4400 2800 0    60   ~ 0
VCC
Text Label 4400 2700 0    60   ~ 0
RST
Text Label 4400 2600 0    60   ~ 0
GND
Text Label 4400 2500 0    60   ~ 0
RAW
Text Label 3400 2500 0    60   ~ 0
TXO
Text Label 3400 2600 0    60   ~ 0
RXI
Text Label 3400 2700 0    60   ~ 0
RST0
Text Label 3400 2800 0    60   ~ 0
GND0
Text Label 3400 2900 0    60   ~ 0
2
Text Label 3400 3000 0    60   ~ 0
3
Text Label 3400 3100 0    60   ~ 0
4
Text Label 3400 3200 0    60   ~ 0
5
Text Label 3400 3300 0    60   ~ 0
6
Text Label 3400 3400 0    60   ~ 0
7
Text Label 3400 3500 0    60   ~ 0
8
Text Label 3400 3600 0    60   ~ 0
9
NoConn ~ 4400 3200
NoConn ~ 4400 3100
NoConn ~ 4400 3000
NoConn ~ 4400 2900
Text GLabel 4700 2800 2    60   Input ~ 0
VCC
NoConn ~ 4400 2700
Text GLabel 4700 2600 2    60   Input ~ 0
GND1
NoConn ~ 4400 2500
NoConn ~ 3400 2500
NoConn ~ 3400 2600
NoConn ~ 3400 2700
Text GLabel 3200 2800 0    60   Input ~ 0
GND0
NoConn ~ 3400 2900
NoConn ~ 3400 3100
NoConn ~ 3400 3300
NoConn ~ 3400 3400
$Comp
L SPEAKER SP1
U 1 1 58521ECB
P 5000 3250
F 0 "SP1" H 4900 3500 50  0000 C CNN
F 1 "SPEAKER" H 4900 3000 50  0000 C CNN
F 2 "Connect:bornier2" H 5000 3250 50  0001 C CNN
F 3 "" H 5000 3250 50  0000 C CNN
	1    5000 3250
	0    -1   -1   0   
$EndComp
Text Label 4900 4350 1    60   ~ 0
9
$Comp
L R R1
U 1 1 58521F2C
P 4900 3900
F 0 "R1" V 4980 3900 50  0000 C CNN
F 1 "R" V 4900 3900 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 4830 3900 50  0001 C CNN
F 3 "" H 4900 3900 50  0000 C CNN
	1    4900 3900
	1    0    0    -1  
$EndComp
Text Label 5100 3750 0    60   ~ 0
10
$Comp
L SPEAKER SP2
U 1 1 5852203B
P 5850 3250
F 0 "SP2" H 5750 3500 50  0000 C CNN
F 1 "SPEAKER" H 5750 3000 50  0000 C CNN
F 2 "Connect:bornier2" H 5850 3250 50  0001 C CNN
F 3 "" H 5850 3250 50  0000 C CNN
	1    5850 3250
	0    -1   -1   0   
$EndComp
Text Label 5750 4350 0    60   ~ 0
8
$Comp
L R R2
U 1 1 585221B8
P 5750 3900
F 0 "R2" V 5830 3900 50  0000 C CNN
F 1 "R" V 5750 3900 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 5680 3900 50  0001 C CNN
F 3 "" H 5750 3900 50  0000 C CNN
	1    5750 3900
	1    0    0    -1  
$EndComp
Text GLabel 5950 3750 3    60   Input ~ 0
GND0
$Comp
L R R3
U 1 1 585222B5
P 4600 4800
F 0 "R3" V 4680 4800 50  0000 C CNN
F 1 "R" V 4600 4800 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 4530 4800 50  0001 C CNN
F 3 "" H 4600 4800 50  0000 C CNN
	1    4600 4800
	0    1    1    0   
$EndComp
Text Label 4250 4800 0    60   ~ 0
5
$Comp
L LED D1
U 1 1 58522323
P 4950 4800
F 0 "D1" H 4950 4900 50  0000 C CNN
F 1 "LED" H 4950 4700 50  0000 C CNN
F 2 "LEDs:LED-3MM" H 4950 4800 50  0001 C CNN
F 3 "" H 4950 4800 50  0000 C CNN
	1    4950 4800
	-1   0    0    1   
$EndComp
$Comp
L LED D2
U 1 1 5852242D
P 4950 5050
F 0 "D2" H 4950 5150 50  0000 C CNN
F 1 "LED" H 4950 4950 50  0000 C CNN
F 2 "LEDs:LED-3MM" H 4950 5050 50  0001 C CNN
F 3 "" H 4950 5050 50  0000 C CNN
	1    4950 5050
	-1   0    0    1   
$EndComp
$Comp
L R R4
U 1 1 58522483
P 4600 5050
F 0 "R4" V 4680 5050 50  0000 C CNN
F 1 "R" V 4600 5050 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 4530 5050 50  0001 C CNN
F 3 "" H 4600 5050 50  0000 C CNN
	1    4600 5050
	0    1    1    0   
$EndComp
Text Label 4250 5050 0    60   ~ 0
3
Text GLabel 5300 5050 2    60   Input ~ 0
GND0
Text GLabel 5300 4800 2    60   Input ~ 0
GND0
$Comp
L R R5
U 1 1 585229B1
P 5300 5350
F 0 "R5" V 5380 5350 50  0000 C CNN
F 1 "R" V 5300 5350 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 5230 5350 50  0001 C CNN
F 3 "" H 5300 5350 50  0000 C CNN
	1    5300 5350
	0    1    1    0   
$EndComp
$Comp
L SW_PUSH SW1
U 1 1 58522B18
P 4750 5350
F 0 "SW1" H 4900 5460 50  0000 C CNN
F 1 "SW_PUSH" H 4750 5270 50  0000 C CNN
F 2 "Buttons_Switches_SMD:SW_SPST_PTS645" H 4750 5350 50  0001 C CNN
F 3 "" H 4750 5350 50  0000 C CNN
	1    4750 5350
	1    0    0    -1  
$EndComp
Text GLabel 5600 5350 2    60   Input ~ 0
GND1
Text GLabel 4250 5350 0    60   Input ~ 0
VCC
Wire Wire Line
	4700 2800 4400 2800
Wire Wire Line
	4700 2600 4400 2600
Wire Wire Line
	3200 2800 3400 2800
Wire Wire Line
	4900 3750 4900 3550
Wire Wire Line
	4900 4050 4900 4350
Wire Wire Line
	5100 3750 5100 3550
Wire Wire Line
	5750 3750 5750 3550
Wire Wire Line
	5750 4050 5750 4350
Wire Wire Line
	5950 3750 5950 3550
Wire Wire Line
	4250 4800 4450 4800
Wire Wire Line
	5300 4800 5150 4800
Wire Wire Line
	4250 5050 4450 5050
Wire Wire Line
	5300 5050 5150 5050
Wire Wire Line
	4250 5350 4450 5350
Wire Wire Line
	5600 5350 5450 5350
Wire Wire Line
	5050 5350 5150 5350
Text Label 4250 5550 0    60   ~ 0
13
Wire Wire Line
	4250 5550 5100 5550
Wire Wire Line
	5100 5550 5100 5350
Connection ~ 5100 5350
$Comp
L CONN_01X12 P1
U 1 1 585239BC
P 3600 3050
F 0 "P1" H 3600 3700 50  0000 C CNN
F 1 "CONN_01X12" V 3700 3050 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x12" H 3600 3050 50  0001 C CNN
F 3 "" H 3600 3050 50  0000 C CNN
	1    3600 3050
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X12 P2
U 1 1 58523A02
P 4200 3050
F 0 "P2" H 4200 3700 50  0000 C CNN
F 1 "CONN_01X12" V 4300 3050 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x12" H 4200 3050 50  0001 C CNN
F 3 "" H 4200 3050 50  0000 C CNN
	1    4200 3050
	-1   0    0    1   
$EndComp
$EndSCHEMATC
