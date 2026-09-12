# **STM8_TV_TRANSMITTER**
My first experiments with bare metal programming on STM8. With SPL from ST I wouldn´t be able to fit whole code in the chip. I also took alot of inspiration from various websites and forums, so for these have look at credits. RF modulator used accepts analog video and audio inputs and gives RF out power around 82 dBuV max on 75 ohm (2.11 µW/-26.75 dBm). RF amplifier gives the low power signal some boost (~40 dB) to get to mW range (<30 mW). With good antenna this signal should reach atleast few tenths of meters. TV channels are configured for east european analog TV standard frequencies, not american!
> [!WARNING]
> RF modulator, when amplified, breaks RF laws in some countries, like Czechia (ČTÚ limits). I´m not responsible for any interference with public services or radio stations. Analog TV signals are quite wide on the spectrum and also noisy, so be careful!
## **Default pins and connections**
- button pins are adjustable in main.c, display connections in display .header file, software i2c pins in swi2c .header file. I you want to change them, follow the proper definitions (port a as PA and pin 
 as PIN2 for example)
- RF modulator RF out to RF amp input, RF amp output to proper antenna, like uhf folded dipole to give maximum range. Or you can just connect RF modulator output directly to TV and set desired channel or frequency
## **Images**
## **Libraries and header files used**
- My [PT6311/PT6315](https://github.com/bababooex/STM8_PT6311_LIBRARY) library to control the VFD display
- MBS74T1AEF (MC44BS374T1) [RF modulator](https://github.com/tom2238/arduino-mc44bs374t1) library from Arduino, rewritten for STM8 compatibility with AIs help
- [Register tables](https://github.com/jukkas/stm8-sdcc-examples/blob/master/stm8.h) for stm8s103 + with some additions from me
## **Credits**
- Russian forum [VRTP.RU](https://vrtp.ru/) for project inspiration and control + software behavior, my device tries to be similar like described [here](https://vrtp.ru/index.php?act=categories&CODE=article&article=3650)
- @tom2238 for his arduino code
- @jukkas for his register table that I didn´t have to create from scratch
