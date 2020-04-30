EESchema Schematic File Version 4
LIBS:solderStation-cache
EELAYER 30 0
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
$Comp
L solderStation-rescue:MCP3421A0T-E_CH U5
U 1 1 59DDED39
P 7850 1400
F 0 "U5" H 7450 1700 50  0000 L CNN
F 1 "MCP3421A0T-E/CH" H 7950 1700 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23-6_Handsoldering" H 7850 1400 50  0001 C CIN
F 3 "" H 7850 1400 50  0001 C CNN
	1    7850 1400
	1    0    0    -1  
$EndComp
$Comp
L solderStation-rescue:MOC3041M U1
U 1 1 59DDEF33
P 1200 6100
F 0 "U1" H 1000 6300 50  0000 L CNN
F 1 "MOC3041M" H 1200 6300 50  0000 L CNN
F 2 "Housings_DIP:DIP-6_W7.62mm_LongPads" H 1000 5900 50  0001 L CIN
F 3 "" H 1165 6100 50  0001 L CNN
	1    1200 6100
	1    0    0    -1  
$EndComp
$Comp
L solderStation-rescue:Q_NIGBT_ECG Q1
U 1 1 59DDEF72
P 2000 6200
F 0 "Q1" H 1950 6050 50  0000 L CNN
F 1 "bt139-800" H 1950 6500 50  0000 L CNN
F 2 "TO_SOT_Packages_THT:TO-220-3_Horizontal_Reversed" H 2200 6300 50  0001 C CNN
F 3 "" H 2000 6200 50  0001 C CNN
	1    2000 6200
	1    0    0    -1  
$EndComp
$Comp
L solderStation-rescue:R_Small R3
U 1 1 59DDEFBF
P 1800 6000
F 0 "R3" H 1830 6020 50  0000 L CNN
F 1 "360" H 1830 5960 50  0000 L CNN
F 2 "Resistors_ThroughHole:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" H 1800 6000 50  0001 C CNN
F 3 "" H 1800 6000 50  0001 C CNN
	1    1800 6000
	0    1    1    0   
$EndComp
$Comp
L solderStation-rescue:R_Small R2
U 1 1 59DDEFF0
P 1650 6400
F 0 "R2" H 1680 6420 50  0000 L CNN
F 1 "330 (only for sensitive triac) (nc)" H 950 6600 50  0000 L CNN
F 2 "Resistors_ThroughHole:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" H 1650 6400 50  0001 C CNN
F 3 "" H 1650 6400 50  0001 C CNN
	1    1650 6400
	-1   0    0    1   
$EndComp
Wire Wire Line
	1500 6200 1650 6200
Wire Wire Line
	1500 6000 1700 6000
Wire Wire Line
	1900 6000 2100 6000
Wire Wire Line
	1650 6200 1650 6300
Connection ~ 1650 6200
$Comp
L solderStation-rescue:C_Small C1
U 1 1 59DDF09F
P 2400 6350
F 0 "C1" H 2410 6420 50  0000 L CNN
F 1 "10n 270VAC" H 2550 6450 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Rect_L13.0mm_W5.0mm_P10.00mm_FKS3_FKP3_MKS4" H 2400 6350 50  0001 C CNN
F 3 "" H 2400 6350 50  0001 C CNN
	1    2400 6350
	1    0    0    -1  
$EndComp
$Comp
L solderStation-rescue:R_Small R4
U 1 1 59DDF0E5
P 2400 6150
F 0 "R4" H 2430 6170 50  0000 L CNN
F 1 "39" H 2250 6150 50  0000 L CNN
F 2 "Resistors_ThroughHole:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" H 2400 6150 50  0001 C CNN
F 3 "" H 2400 6150 50  0001 C CNN
	1    2400 6150
	-1   0    0    1   
$EndComp
Wire Wire Line
	1650 6500 2100 6500
Wire Wire Line
	2400 6500 2400 6450
Wire Wire Line
	2400 6000 2400 6050
Connection ~ 2100 6000
Wire Wire Line
	2100 6400 2100 6500
Connection ~ 2100 6500
Text Label 3100 6000 0    60   ~ 0
220v_L
Connection ~ 2400 6500
Connection ~ 2400 6000
Text Label 3150 6400 2    60   ~ 0
220v_N
$Comp
L solderStation-rescue:Fuse_Small F1
U 1 1 59DDFC3A
P 4750 6750
F 0 "F1" H 4750 6690 50  0000 C CNN
F 1 "Fuse_Small" H 4750 6810 50  0000 C CNN
F 2 "Fuse_Holders_and_Fuses:Fuseholder5x20_horiz_open_inline_Type-I" H 4750 6750 50  0001 C CNN
F 3 "" H 4750 6750 50  0001 C CNN
	1    4750 6750
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 6750 5350 6750
Text Label 4350 6750 2    60   ~ 0
220v_L
Text Label 4350 6850 2    60   ~ 0
220v_N
Wire Wire Line
	4350 6850 5350 6850
Wire Wire Line
	4350 6750 4650 6750
$Comp
L solderStation-rescue:Conn_01x02 J5
U 1 1 59DE0343
P 5400 7250
F 0 "J5" H 5400 7350 50  0000 C CNN
F 1 "БП" H 5400 7050 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02_Pitch2.54mm" H 5400 7250 50  0001 C CNN
F 3 "" H 5400 7250 50  0001 C CNN
	1    5400 7250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01
U 1 1 59DE0403
P 4900 7350
F 0 "#PWR01" H 4900 7100 50  0001 C CNN
F 1 "GND" H 4900 7200 50  0000 C CNN
F 2 "" H 4900 7350 50  0001 C CNN
F 3 "" H 4900 7350 50  0001 C CNN
	1    4900 7350
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR02
U 1 1 59DE043D
P 4900 7250
F 0 "#PWR02" H 4900 7100 50  0001 C CNN
F 1 "+12V" H 4900 7390 50  0000 C CNN
F 2 "" H 4900 7250 50  0001 C CNN
F 3 "" H 4900 7250 50  0001 C CNN
	1    4900 7250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4900 7350 5200 7350
$Comp
L solderStation-rescue:Conn_01x02 J6
U 1 1 59DE0655
P 5750 7350
F 0 "J6" H 5750 7450 50  0000 C CNN
F 1 "БП_220" H 5750 7150 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02_Pitch2.54mm" H 5750 7350 50  0001 C CNN
F 3 "" H 5750 7350 50  0001 C CNN
	1    5750 7350
	-1   0    0    1   
$EndComp
Text Label 5950 7250 0    60   ~ 0
220v_L
Text Label 5950 7350 0    60   ~ 0
220v_N
$Comp
L power:GND #PWR03
U 1 1 59DE267F
P 5400 6300
F 0 "#PWR03" H 5400 6050 50  0001 C CNN
F 1 "GND" H 5400 6150 50  0000 C CNN
F 2 "" H 5400 6300 50  0001 C CNN
F 3 "" H 5400 6300 50  0001 C CNN
	1    5400 6300
	1    0    0    -1  
$EndComp
$Comp
L solderStation-rescue:C_Small C2
U 1 1 59DE270A
P 4850 6100
F 0 "C2" H 4860 6170 50  0000 L CNN
F 1 "1uf" H 4860 6020 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 4850 6100 50  0001 C CNN
F 3 "" H 4850 6100 50  0001 C CNN
	1    4850 6100
	1    0    0    -1  
$EndComp
$Comp
L solderStation-rescue:C_Small C3
U 1 1 59DE2767
P 5850 6100
F 0 "C3" H 5860 6170 50  0000 L CNN
F 1 "1uf" H 5860 6020 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 5850 6100 50  0001 C CNN
F 3 "" H 5850 6100 50  0001 C CNN
	1    5850 6100
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 6200 4850 6300
Wire Wire Line
	4850 6300 5400 6300
Wire Wire Line
	5850 6300 5850 6200
Connection ~ 5400 6300
Wire Wire Line
	4600 6000 4850 6000
Wire Wire Line
	5700 6000 5850 6000
$Comp
L power:VDD #PWR04
U 1 1 59DE29B7
P 6150 6000
F 0 "#PWR04" H 6150 5850 50  0001 C CNN
F 1 "VDD" H 6150 6150 50  0000 C CNN
F 2 "" H 6150 6000 50  0001 C CNN
F 3 "" H 6150 6000 50  0001 C CNN
	1    6150 6000
	1    0    0    -1  
$EndComp
Connection ~ 5850 6000
$Comp
L power:+12V #PWR05
U 1 1 59DE2B1E
P 4600 6000
F 0 "#PWR05" H 4600 5850 50  0001 C CNN
F 1 "+12V" H 4600 6140 50  0000 C CNN
F 2 "" H 4600 6000 50  0001 C CNN
F 3 "" H 4600 6000 50  0001 C CNN
	1    4600 6000
	1    0    0    -1  
$EndComp
Connection ~ 4850 6000
$Comp
L power:GND #PWR06
U 1 1 59DE2EB2
P 7850 1800
F 0 "#PWR06" H 7850 1550 50  0001 C CNN
F 1 "GND" H 7850 1650 50  0000 C CNN
F 2 "" H 7850 1800 50  0001 C CNN
F 3 "" H 7850 1800 50  0001 C CNN
	1    7850 1800
	1    0    0    -1  
$EndComp
$Comp
L solderStation-rescue:C_Small C4
U 1 1 59DE2F39
P 8050 900
F 0 "C4" H 8060 970 50  0000 L CNN
F 1 "10uf" H 8060 820 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 8050 900 50  0001 C CNN
F 3 "" H 8050 900 50  0001 C CNN
	1    8050 900 
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR07
U 1 1 59DE3020
P 8150 900
F 0 "#PWR07" H 8150 650 50  0001 C CNN
F 1 "GND" H 8150 750 50  0000 C CNN
F 2 "" H 8150 900 50  0001 C CNN
F 3 "" H 8150 900 50  0001 C CNN
	1    8150 900 
	0    -1   -1   0   
$EndComp
$Comp
L power:VDD #PWR08
U 1 1 59DE3064
P 7850 800
F 0 "#PWR08" H 7850 650 50  0001 C CNN
F 1 "VDD" H 7850 950 50  0000 C CNN
F 2 "" H 7850 800 50  0001 C CNN
F 3 "" H 7850 800 50  0001 C CNN
	1    7850 800 
	1    0    0    -1  
$EndComp
Wire Wire Line
	7850 800  7850 900 
Wire Wire Line
	7950 900  7850 900 
Connection ~ 7850 900 
Text Label 7200 1300 2    60   ~ 0
t1
Text Label 7200 1500 2    60   ~ 0
t2
Wire Wire Line
	7200 1300 7350 1300
Wire Wire Line
	7200 1500 7350 1500
Text Label 8450 1400 0    60   ~ 0
sda
Text Label 8450 1300 0    60   ~ 0
scl
Wire Wire Line
	8350 1300 8900 1300
Wire Wire Line
	8350 1400 9100 1400
$Comp
L solderStation-rescue:Q_NMOS_GSD Q2
U 1 1 59DE741A
P 9600 4450
F 0 "Q2" H 9800 4500 50  0000 L CNN
F 1 "Q_NMOS_GSD" H 9800 4400 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:TO-252-2" H 9800 4550 50  0001 C CNN
F 3 "" H 9600 4450 50  0001 C CNN
	1    9600 4450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR09
U 1 1 59DE77B8
P 9700 4750
F 0 "#PWR09" H 9700 4500 50  0001 C CNN
F 1 "GND" H 9700 4600 50  0000 C CNN
F 2 "" H 9700 4750 50  0001 C CNN
F 3 "" H 9700 4750 50  0001 C CNN
	1    9700 4750
	1    0    0    -1  
$EndComp
$Comp
L solderStation-rescue:R_Small R7
U 1 1 59DE782C
P 9200 4450
F 0 "R7" H 9230 4470 50  0000 L CNN
F 1 "100" H 9230 4410 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 9200 4450 50  0001 C CNN
F 3 "" H 9200 4450 50  0001 C CNN
	1    9200 4450
	0    1    1    0   
$EndComp
Wire Wire Line
	9300 4450 9400 4450
Wire Wire Line
	9700 4650 9700 4700
Text Label 8900 4450 2    60   ~ 0
pwm
Wire Wire Line
	8900 4450 9100 4450
$Comp
L power:GND #PWR010
U 1 1 59DE7F65
P 9500 5350
F 0 "#PWR010" H 9500 5100 50  0001 C CNN
F 1 "GND" H 9500 5200 50  0000 C CNN
F 2 "" H 9500 5350 50  0001 C CNN
F 3 "" H 9500 5350 50  0001 C CNN
	1    9500 5350
	0    1    1    0   
$EndComp
$Comp
L power:+36V #PWR011
U 1 1 59DE7FBD
P 10000 5350
F 0 "#PWR011" H 10000 5200 50  0001 C CNN
F 1 "+36V" H 10000 5490 50  0000 C CNN
F 2 "" H 10000 5350 50  0001 C CNN
F 3 "" H 10000 5350 50  0001 C CNN
	1    10000 5350
	0    1    1    0   
$EndComp
Wire Wire Line
	9700 4100 9700 4250
$Comp
L power:+36V #PWR012
U 1 1 59DE8526
P 9650 4000
F 0 "#PWR012" H 9650 3850 50  0001 C CNN
F 1 "+36V" H 9650 4140 50  0000 C CNN
F 2 "" H 9650 4000 50  0001 C CNN
F 3 "" H 9650 4000 50  0001 C CNN
	1    9650 4000
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9700 4000 9650 4000
Text Notes 10100 4400 0    60   ~ 0
irfz44 
$Comp
L solderStation-rescue:R_Small R8
U 1 1 59DE8B75
P 9400 4600
F 0 "R8" H 9430 4620 50  0000 L CNN
F 1 "10k" H 9430 4560 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 9400 4600 50  0001 C CNN
F 3 "" H 9400 4600 50  0001 C CNN
	1    9400 4600
	-1   0    0    1   
$EndComp
Wire Wire Line
	9400 4700 9700 4700
Connection ~ 9700 4700
Wire Wire Line
	9400 4350 9400 4450
$Comp
L solderStation-rescue:R_Small R5
U 1 1 59EDF1AD
P 8900 1200
F 0 "R5" H 8930 1220 50  0000 L CNN
F 1 "10k" H 8930 1160 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 8900 1200 50  0001 C CNN
F 3 "" H 8900 1200 50  0001 C CNN
	1    8900 1200
	-1   0    0    1   
$EndComp
$Comp
L solderStation-rescue:R_Small R6
U 1 1 59EDF49E
P 9100 1250
F 0 "R6" H 9130 1270 50  0000 L CNN
F 1 "10k" H 9130 1210 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 9100 1250 50  0001 C CNN
F 3 "" H 9100 1250 50  0001 C CNN
	1    9100 1250
	-1   0    0    1   
$EndComp
$Comp
L power:VDD #PWR013
U 1 1 59EDF8A4
P 8900 950
F 0 "#PWR013" H 8900 800 50  0001 C CNN
F 1 "VDD" H 8900 1100 50  0000 C CNN
F 2 "" H 8900 950 50  0001 C CNN
F 3 "" H 8900 950 50  0001 C CNN
	1    8900 950 
	1    0    0    -1  
$EndComp
Wire Wire Line
	9100 1400 9100 1350
Wire Wire Line
	8900 950  8900 1000
Wire Wire Line
	8900 1000 9100 1000
Wire Wire Line
	9100 1000 9100 1150
Connection ~ 8900 1000
Text Label 4550 2300 0    60   ~ 0
scl
Text Label 4550 2400 0    60   ~ 0
sda
$Comp
L power:GND #PWR014
U 1 1 59EE034F
P 750 6200
F 0 "#PWR014" H 750 5950 50  0001 C CNN
F 1 "GND" H 750 6050 50  0000 C CNN
F 2 "" H 750 6200 50  0001 C CNN
F 3 "" H 750 6200 50  0001 C CNN
	1    750  6200
	1    0    0    -1  
$EndComp
Wire Wire Line
	750  6200 900  6200
$Comp
L solderStation-rescue:R_Small R1
U 1 1 59EE052B
P 750 5900
F 0 "R1" H 780 5920 50  0000 L CNN
F 1 "200-220" H 780 5860 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 750 5900 50  0001 C CNN
F 3 "" H 750 5900 50  0001 C CNN
	1    750  5900
	-1   0    0    1   
$EndComp
Wire Wire Line
	750  6000 900  6000
Text Label 750  5650 0    60   ~ 0
rele
Wire Wire Line
	750  5650 750  5800
$Comp
L solderStation-rescue:STM8S003F3P U4
U 1 1 59F821D9
P 3250 2400
F 0 "U4" H 2100 3200 50  0000 L CNN
F 1 "STM8S003F3P" H 2100 3100 50  0000 L CNN
F 2 "Housings_SSOP:TSSOP-20_4.4x6.5mm_Pitch0.65mm" H 2100 1600 50  0001 L CIN
F 3 "" H 3200 2000 50  0001 C CNN
	1    3250 2400
	1    0    0    -1  
$EndComp
$Comp
L solderStation-rescue:Conn_02x04_Counter_Clockwise J1
U 1 1 5A4C906C
P 1950 4800
F 0 "J1" H 2000 5000 50  0000 C CNN
F 1 "Conn_02x04_Counter_Clockwise" H 2000 4500 50  0000 C CNN
F 2 "Connectors_Molex:Molex_MiniFit-JR-5569-08A2_2x04x4.20mm_Angled" H 1950 4800 50  0001 C CNN
F 3 "" H 1950 4800 50  0001 C CNN
	1    1950 4800
	1    0    0    -1  
$EndComp
$Comp
L solderStation-rescue:Conn_02x02_Odd_Even J2
U 1 1 5A4C98AF
P 9700 5250
F 0 "J2" H 9750 5450 50  0000 C CNN
F 1 "Conn_02x04_Counter_Clockwise" H 9750 4950 50  0000 C CNN
F 2 "Connectors_Molex:Molex_MiniFit-JR-5569-04A2_2x02x4.20mm_Angled" H 9700 5250 50  0001 C CNN
F 3 "" H 9700 5250 50  0001 C CNN
	1    9700 5250
	1    0    0    -1  
$EndComp
$Comp
L solderStation-rescue:CA56-12EWA U3
U 1 1 5A4D3F40
P 6500 3900
F 0 "U3" H 5550 4350 50  0000 C CNN
F 1 "CA56-12EWA" H 7330 4350 50  0000 C CNN
F 2 "myowndevice:indicator_3cif" H 6500 3300 50  0001 C CNN
F 3 "" H 6120 3930 50  0001 C CNN
	1    6500 3900
	1    0    0    -1  
$EndComp
$Comp
L mylibkicad:LM75AD U6
U 1 1 5A4D48DB
P 9450 2800
F 0 "U6" H 9150 3150 50  0000 L CNN
F 1 "LM75AD" H 9500 3150 50  0000 L CNN
F 2 "Housings_SSOP:SSOP-8_2.95x2.8mm_Pitch0.65mm" H 9350 2800 50  0000 C CIN
F 3 "" H 9350 2800 50  0000 C CNN
	1    9450 2800
	1    0    0    -1  
$EndComp
$Comp
L solderStation-rescue:L7805 U2
U 1 1 5A4D60E1
P 5400 6000
F 0 "U2" H 5250 6125 50  0000 C CNN
F 1 "l78m05" H 5400 6125 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:TO-252-2_Rectifier" H 5425 5850 50  0001 L CIN
F 3 "" H 5400 5950 50  0001 C CNN
	1    5400 6000
	1    0    0    -1  
$EndComp
$Comp
L solderStation-rescue:D_Small D2
U 1 1 5A55F859
P 10200 4050
F 0 "D2" H 10150 4130 50  0000 L CNN
F 1 "1n4002 _ D (n.c.) Нужен только в случае мотора! (для кулера не нужен!)" V 10100 3950 50  0000 L CNN
F 2 "Diodes_SMD:D_MiniMELF" V 10200 4050 50  0001 C CNN
F 3 "" V 10200 4050 50  0001 C CNN
	1    10200 4050
	0    1    1    0   
$EndComp
Wire Wire Line
	9700 4250 10200 4250
Wire Wire Line
	10200 4250 10200 4150
Wire Wire Line
	9700 3750 9700 3850
Wire Wire Line
	9700 3850 10200 3850
Wire Wire Line
	10200 3850 10200 3950
$Comp
L power:GND #PWR015
U 1 1 5A85CF33
P 9450 3250
F 0 "#PWR015" H 9450 3000 50  0001 C CNN
F 1 "GND" H 9450 3100 50  0000 C CNN
F 2 "" H 9450 3250 50  0001 C CNN
F 3 "" H 9450 3250 50  0001 C CNN
	1    9450 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	9450 3200 9450 3250
Wire Wire Line
	9050 2900 9050 2950
Connection ~ 9050 2950
Wire Wire Line
	9050 3200 9450 3200
Connection ~ 9050 3000
Text Label 10050 2600 0    60   ~ 0
sda
Text Label 10050 2700 0    60   ~ 0
scl
Wire Wire Line
	9850 2700 10050 2700
Wire Wire Line
	9850 2600 10050 2600
$Comp
L solderStation-rescue:C_Small C5
U 1 1 5A85D6BB
P 9600 2200
F 0 "C5" H 9610 2270 50  0000 L CNN
F 1 "100n" H 9610 2120 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 9600 2200 50  0001 C CNN
F 3 "" H 9600 2200 50  0001 C CNN
	1    9600 2200
	0    1    1    0   
$EndComp
$Comp
L power:VDD #PWR016
U 1 1 5A85D7B1
P 9450 2100
F 0 "#PWR016" H 9450 1950 50  0001 C CNN
F 1 "VDD" H 9450 2250 50  0000 C CNN
F 2 "" H 9450 2100 50  0001 C CNN
F 3 "" H 9450 2100 50  0001 C CNN
	1    9450 2100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR017
U 1 1 5A85D969
P 9850 2200
F 0 "#PWR017" H 9850 1950 50  0001 C CNN
F 1 "GND" H 9850 2050 50  0000 C CNN
F 2 "" H 9850 2200 50  0001 C CNN
F 3 "" H 9850 2200 50  0001 C CNN
	1    9850 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	9700 2200 9850 2200
Wire Wire Line
	9450 2100 9450 2200
Wire Wire Line
	9500 2200 9450 2200
Connection ~ 9450 2200
Text Label 3250 6400 0    60   ~ 0
ten1
Text Label 3250 6500 0    60   ~ 0
ten2
Wire Wire Line
	3150 6400 3250 6400
Text Label 5350 6850 0    60   ~ 0
220_n
Text Label 5350 6750 0    60   ~ 0
220_l
Text Label 9700 3750 0    60   ~ 0
fan1
Text Label 9800 4100 0    60   ~ 0
fan2
Wire Wire Line
	9800 4100 9700 4100
Connection ~ 9700 3850
$Comp
L power:+12V #PWR018
U 1 1 5A86090B
P 7050 5300
F 0 "#PWR018" H 7050 5150 50  0001 C CNN
F 1 "+12V" H 7050 5440 50  0000 C CNN
F 2 "" H 7050 5300 50  0001 C CNN
F 3 "" H 7050 5300 50  0001 C CNN
	1    7050 5300
	1    0    0    -1  
$EndComp
$Comp
L power:+36V #PWR019
U 1 1 5A860A09
P 7350 5300
F 0 "#PWR019" H 7350 5150 50  0001 C CNN
F 1 "+36V" H 7350 5440 50  0000 C CNN
F 2 "" H 7350 5300 50  0001 C CNN
F 3 "" H 7350 5300 50  0001 C CNN
	1    7350 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	7050 5300 7050 5400
Wire Wire Line
	7050 5400 7350 5400
Wire Wire Line
	7350 5400 7350 5300
$Comp
L solderStation-rescue:D_Small d
U 1 1 5A861126
P 5050 7250
F 0 "d" H 5000 7330 50  0000 L CNN
F 1 "1n4002" H 4900 7170 50  0000 L CNN
F 2 "Diodes_SMD:D_MiniMELF" V 5050 7250 50  0001 C CNN
F 3 "" V 5050 7250 50  0001 C CNN
	1    5050 7250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 7250 5150 7250
Wire Wire Line
	4900 7250 4950 7250
Text Label 9500 5250 2    60   ~ 0
220_l
Text Label 10000 5250 0    60   ~ 0
220_n
Text Label 1750 4700 2    60   ~ 0
ten1
Text Label 1750 5000 2    60   ~ 0
ten2
Text Label 2250 4700 0    60   ~ 0
fan2
Text Label 2250 5000 0    60   ~ 0
fan1
Text Label 2250 4800 0    60   ~ 0
t1
Text Label 2250 4900 0    60   ~ 0
t2
Text Label 1750 4900 2    60   ~ 0
mark1
Text Label 1750 4800 2    60   ~ 0
mark2
Text Label 2100 4100 0    60   ~ 0
mark2
Text Label 2100 4200 0    60   ~ 0
mark1
$Comp
L solderStation-rescue:R_Small R9
U 1 1 5A86486F
P 1900 4100
F 0 "R9" H 1930 4120 50  0000 L CNN
F 1 "5k" H 1950 4050 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 1900 4100 50  0001 C CNN
F 3 "" H 1900 4100 50  0001 C CNN
	1    1900 4100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2000 4100 2100 4100
$Comp
L solderStation-rescue:R_Small R10
U 1 1 5A864B71
P 1900 4200
F 0 "R10" H 1700 4300 50  0000 L CNN
F 1 "5k" H 1750 4200 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 1900 4200 50  0001 C CNN
F 3 "" H 1900 4200 50  0001 C CNN
	1    1900 4200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2000 4200 2100 4200
$Comp
L power:GND #PWR020
U 1 1 5A864C4C
P 1650 4100
F 0 "#PWR020" H 1650 3850 50  0001 C CNN
F 1 "GND" H 1650 3950 50  0000 C CNN
F 2 "" H 1650 4100 50  0001 C CNN
F 3 "" H 1650 4100 50  0001 C CNN
	1    1650 4100
	-1   0    0    1   
$EndComp
Wire Wire Line
	1700 4200 1800 4200
Text Label 1700 4200 2    60   ~ 0
mark
Wire Wire Line
	1650 4100 1800 4100
$Comp
L solderStation-rescue:C_Small C6
U 1 1 5A865E76
P 1750 3100
F 0 "C6" H 1760 3170 50  0000 L CNN
F 1 "10uf" H 1760 3020 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 1750 3100 50  0001 C CNN
F 3 "" H 1750 3100 50  0001 C CNN
	1    1750 3100
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR021
U 1 1 5A865FAF
P 1750 3300
F 0 "#PWR021" H 1750 3050 50  0001 C CNN
F 1 "GND" H 1750 3150 50  0000 C CNN
F 2 "" H 1750 3300 50  0001 C CNN
F 3 "" H 1750 3300 50  0001 C CNN
	1    1750 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1750 3000 1950 3000
Wire Wire Line
	1750 3300 1750 3200
$Comp
L solderStation-rescue:C_Small C8
U 1 1 5A8662F3
P 3350 1450
F 0 "C8" H 3360 1520 50  0000 L CNN
F 1 "1uf" H 3360 1370 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 3350 1450 50  0001 C CNN
F 3 "" H 3350 1450 50  0001 C CNN
	1    3350 1450
	0    -1   -1   0   
$EndComp
$Comp
L solderStation-rescue:C_Small C7
U 1 1 5A866672
P 3350 1250
F 0 "C7" H 3360 1320 50  0000 L CNN
F 1 "100n" H 3360 1170 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 3350 1250 50  0001 C CNN
F 3 "" H 3350 1250 50  0001 C CNN
	1    3350 1250
	0    1    1    0   
$EndComp
Wire Wire Line
	3250 1100 3250 1250
Connection ~ 3250 1450
$Comp
L power:GND #PWR022
U 1 1 5A8669E3
P 3650 1450
F 0 "#PWR022" H 3650 1200 50  0001 C CNN
F 1 "GND" H 3650 1300 50  0000 C CNN
F 2 "" H 3650 1450 50  0001 C CNN
F 3 "" H 3650 1450 50  0001 C CNN
	1    3650 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	3450 1450 3500 1450
Wire Wire Line
	3450 1250 3500 1250
Wire Wire Line
	3500 1250 3500 1450
Connection ~ 3500 1450
$Comp
L power:GND #PWR023
U 1 1 5A866DE6
P 3250 3400
F 0 "#PWR023" H 3250 3150 50  0001 C CNN
F 1 "GND" H 3250 3250 50  0000 C CNN
F 2 "" H 3250 3400 50  0001 C CNN
F 3 "" H 3250 3400 50  0001 C CNN
	1    3250 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	3250 3300 3250 3400
$Comp
L solderStation-rescue:R_Small R15
U 1 1 5A867277
P 7900 4000
F 0 "R15" H 7930 4020 50  0000 L CNN
F 1 "300" H 7930 3960 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 7900 4000 50  0001 C CNN
F 3 "" H 7900 4000 50  0001 C CNN
	1    7900 4000
	0    1    1    0   
$EndComp
$Comp
L solderStation-rescue:R_Small R16
U 1 1 5A867404
P 7900 4100
F 0 "R16" H 7930 4120 50  0000 L CNN
F 1 "300" H 7930 4060 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 7900 4100 50  0001 C CNN
F 3 "" H 7900 4100 50  0001 C CNN
	1    7900 4100
	0    1    1    0   
$EndComp
$Comp
L solderStation-rescue:R_Small R17
U 1 1 5A8674E6
P 7900 4200
F 0 "R17" H 7930 4220 50  0000 L CNN
F 1 "300" H 7930 4160 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 7900 4200 50  0001 C CNN
F 3 "" H 7900 4200 50  0001 C CNN
	1    7900 4200
	0    1    1    0   
$EndComp
Wire Wire Line
	7700 4000 7800 4000
Wire Wire Line
	7800 4100 7700 4100
Wire Wire Line
	7700 4200 7800 4200
Text Label 8150 4000 0    60   ~ 0
c1
Text Label 8150 4100 0    60   ~ 0
c2
Text Label 8150 4200 0    60   ~ 0
c3
Wire Wire Line
	8000 4000 8150 4000
Wire Wire Line
	8150 4100 8000 4100
Wire Wire Line
	8000 4200 8150 4200
Text Label 5200 3600 0    60   ~ 0
a
Text Label 5200 3700 0    60   ~ 0
b
Text Label 5200 3800 0    60   ~ 0
c
Text Label 5200 3900 0    60   ~ 0
d
Text Label 5200 4000 0    60   ~ 0
e
Text Label 5200 4100 0    60   ~ 0
f
Text Label 5200 4200 0    60   ~ 0
g
Text Label 5200 4300 0    60   ~ 0
dp
Wire Wire Line
	5400 4300 5200 4300
Wire Wire Line
	5200 4200 5400 4200
Wire Wire Line
	5400 4100 5200 4100
Wire Wire Line
	5200 4000 5400 4000
Wire Wire Line
	5200 3900 5400 3900
Wire Wire Line
	5400 3800 5200 3800
Wire Wire Line
	5200 3700 5400 3700
Wire Wire Line
	5200 3600 5400 3600
$Comp
L solderStation-rescue:R_Small R11
U 1 1 5A868B35
P 1800 1900
F 0 "R11" H 1830 1920 50  0000 L CNN
F 1 "10k" H 1830 1860 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 1800 1900 50  0001 C CNN
F 3 "" H 1800 1900 50  0001 C CNN
	1    1800 1900
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1900 1900 1950 1900
$Comp
L power:VDD #PWR024
U 1 1 5A868F92
P 3250 1100
F 0 "#PWR024" H 3250 950 50  0001 C CNN
F 1 "VDD" H 3250 1250 50  0000 C CNN
F 2 "" H 3250 1100 50  0001 C CNN
F 3 "" H 3250 1100 50  0001 C CNN
	1    3250 1100
	1    0    0    -1  
$EndComp
$Comp
L power:VDD #PWR025
U 1 1 5A86917E
P 1400 1900
F 0 "#PWR025" H 1400 1750 50  0001 C CNN
F 1 "VDD" H 1400 2050 50  0000 C CNN
F 2 "" H 1400 1900 50  0001 C CNN
F 3 "" H 1400 1900 50  0001 C CNN
	1    1400 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	1700 1900 1400 1900
Connection ~ 3250 1250
$Comp
L solderStation-rescue:Conn_01x01 J3
U 1 1 5A869802
P 1450 2200
F 0 "J3" H 1450 2300 50  0000 C CNN
F 1 "prg" H 1450 2100 50  0000 C CNN
F 2 "myowndevice:wirepad_mini" H 1450 2200 50  0001 C CNN
F 3 "" H 1450 2200 50  0001 C CNN
	1    1450 2200
	-1   0    0    1   
$EndComp
Wire Wire Line
	1650 2200 1750 2200
Text Label 4550 2000 0    60   ~ 0
a
Text Label 1950 2600 2    60   ~ 0
b
Text Label 1950 2300 2    60   ~ 0
c
Text Label 4550 3000 0    60   ~ 0
d
Text Label 4550 2900 0    60   ~ 0
e
Text Label 4550 1900 0    60   ~ 0
f
Text Label 5200 2550 2    60   ~ 0
dp
Text Label 4550 2800 0    60   ~ 0
c1
Text Label 1950 2700 2    60   ~ 0
c2
Text Label 1950 2500 2    60   ~ 0
c3
$Comp
L solderStation-rescue:SW_Push SW1
U 1 1 5A86A6F9
P 5550 900
F 0 "SW1" H 5600 1000 50  0000 L CNN
F 1 "SW_Push" H 5550 840 50  0000 C CNN
F 2 "Buttons_Switches_ThroughHole:SW_PUSH_6mm" H 5550 1100 50  0001 C CNN
F 3 "" H 5550 1100 50  0001 C CNN
	1    5550 900 
	1    0    0    -1  
$EndComp
$Comp
L solderStation-rescue:SW_Push SW2
U 1 1 5A86A8AB
P 5550 1100
F 0 "SW2" H 5600 1200 50  0000 L CNN
F 1 "SW_Push" H 5550 1040 50  0000 C CNN
F 2 "Buttons_Switches_ThroughHole:SW_PUSH_6mm" H 5550 1300 50  0001 C CNN
F 3 "" H 5550 1300 50  0001 C CNN
	1    5550 1100
	1    0    0    -1  
$EndComp
$Comp
L solderStation-rescue:SW_Push SW3
U 1 1 5A86A93B
P 5550 1250
F 0 "SW3" H 5600 1350 50  0000 L CNN
F 1 "SW_Push" H 5550 1190 50  0000 C CNN
F 2 "Buttons_Switches_ThroughHole:SW_PUSH_6mm" H 5550 1450 50  0001 C CNN
F 3 "" H 5550 1450 50  0001 C CNN
	1    5550 1250
	1    0    0    -1  
$EndComp
$Comp
L solderStation-rescue:SW_Push SW4
U 1 1 5A86AA1A
P 5550 1450
F 0 "SW4" H 5600 1550 50  0000 L CNN
F 1 "SW_Push" H 5550 1390 50  0000 C CNN
F 2 "Buttons_Switches_ThroughHole:SW_PUSH_6mm" H 5550 1650 50  0001 C CNN
F 3 "" H 5550 1650 50  0001 C CNN
	1    5550 1450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR026
U 1 1 5A86AB5A
P 5850 900
F 0 "#PWR026" H 5850 650 50  0001 C CNN
F 1 "GND" H 5850 750 50  0000 C CNN
F 2 "" H 5850 900 50  0001 C CNN
F 3 "" H 5850 900 50  0001 C CNN
	1    5850 900 
	0    -1   -1   0   
$EndComp
Text Label 4750 900  2    60   ~ 0
kn
Text Label 4550 2700 0    60   ~ 0
kn
$Comp
L solderStation-rescue:R_Small R14
U 1 1 5A86C1CC
P 4900 1050
F 0 "R14" H 4930 1070 50  0000 L CNN
F 1 "10k" H 4930 1010 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 4900 1050 50  0001 C CNN
F 3 "" H 4900 1050 50  0001 C CNN
	1    4900 1050
	1    0    0    -1  
$EndComp
$Comp
L solderStation-rescue:R_Small R12
U 1 1 5A86CCF3
P 4900 1300
F 0 "R12" H 4930 1320 50  0000 L CNN
F 1 "10k" H 4930 1260 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 4900 1300 50  0001 C CNN
F 3 "" H 4900 1300 50  0001 C CNN
	1    4900 1300
	1    0    0    -1  
$EndComp
$Comp
L solderStation-rescue:R_Small R13
U 1 1 5A86CD9D
P 4900 1550
F 0 "R13" H 4930 1570 50  0000 L CNN
F 1 "10k" H 4930 1510 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 4900 1550 50  0001 C CNN
F 3 "" H 4900 1550 50  0001 C CNN
	1    4900 1550
	1    0    0    -1  
$EndComp
Text Label 1750 2100 2    60   ~ 0
mark
Text Notes 8650 4900 0    60   ~ 0
шимим всегда вместе с семистором
Text Label 1950 2400 2    60   ~ 0
g
Wire Wire Line
	1750 2100 1750 2200
Connection ~ 1750 2200
Text Label 4550 2600 0    60   ~ 0
pwm
Text Label 4550 2100 0    60   ~ 0
rele
Wire Wire Line
	4750 900  4900 900 
Wire Wire Line
	5750 900  5850 900 
Wire Wire Line
	5750 900  5750 1100
Connection ~ 5750 1100
Connection ~ 5750 1250
Connection ~ 4900 900 
Wire Wire Line
	4900 1150 4900 1200
Wire Wire Line
	4900 1400 4900 1450
Wire Wire Line
	5350 1100 5150 1100
Wire Wire Line
	5150 1100 5150 1150
Wire Wire Line
	5150 1150 4900 1150
Wire Wire Line
	5350 1250 5150 1250
Wire Wire Line
	5150 1250 5150 1400
Wire Wire Line
	5150 1400 4900 1400
Wire Wire Line
	5350 1450 5350 1700
Wire Wire Line
	5350 1700 4900 1700
Wire Wire Line
	4900 850  4900 900 
$Comp
L solderStation-rescue:Conn_01x01 J4
U 1 1 5A873DDB
P 6150 5150
F 0 "J4" H 6150 5250 50  0000 C CNN
F 1 "prg" H 6150 5050 50  0000 C CNN
F 2 "myowndevice:wirepadme" H 6150 5150 50  0001 C CNN
F 3 "" H 6150 5150 50  0001 C CNN
	1    6150 5150
	-1   0    0    1   
$EndComp
$Comp
L power:+12V #PWR027
U 1 1 5A874171
P 6350 5150
F 0 "#PWR027" H 6350 5000 50  0001 C CNN
F 1 "+12V" H 6350 5290 50  0000 C CNN
F 2 "" H 6350 5150 50  0001 C CNN
F 3 "" H 6350 5150 50  0001 C CNN
	1    6350 5150
	1    0    0    -1  
$EndComp
$Comp
L solderStation-rescue:Conn_01x01 J7
U 1 1 5A874206
P 6150 5400
F 0 "J7" H 6150 5500 50  0000 C CNN
F 1 "prg" H 6150 5300 50  0000 C CNN
F 2 "myowndevice:wirepadme" H 6150 5400 50  0001 C CNN
F 3 "" H 6150 5400 50  0001 C CNN
	1    6150 5400
	-1   0    0    1   
$EndComp
$Comp
L power:+12V #PWR028
U 1 1 5A8742D8
P 6350 5400
F 0 "#PWR028" H 6350 5250 50  0001 C CNN
F 1 "+12V" H 6350 5540 50  0000 C CNN
F 2 "" H 6350 5400 50  0001 C CNN
F 3 "" H 6350 5400 50  0001 C CNN
	1    6350 5400
	1    0    0    -1  
$EndComp
$Comp
L solderStation-rescue:2N7002 Q3
U 1 1 5A8889F1
P 10600 4450
F 0 "Q3" H 10800 4525 50  0000 L CNN
F 1 "2N7002" H 10800 4450 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 10800 4375 50  0001 L CIN
F 3 "" H 10600 4450 50  0001 L CNN
	1    10600 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	10700 4700 10700 4650
Connection ~ 10200 4250
Text Label 9400 4350 0    60   ~ 0
gate
Connection ~ 9400 4450
Text Label 10400 4450 2    60   ~ 0
gate
$Comp
L solderStation-rescue:R_Small R18
U 1 1 5A8AC347
P 4900 750
F 0 "R18" H 4930 770 50  0000 L CNN
F 1 "10k" H 4930 710 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 4900 750 50  0001 C CNN
F 3 "" H 4900 750 50  0001 C CNN
	1    4900 750 
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 1700 4900 1650
$Comp
L power:VDD #PWR029
U 1 1 5A8ACD51
P 4900 650
F 0 "#PWR029" H 4900 500 50  0001 C CNN
F 1 "VDD" H 4900 800 50  0000 C CNN
F 2 "" H 4900 650 50  0001 C CNN
F 3 "" H 4900 650 50  0001 C CNN
	1    4900 650 
	1    0    0    -1  
$EndComp
NoConn ~ 9850 3000
Wire Wire Line
	1650 6200 1800 6200
Wire Wire Line
	2100 6000 2400 6000
Wire Wire Line
	2100 6500 2400 6500
Wire Wire Line
	2400 6500 3250 6500
Wire Wire Line
	2400 6000 3100 6000
Wire Wire Line
	5400 6300 5850 6300
Wire Wire Line
	5850 6000 6150 6000
Wire Wire Line
	4850 6000 5100 6000
Wire Wire Line
	7850 900  7850 1000
Wire Wire Line
	9700 4700 9700 4750
Wire Wire Line
	9700 4700 10700 4700
Wire Wire Line
	8900 1000 8900 1100
Wire Wire Line
	9050 2950 9050 3000
Wire Wire Line
	9050 3000 9050 3200
Wire Wire Line
	9450 2200 9450 2400
Wire Wire Line
	9700 3850 9700 4000
Wire Wire Line
	3250 1450 3250 1600
Wire Wire Line
	3500 1450 3650 1450
Wire Wire Line
	3250 1250 3250 1450
Wire Wire Line
	1750 2200 1950 2200
Wire Wire Line
	5750 1100 5750 1250
Wire Wire Line
	5750 1250 5750 1450
Wire Wire Line
	4900 900  5350 900 
Wire Wire Line
	4900 900  4900 950 
Wire Wire Line
	10200 4250 10700 4250
Wire Wire Line
	9400 4450 9400 4500
$EndSCHEMATC
