   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
  15                     	bsct
  16  0000               L3_tim4_ms_counter:
  17  0000 00000000      	dc.l	0
  18  0004               _mod_frequency:
  19  0004 000730d2      	dc.l	471250
  20                     .bit:	section	.data,bit
  21  0000               _ps_ratio:
  22  0000 00            	dc.b	0
  23  0001               _tpen:
  24  0001 00            	dc.b	0
  25  0002               _pwc:
  26  0002 00            	dc.b	0
  27                     	bsct
  28  0008               _last_channel:
  29  0008 15            	dc.b	21
  30  0009               _sound:
  31  0009 03            	dc.b	3
  32                     	switch	.bit
  33  0003               _change_tracker:
  34  0003 00            	dc.b	0
  64                     ; 134 @far @interrupt void timer4_isr(void)
  64                     ; 135 {
  65                     .text:	section	.text,new
  66  0000               f_timer4_isr:
  70                     ; 136     ++tim4_ms_counter; 
  72  0000 ae0000        	ldw	x,#L3_tim4_ms_counter
  73  0003 a601          	ld	a,#1
  74  0005 cd0000        	call	c_lgadc
  76                     ; 137     TIM4_SR &= (uint8_t)(~TIM_SR1_UIF);
  78  0008 72115344      	bres	21316,#0
  79                     ; 138 }
  82  000c 80            	iret
 128                     ; 140 void main(void)
 128                     ; 141 {
 130                     .text:	section	.text,new
 131  0000               _main:
 135                     ; 142 		clock_setup();//init main clock + timer
 137  0000 cd0000        	call	_clock_setup
 139                     ; 143 		tim4_isr_setup();//nonblocking delay
 141  0003 cd0000        	call	_tim4_isr_setup
 143                     ; 144 		btn_init();
 145  0006 cd0000        	call	_btn_init
 147                     ; 145 		button_accel_init(&up_btn);
 149  0009 ae0019        	ldw	x,#_up_btn
 150  000c cd0000        	call	_button_accel_init
 152                     ; 146 		button_accel_init(&down_btn);
 154  000f ae0008        	ldw	x,#_down_btn
 155  0012 cd0000        	call	_button_accel_init
 157                     ; 147 		button_simple_init(&status_btn);
 159  0015 ae0002        	ldw	x,#_status_btn
 160  0018 cd0000        	call	_button_simple_init
 162                     ; 148 		pt6311_init(9);
 164  001b a609          	ld	a,#9
 165  001d cd0000        	call	_pt6311_init
 167                     ; 149 		pt6311_set_display_state(PT6311_DISPLAY_ON);//prevent bugs
 169  0020 a608          	ld	a,#8
 170  0022 cd0000        	call	_pt6311_set_display_state
 172                     ; 150 		for (i = 1; i < 10; i++)
 174  0025 35010001      	mov	_i,#1
 175  0029               L33:
 176                     ; 152         pt6311_write_digit(i, 0xFFFFFF); 
 178  0029 aeffff        	ldw	x,#65535
 179  002c 89            	pushw	x
 180  002d ae00ff        	ldw	x,#255
 181  0030 89            	pushw	x
 182  0031 b601          	ld	a,_i
 183  0033 cd0000        	call	_pt6311_write_digit
 185  0036 5b04          	addw	sp,#4
 186                     ; 153 				delay_ms(200);
 188  0038 ae00c8        	ldw	x,#200
 189  003b cd0000        	call	_delay_ms
 191                     ; 150 		for (i = 1; i < 10; i++)
 193  003e 3c01          	inc	_i
 196  0040 b601          	ld	a,_i
 197  0042 a10a          	cp	a,#10
 198  0044 25e3          	jrult	L33
 199                     ; 155 		delay_ms(300);
 201  0046 ae012c        	ldw	x,#300
 202  0049 cd0000        	call	_delay_ms
 204                     ; 156 		pt6311_clear_display();
 206  004c cd0000        	call	_pt6311_clear_display
 208                     ; 157 		pt6311_write_string(1,"TVTXV1-0 ");
 210  004f ae008b        	ldw	x,#L14
 211  0052 89            	pushw	x
 212  0053 a601          	ld	a,#1
 213  0055 cd0000        	call	_pt6311_write_string
 215  0058 85            	popw	x
 216                     ; 158 		delay_ms(1200);
 218  0059 ae04b0        	ldw	x,#1200
 219  005c cd0000        	call	_delay_ms
 221                     ; 159 		pt6311_clear_display();	
 223  005f cd0000        	call	_pt6311_clear_display
 225                     ; 160 		swi2c_init();
 227  0062 cd0000        	call	_swi2c_init
 229                     ; 161 		RFModulator_Init(&mod, MC44BS374T1_ADDR);//start with defaults
 231  0065 4bca          	push	#202
 232  0067 ae002a        	ldw	x,#_mod
 233  006a cd0000        	call	_RFModulator_Init
 235  006d 84            	pop	a
 236                     ; 162 		memory_handler(0); //load last data
 238  006e 4f            	clr	a
 239  006f cd0000        	call	_memory_handler
 241                     ; 163 		current_screen = frequency_state;//force current screen
 243  0072 3f37          	clr	_current_screen
 244                     ; 165 		pt6311_write_string(1,"F");
 246  0074 ae0089        	ldw	x,#L34
 247  0077 89            	pushw	x
 248  0078 a601          	ld	a,#1
 249  007a cd0000        	call	_pt6311_write_string
 251  007d 85            	popw	x
 252                     ; 166 		freq_visuals(mod_frequency);
 254  007e be06          	ldw	x,_mod_frequency+2
 255  0080 89            	pushw	x
 256  0081 be04          	ldw	x,_mod_frequency
 257  0083 89            	pushw	x
 258  0084 cd0000        	call	_freq_visuals
 260  0087 5b04          	addw	sp,#4
 261  0089               L54:
 262                     ; 168 			update_screen();
 264  0089 cd0000        	call	_update_screen
 266                     ; 169 			check_st_button();
 268  008c cd0000        	call	_check_st_button
 271  008f 20f8          	jra	L54
 294                     ; 172 void btn_init(void){//init three buttons as pu no it
 295                     .text:	section	.text,new
 296  0000               _btn_init:
 300                     ; 173 		PORT(UP_BTN_PORT, DDR) &= ~UP_BTN_PIN;
 302  0000 7219500c      	bres	20492,#4
 303                     ; 174     PORT(UP_BTN_PORT, CR1) |= UP_BTN_PIN;
 305  0004 7218500d      	bset	20493,#4
 306                     ; 175     PORT(UP_BTN_PORT, CR2) &= ~UP_BTN_PIN;
 308  0008 7219500e      	bres	20494,#4
 309                     ; 176 		PORT(DOWN_BTN_PORT, DDR) &= ~DOWN_BTN_PIN;
 311  000c 72175002      	bres	20482,#3
 312                     ; 177     PORT(DOWN_BTN_PORT, CR1) |= DOWN_BTN_PIN;
 314  0010 72165003      	bset	20483,#3
 315                     ; 178     PORT(DOWN_BTN_PORT, CR2) &= ~DOWN_BTN_PIN;
 317  0014 72175004      	bres	20484,#3
 318                     ; 179 		PORT(STATUS_BTN_PORT, DDR) &= ~STATUS_BTN_PIN;
 320  0018 7217500c      	bres	20492,#3
 321                     ; 180     PORT(STATUS_BTN_PORT, CR1) |= STATUS_BTN_PIN;
 323  001c 7216500d      	bset	20493,#3
 324                     ; 181     PORT(STATUS_BTN_PORT, CR2) &= ~STATUS_BTN_PIN;
 326  0020 7217500e      	bres	20494,#3
 327                     ; 182 }
 330  0024 81            	ret
 353                     ; 184 static void eeprom_unlock(void)
 353                     ; 185 {
 354                     .text:	section	.text,new
 355  0000               L16_eeprom_unlock:
 359                     ; 186     if (!(FLASH_IAPSR & FLASH_IAPSR_DUL)) {
 361  0000 c6505f        	ld	a,20575
 362  0003 a508          	bcp	a,#8
 363  0005 260f          	jrne	L37
 364                     ; 187         FLASH_DUKR = FLASH_DUKR_KEY1;
 366  0007 35ae5064      	mov	20580,#174
 367                     ; 188         FLASH_DUKR = FLASH_DUKR_KEY2;
 369  000b 35565064      	mov	20580,#86
 371  000f               L101:
 372                     ; 190         while (!(FLASH_IAPSR & FLASH_IAPSR_DUL));
 374  000f c6505f        	ld	a,20575
 375  0012 a508          	bcp	a,#8
 376  0014 27f9          	jreq	L101
 377  0016               L37:
 378                     ; 192 }
 381  0016 81            	ret
 404                     ; 193 static void eeprom_lock(void)
 404                     ; 194 {
 405                     .text:	section	.text,new
 406  0000               L501_eeprom_lock:
 410                     ; 195     FLASH_IAPSR &= (uint8_t)~FLASH_IAPSR_DUL;
 412  0000 7217505f      	bres	20575,#3
 413                     ; 196 }
 416  0004 81            	ret
 461                     ; 197 static void eeprom_write_byte(uint16_t addr, uint8_t value)
 461                     ; 198 {
 462                     .text:	section	.text,new
 463  0000               L711_eeprom_write_byte:
 465  0000 89            	pushw	x
 466       00000000      OFST:	set	0
 469                     ; 199     eeprom_unlock();
 471  0001 cd0000        	call	L16_eeprom_unlock
 473                     ; 201     *(volatile uint8_t *)addr = value;
 475  0004 7b05          	ld	a,(OFST+5,sp)
 476  0006 1e01          	ldw	x,(OFST+1,sp)
 477  0008 f7            	ld	(x),a
 479  0009               L741:
 480                     ; 203     while (!(FLASH_IAPSR & FLASH_IAPSR_EOP));
 482  0009 c6505f        	ld	a,20575
 483  000c a504          	bcp	a,#4
 484  000e 27f9          	jreq	L741
 485                     ; 205     eeprom_lock();
 487  0010 cd0000        	call	L501_eeprom_lock
 489                     ; 206 }
 492  0013 85            	popw	x
 493  0014 81            	ret
 527                     ; 207 static uint8_t eeprom_read_byte(uint16_t addr)
 527                     ; 208 {
 528                     .text:	section	.text,new
 529  0000               L351_eeprom_read_byte:
 533                     ; 209     return *(volatile uint8_t *)addr;
 535  0000 f6            	ld	a,(x)
 538  0001 81            	ret
 602                     ; 211 static void eeprom_write(uint16_t addr, const uint8_t *data, uint8_t len)
 602                     ; 212 {
 603                     .text:	section	.text,new
 604  0000               L371_eeprom_write:
 606  0000 89            	pushw	x
 607  0001 88            	push	a
 608       00000001      OFST:	set	1
 611                     ; 215     eeprom_unlock();
 613  0002 cd0000        	call	L16_eeprom_unlock
 615                     ; 217     for (i = 0; i < len; i++) {
 617  0005 0f01          	clr	(OFST+0,sp)
 620  0007 201c          	jra	L332
 621  0009               L722:
 622                     ; 218         *(volatile uint8_t *)addr++ = data[i];
 624  0009 7b01          	ld	a,(OFST+0,sp)
 625  000b 5f            	clrw	x
 626  000c 97            	ld	xl,a
 627  000d 72fb06        	addw	x,(OFST+5,sp)
 628  0010 f6            	ld	a,(x)
 629  0011 1e02          	ldw	x,(OFST+1,sp)
 630  0013 1c0001        	addw	x,#1
 631  0016 1f02          	ldw	(OFST+1,sp),x
 632  0018 1d0001        	subw	x,#1
 633  001b f7            	ld	(x),a
 635  001c               L342:
 636                     ; 220         while (!(FLASH_IAPSR & FLASH_IAPSR_EOP));
 638  001c c6505f        	ld	a,20575
 639  001f a504          	bcp	a,#4
 640  0021 27f9          	jreq	L342
 641                     ; 217     for (i = 0; i < len; i++) {
 643  0023 0c01          	inc	(OFST+0,sp)
 645  0025               L332:
 648  0025 7b01          	ld	a,(OFST+0,sp)
 649  0027 1108          	cp	a,(OFST+7,sp)
 650  0029 25de          	jrult	L722
 651                     ; 223     eeprom_lock();
 653  002b cd0000        	call	L501_eeprom_lock
 655                     ; 224 }
 658  002e 5b03          	addw	sp,#3
 659  0030 81            	ret
 721                     ; 225 static void eeprom_read(uint16_t addr, uint8_t *data, uint8_t len)
 721                     ; 226 {
 722                     .text:	section	.text,new
 723  0000               L742_eeprom_read:
 725  0000 89            	pushw	x
 726  0001 88            	push	a
 727       00000001      OFST:	set	1
 730                     ; 229     for (i = 0; i < len; i++) {
 732  0002 0f01          	clr	(OFST+0,sp)
 735  0004 2018          	jra	L703
 736  0006               L303:
 737                     ; 230         data[i] = *(volatile uint8_t *)addr++;
 739  0006 7b01          	ld	a,(OFST+0,sp)
 740  0008 5f            	clrw	x
 741  0009 97            	ld	xl,a
 742  000a 72fb06        	addw	x,(OFST+5,sp)
 743  000d 1602          	ldw	y,(OFST+1,sp)
 744  000f 72a90001      	addw	y,#1
 745  0013 1702          	ldw	(OFST+1,sp),y
 746  0015 72a20001      	subw	y,#1
 747  0019 90f6          	ld	a,(y)
 748  001b f7            	ld	(x),a
 749                     ; 229     for (i = 0; i < len; i++) {
 751  001c 0c01          	inc	(OFST+0,sp)
 753  001e               L703:
 756  001e 7b01          	ld	a,(OFST+0,sp)
 757  0020 1108          	cp	a,(OFST+7,sp)
 758  0022 25e2          	jrult	L303
 759                     ; 232 }
 762  0024 5b03          	addw	sp,#3
 763  0026 81            	ret
 863                     .const:	section	.text
 864  0000               L44:
 865  0000 0000afc8      	dc.l	45000
 866  0004               L64:
 867  0004 000d6d81      	dc.l	880001
 868                     ; 234 void memory_handler(bool write) {
 869                     .text:	section	.text,new
 870  0000               _memory_handler:
 872  0000 88            	push	a
 873  0001 5208          	subw	sp,#8
 874       00000008      OFST:	set	8
 877                     ; 236 	if (write){
 879  0003 7b09          	ld	a,(OFST+1,sp)
 880  0005 a501          	bcp	a,#1
 881  0007 2747          	jreq	L353
 882                     ; 237     M.frequency = (uint32_t) mod_frequency;
 884  0009 be06          	ldw	x,_mod_frequency+2
 885  000b 1f03          	ldw	(OFST-5,sp),x
 886  000d be04          	ldw	x,_mod_frequency
 887  000f 1f01          	ldw	(OFST-7,sp),x
 889                     ; 238     M.ps_ratio  = (bool)ps_ratio;
 891                     	btst	_ps_ratio
 892  0016 2404          	jruge	L03
 893  0018 a601          	ld	a,#1
 894  001a 2001          	jra	L23
 895  001c               L03:
 896  001c 4f            	clr	a
 897  001d               L23:
 898  001d 6b05          	ld	(OFST-3,sp),a
 900                     ; 239     M.tpen      = (bool)tpen;
 902                     	btst	_tpen
 903  0024 2404          	jruge	L43
 904  0026 a601          	ld	a,#1
 905  0028 2001          	jra	L63
 906  002a               L43:
 907  002a 4f            	clr	a
 908  002b               L63:
 909  002b 6b06          	ld	(OFST-2,sp),a
 911                     ; 240     M.pwc       = (bool)pwc;
 913                     	btst	_pwc
 914  0032 2404          	jruge	L04
 915  0034 a601          	ld	a,#1
 916  0036 2001          	jra	L24
 917  0038               L04:
 918  0038 4f            	clr	a
 919  0039               L24:
 920  0039 6b07          	ld	(OFST-1,sp),a
 922                     ; 241     M.sound     = (uint8_t)sound;
 924  003b b609          	ld	a,_sound
 925  003d 6b08          	ld	(OFST+0,sp),a
 927                     ; 242     eeprom_write(EEPROM_START,
 927                     ; 243                  (uint8_t *)&M,
 927                     ; 244                  sizeof(Data_Memory));
 929  003f 4b08          	push	#8
 930  0041 96            	ldw	x,sp
 931  0042 1c0002        	addw	x,#OFST-6
 932  0045 89            	pushw	x
 933  0046 ae4000        	ldw	x,#16384
 934  0049 cd0000        	call	L371_eeprom_write
 936  004c 5b03          	addw	sp,#3
 938  004e 205d          	jra	L553
 939  0050               L353:
 940                     ; 247     eeprom_read(EEPROM_START,
 940                     ; 248                 (uint8_t *)&M,
 940                     ; 249                 sizeof(Data_Memory));
 942  0050 4b08          	push	#8
 943  0052 96            	ldw	x,sp
 944  0053 1c0002        	addw	x,#OFST-6
 945  0056 89            	pushw	x
 946  0057 ae4000        	ldw	x,#16384
 947  005a cd0000        	call	L742_eeprom_read
 949  005d 5b03          	addw	sp,#3
 950                     ; 250 		if (M.frequency < RF_FREQ_MIN_KHZ ||//some validation here
 950                     ; 251         M.frequency > RF_FREQ_MAX_KHZ ||
 950                     ; 252         M.sound > DK_6_5MHZ) {
 952  005f 96            	ldw	x,sp
 953  0060 1c0001        	addw	x,#OFST-7
 954  0063 cd0000        	call	c_ltor
 956  0066 ae0000        	ldw	x,#L44
 957  0069 cd0000        	call	c_lcmp
 959  006c 2515          	jrult	L163
 961  006e 96            	ldw	x,sp
 962  006f 1c0001        	addw	x,#OFST-7
 963  0072 cd0000        	call	c_ltor
 965  0075 ae0004        	ldw	x,#L64
 966  0078 cd0000        	call	c_lcmp
 968  007b 2406          	jruge	L163
 970  007d 7b08          	ld	a,(OFST+0,sp)
 971  007f a104          	cp	a,#4
 972  0081 252d          	jrult	L753
 973  0083               L163:
 974                     ; 253 				mod_frequency = 471250;
 976  0083 ae30d2        	ldw	x,#12498
 977  0086 bf06          	ldw	_mod_frequency+2,x
 978  0088 ae0007        	ldw	x,#7
 979  008b bf04          	ldw	_mod_frequency,x
 980                     ; 254         ps_ratio = 0;
 982  008d 72110000      	bres	_ps_ratio
 983                     ; 255         tpen = 0;
 985  0091 72110001      	bres	_tpen
 986                     ; 256         pwc = 0;
 988  0095 72110002      	bres	_pwc
 989                     ; 257         sound = DK_6_5MHZ;
 991  0099 35030009      	mov	_sound,#3
 992                     ; 258         RFModulator_SetFrequency(&mod, mod_frequency);
 994  009d ae30d2        	ldw	x,#12498
 995  00a0 89            	pushw	x
 996  00a1 ae0007        	ldw	x,#7
 997  00a4 89            	pushw	x
 998  00a5 ae002a        	ldw	x,#_mod
 999  00a8 cd0000        	call	_RFModulator_SetFrequency
1001  00ab 5b04          	addw	sp,#4
1003  00ad               L553:
1004                     ; 274 }
1007  00ad 5b09          	addw	sp,#9
1008  00af 81            	ret
1009  00b0               L753:
1010                     ; 261         mod_frequency = M.frequency;
1012  00b0 1e03          	ldw	x,(OFST-5,sp)
1013  00b2 bf06          	ldw	_mod_frequency+2,x
1014  00b4 1e01          	ldw	x,(OFST-7,sp)
1015  00b6 bf04          	ldw	_mod_frequency,x
1016                     ; 262         ps_ratio = M.ps_ratio;
1018  00b8 0d05          	tnz	(OFST-3,sp)
1019  00ba 2602          	jrne	L46
1020  00bc 2006          	jp	L05
1021  00be               L46:
1022  00be 72100000      	bset	_ps_ratio
1023  00c2 2004          	jra	L25
1024  00c4               L05:
1025  00c4 72110000      	bres	_ps_ratio
1026  00c8               L25:
1027                     ; 263         tpen     = M.tpen;
1029  00c8 0d06          	tnz	(OFST-2,sp)
1030  00ca 2602          	jrne	L66
1031  00cc 2006          	jp	L45
1032  00ce               L66:
1033  00ce 72100001      	bset	_tpen
1034  00d2 2004          	jra	L65
1035  00d4               L45:
1036  00d4 72110001      	bres	_tpen
1037  00d8               L65:
1038                     ; 264         pwc      = M.pwc;
1040  00d8 0d07          	tnz	(OFST-1,sp)
1041  00da 2602          	jrne	L07
1042  00dc 2006          	jp	L06
1043  00de               L07:
1044  00de 72100002      	bset	_pwc
1045  00e2 2004          	jra	L26
1046  00e4               L06:
1047  00e4 72110002      	bres	_pwc
1048  00e8               L26:
1049                     ; 265         sound    = (RFMod_sound_system)M.sound;
1051  00e8 7b08          	ld	a,(OFST+0,sp)
1052  00ea b709          	ld	_sound,a
1053                     ; 267         RFModulator_SetFrequency(&mod, mod_frequency);
1055  00ec be06          	ldw	x,_mod_frequency+2
1056  00ee 89            	pushw	x
1057  00ef be04          	ldw	x,_mod_frequency
1058  00f1 89            	pushw	x
1059  00f2 ae002a        	ldw	x,#_mod
1060  00f5 cd0000        	call	_RFModulator_SetFrequency
1062  00f8 5b04          	addw	sp,#4
1063                     ; 268         RFModulator_SetPictureSoundRatio(&mod, ps_ratio);
1065  00fa 4f            	clr	a
1066                     	btst	_ps_ratio
1067  0100 49            	rlc	a
1068  0101 88            	push	a
1069  0102 ae002a        	ldw	x,#_mod
1070  0105 cd0000        	call	_RFModulator_SetPictureSoundRatio
1072  0108 84            	pop	a
1073                     ; 269         RFModulator_SetSoundSubcarrier(&mod, sound);
1075  0109 3b0009        	push	_sound
1076  010c ae002a        	ldw	x,#_mod
1077  010f cd0000        	call	_RFModulator_SetSoundSubcarrier
1079  0112 84            	pop	a
1080                     ; 270         RFModulator_SetPeakWhiteClip(&mod, pwc);
1082  0113 4f            	clr	a
1083                     	btst	_pwc
1084  0119 49            	rlc	a
1085  011a 88            	push	a
1086  011b ae002a        	ldw	x,#_mod
1087  011e cd0000        	call	_RFModulator_SetPeakWhiteClip
1089  0121 84            	pop	a
1090                     ; 271         RFModulator_SetTestPattern(&mod, tpen);
1092  0122 4f            	clr	a
1093                     	btst	_tpen
1094  0128 49            	rlc	a
1095  0129 88            	push	a
1096  012a ae002a        	ldw	x,#_mod
1097  012d cd0000        	call	_RFModulator_SetTestPattern
1099  0130 84            	pop	a
1100  0131 cc00ad        	jra	L553
1124                     ; 275 static void question_writer(void){//write ?
1125                     .text:	section	.text,new
1126  0000               L763_question_writer:
1130                     ; 276 		pt6311_write_digit(6, 0x1051);
1132  0000 ae1051        	ldw	x,#4177
1133  0003 89            	pushw	x
1134  0004 ae0000        	ldw	x,#0
1135  0007 89            	pushw	x
1136  0008 a606          	ld	a,#6
1137  000a cd0000        	call	_pt6311_write_digit
1139  000d 5b04          	addw	sp,#4
1140                     ; 277 		pt6311_write_digit(7, 0x000000);
1142  000f ae0000        	ldw	x,#0
1143  0012 89            	pushw	x
1144  0013 ae0000        	ldw	x,#0
1145  0016 89            	pushw	x
1146  0017 a607          	ld	a,#7
1147  0019 cd0000        	call	_pt6311_write_digit
1149  001c 5b04          	addw	sp,#4
1150                     ; 278 }
1153  001e 81            	ret
1184                     ; 280 void memory_screen(void){
1185                     .text:	section	.text,new
1186  0000               _memory_screen:
1190                     ; 281 	if (!change_tracker){
1192                     	btst	_change_tracker
1193  0005 2511          	jrult	L114
1194                     ; 282 			pt6311_write_string(1,"SAVE ");
1196  0007 ae0083        	ldw	x,#L314
1197  000a 89            	pushw	x
1198  000b a601          	ld	a,#1
1199  000d cd0000        	call	_pt6311_write_string
1201  0010 85            	popw	x
1202                     ; 283 			question_writer();
1204  0011 cd0000        	call	L763_question_writer
1206                     ; 284 			change_tracker=true;
1208  0014 72100003      	bset	_change_tracker
1209  0018               L114:
1210                     ; 286     if (button_accel_check(UP_BTN_READ(), &up_btn)) {
1212  0018 ae0019        	ldw	x,#_up_btn
1213  001b 89            	pushw	x
1214  001c c6500b        	ld	a,20491
1215  001f a510          	bcp	a,#16
1216  0021 2704          	jreq	L67
1217  0023 a601          	ld	a,#1
1218  0025 2001          	jra	L001
1219  0027               L67:
1220  0027 4f            	clr	a
1221  0028               L001:
1222  0028 cd0000        	call	_button_accel_check
1224  002b 85            	popw	x
1225  002c 4d            	tnz	a
1226  002d 273e          	jreq	L514
1227                     ; 287         memory_handler(1);
1229  002f a601          	ld	a,#1
1230  0031 cd0000        	call	_memory_handler
1232                     ; 289 				pt6311_write_string(6,"OK");
1234  0034 ae0080        	ldw	x,#L714
1235  0037 89            	pushw	x
1236  0038 a606          	ld	a,#6
1237  003a cd0000        	call	_pt6311_write_string
1239  003d 85            	popw	x
1240                     ; 290 				pt6311_write_digit(0, 128);
1242  003e ae0080        	ldw	x,#128
1243  0041 89            	pushw	x
1244  0042 ae0000        	ldw	x,#0
1245  0045 89            	pushw	x
1246  0046 4f            	clr	a
1247  0047 cd0000        	call	_pt6311_write_digit
1249  004a 5b04          	addw	sp,#4
1250                     ; 291 				delay_ms(300);
1252  004c ae012c        	ldw	x,#300
1253  004f cd0000        	call	_delay_ms
1255                     ; 292 				pt6311_write_string(1,"SAVE");
1257  0052 ae007b        	ldw	x,#L124
1258  0055 89            	pushw	x
1259  0056 a601          	ld	a,#1
1260  0058 cd0000        	call	_pt6311_write_string
1262  005b 85            	popw	x
1263                     ; 293 				question_writer();
1265  005c cd0000        	call	L763_question_writer
1267                     ; 294 				pt6311_write_digit(0, 0x000000);
1269  005f ae0000        	ldw	x,#0
1270  0062 89            	pushw	x
1271  0063 ae0000        	ldw	x,#0
1272  0066 89            	pushw	x
1273  0067 4f            	clr	a
1274  0068 cd0000        	call	_pt6311_write_digit
1276  006b 5b04          	addw	sp,#4
1277  006d               L514:
1278                     ; 296 }
1281  006d 81            	ret
1374                     ; 298 void button_accel_init(ButtonAccel *btn) {
1375                     .text:	section	.text,new
1376  0000               _button_accel_init:
1380                     ; 299     btn->last_raw = 1;
1382  0000 a601          	ld	a,#1
1383  0002 f7            	ld	(x),a
1384                     ; 300     btn->stable = 1;
1386  0003 a601          	ld	a,#1
1387  0005 e701          	ld	(1,x),a
1388                     ; 301     btn->pressed = 0;
1390  0007 6f02          	clr	(2,x)
1391                     ; 302     btn->debounce_start = 0;
1393  0009 a600          	ld	a,#0
1394  000b e706          	ld	(6,x),a
1395  000d a600          	ld	a,#0
1396  000f e705          	ld	(5,x),a
1397  0011 a600          	ld	a,#0
1398  0013 e704          	ld	(4,x),a
1399  0015 a600          	ld	a,#0
1400  0017 e703          	ld	(3,x),a
1401                     ; 303     btn->press_start = 0;
1403  0019 a600          	ld	a,#0
1404  001b e70a          	ld	(10,x),a
1405  001d a600          	ld	a,#0
1406  001f e709          	ld	(9,x),a
1407  0021 a600          	ld	a,#0
1408  0023 e708          	ld	(8,x),a
1409  0025 a600          	ld	a,#0
1410  0027 e707          	ld	(7,x),a
1411                     ; 304     btn->last_repeat = 0;
1413  0029 a600          	ld	a,#0
1414  002b e70e          	ld	(14,x),a
1415  002d a600          	ld	a,#0
1416  002f e70d          	ld	(13,x),a
1417  0031 a600          	ld	a,#0
1418  0033 e70c          	ld	(12,x),a
1419  0035 a600          	ld	a,#0
1420  0037 e70b          	ld	(11,x),a
1421                     ; 305     btn->repeat_interval = INITIAL_REPEAT_INTERVAL_MS;
1423  0039 90ae01c2      	ldw	y,#450
1424  003d ef0f          	ldw	(15,x),y
1425                     ; 306 }
1428  003f 81            	ret
1484                     	switch	.const
1485  0008               L601:
1486  0008 0000000a      	dc.l	10
1487  000c               L011:
1488  000c 000001f4      	dc.l	500
1489                     ; 308 uint8_t button_accel_check(uint8_t raw, ButtonAccel *btn)
1489                     ; 309 {
1490                     .text:	section	.text,new
1491  0000               _button_accel_check:
1493  0000 88            	push	a
1494  0001 5208          	subw	sp,#8
1495       00000008      OFST:	set	8
1498                     ; 310     uint32_t now = tim4_ms_counter;
1500  0003 be02          	ldw	x,L3_tim4_ms_counter+2
1501  0005 1f07          	ldw	(OFST-1,sp),x
1502  0007 be00          	ldw	x,L3_tim4_ms_counter
1503  0009 1f05          	ldw	(OFST-3,sp),x
1505                     ; 312     if (raw != btn->last_raw) {
1507  000b 1e0c          	ldw	x,(OFST+4,sp)
1508  000d f6            	ld	a,(x)
1509  000e 1109          	cp	a,(OFST+1,sp)
1510  0010 2717          	jreq	L515
1511                     ; 313         btn->last_raw = raw;
1513  0012 7b09          	ld	a,(OFST+1,sp)
1514  0014 1e0c          	ldw	x,(OFST+4,sp)
1515  0016 f7            	ld	(x),a
1516                     ; 314         btn->debounce_start = now;
1518  0017 1e0c          	ldw	x,(OFST+4,sp)
1519  0019 7b08          	ld	a,(OFST+0,sp)
1520  001b e706          	ld	(6,x),a
1521  001d 7b07          	ld	a,(OFST-1,sp)
1522  001f e705          	ld	(5,x),a
1523  0021 7b06          	ld	a,(OFST-2,sp)
1524  0023 e704          	ld	(4,x),a
1525  0025 7b05          	ld	a,(OFST-3,sp)
1526  0027 e703          	ld	(3,x),a
1527  0029               L515:
1528                     ; 317     if ((uint32_t)(now - btn->debounce_start) >= DEBOUNCE_MS) {
1530  0029 96            	ldw	x,sp
1531  002a 1c0005        	addw	x,#OFST-3
1532  002d cd0000        	call	c_ltor
1534  0030 1e0c          	ldw	x,(OFST+4,sp)
1535  0032 1c0003        	addw	x,#3
1536  0035 cd0000        	call	c_lsub
1538  0038 ae0008        	ldw	x,#L601
1539  003b cd0000        	call	c_lcmp
1541  003e 2506          	jrult	L715
1542                     ; 318         btn->stable = raw;
1544  0040 7b09          	ld	a,(OFST+1,sp)
1545  0042 1e0c          	ldw	x,(OFST+4,sp)
1546  0044 e701          	ld	(1,x),a
1547  0046               L715:
1548                     ; 321     if (btn->stable == 0 && !btn->pressed) {
1550  0046 1e0c          	ldw	x,(OFST+4,sp)
1551  0048 6d01          	tnz	(1,x)
1552  004a 263e          	jrne	L125
1554  004c 1e0c          	ldw	x,(OFST+4,sp)
1555  004e 6d02          	tnz	(2,x)
1556  0050 2638          	jrne	L125
1557                     ; 322         btn->pressed = 1;
1559  0052 1e0c          	ldw	x,(OFST+4,sp)
1560  0054 a601          	ld	a,#1
1561  0056 e702          	ld	(2,x),a
1562                     ; 323         btn->press_start = now;
1564  0058 1e0c          	ldw	x,(OFST+4,sp)
1565  005a 7b08          	ld	a,(OFST+0,sp)
1566  005c e70a          	ld	(10,x),a
1567  005e 7b07          	ld	a,(OFST-1,sp)
1568  0060 e709          	ld	(9,x),a
1569  0062 7b06          	ld	a,(OFST-2,sp)
1570  0064 e708          	ld	(8,x),a
1571  0066 7b05          	ld	a,(OFST-3,sp)
1572  0068 e707          	ld	(7,x),a
1573                     ; 324         btn->last_repeat = now;
1575  006a 1e0c          	ldw	x,(OFST+4,sp)
1576  006c 7b08          	ld	a,(OFST+0,sp)
1577  006e e70e          	ld	(14,x),a
1578  0070 7b07          	ld	a,(OFST-1,sp)
1579  0072 e70d          	ld	(13,x),a
1580  0074 7b06          	ld	a,(OFST-2,sp)
1581  0076 e70c          	ld	(12,x),a
1582  0078 7b05          	ld	a,(OFST-3,sp)
1583  007a e70b          	ld	(11,x),a
1584                     ; 325         btn->repeat_interval = INITIAL_REPEAT_INTERVAL_MS;
1586  007c 1e0c          	ldw	x,(OFST+4,sp)
1587  007e 90ae01c2      	ldw	y,#450
1588  0082 ef0f          	ldw	(15,x),y
1589                     ; 326         return 1;
1591  0084 a601          	ld	a,#1
1593  0086 ac1e011e      	jpf	L211
1594  008a               L125:
1595                     ; 329     if (btn->stable == 0 && btn->pressed) {
1597  008a 1e0c          	ldw	x,(OFST+4,sp)
1598  008c 6d01          	tnz	(1,x)
1599  008e 2703          	jreq	L411
1600  0090 cc0121        	jp	L325
1601  0093               L411:
1603  0093 1e0c          	ldw	x,(OFST+4,sp)
1604  0095 6d02          	tnz	(2,x)
1605  0097 2603          	jrne	L611
1606  0099 cc0121        	jp	L325
1607  009c               L611:
1608                     ; 330         if ((uint32_t)(now - btn->press_start) >= INITIAL_REPEAT_DELAY_MS) {
1610  009c 96            	ldw	x,sp
1611  009d 1c0005        	addw	x,#OFST-3
1612  00a0 cd0000        	call	c_ltor
1614  00a3 1e0c          	ldw	x,(OFST+4,sp)
1615  00a5 1c0007        	addw	x,#7
1616  00a8 cd0000        	call	c_lsub
1618  00ab ae000c        	ldw	x,#L011
1619  00ae cd0000        	call	c_lcmp
1621  00b1 256e          	jrult	L325
1622                     ; 332             if ((uint32_t)(now - btn->last_repeat) >= btn->repeat_interval) {
1624  00b3 96            	ldw	x,sp
1625  00b4 1c0005        	addw	x,#OFST-3
1626  00b7 cd0000        	call	c_ltor
1628  00ba 1e0c          	ldw	x,(OFST+4,sp)
1629  00bc 1c000b        	addw	x,#11
1630  00bf cd0000        	call	c_lsub
1632  00c2 96            	ldw	x,sp
1633  00c3 1c0001        	addw	x,#OFST-7
1634  00c6 cd0000        	call	c_rtol
1637  00c9 1e0c          	ldw	x,(OFST+4,sp)
1638  00cb ee0f          	ldw	x,(15,x)
1639  00cd cd0000        	call	c_uitolx
1641  00d0 96            	ldw	x,sp
1642  00d1 1c0001        	addw	x,#OFST-7
1643  00d4 cd0000        	call	c_lcmp
1645  00d7 2248          	jrugt	L325
1646                     ; 333                 btn->last_repeat = now;
1648  00d9 1e0c          	ldw	x,(OFST+4,sp)
1649  00db 7b08          	ld	a,(OFST+0,sp)
1650  00dd e70e          	ld	(14,x),a
1651  00df 7b07          	ld	a,(OFST-1,sp)
1652  00e1 e70d          	ld	(13,x),a
1653  00e3 7b06          	ld	a,(OFST-2,sp)
1654  00e5 e70c          	ld	(12,x),a
1655  00e7 7b05          	ld	a,(OFST-3,sp)
1656  00e9 e70b          	ld	(11,x),a
1657                     ; 335                 if (btn->repeat_interval > MIN_REPEAT_INTERVAL_MS) {
1659  00eb 1e0c          	ldw	x,(OFST+4,sp)
1660  00ed 9093          	ldw	y,x
1661  00ef 90ee0f        	ldw	y,(15,y)
1662  00f2 90a30006      	cpw	y,#6
1663  00f6 2524          	jrult	L135
1664                     ; 336                     btn->repeat_interval =
1664                     ; 337                         (uint16_t)((btn->repeat_interval * 8) / 10);
1666  00f8 1e0c          	ldw	x,(OFST+4,sp)
1667  00fa ee0f          	ldw	x,(15,x)
1668  00fc 58            	sllw	x
1669  00fd 58            	sllw	x
1670  00fe 58            	sllw	x
1671  00ff a60a          	ld	a,#10
1672  0101 62            	div	x,a
1673  0102 160c          	ldw	y,(OFST+4,sp)
1674  0104 90ef0f        	ldw	(15,y),x
1675                     ; 339                     if (btn->repeat_interval < MIN_REPEAT_INTERVAL_MS) {
1677  0107 1e0c          	ldw	x,(OFST+4,sp)
1678  0109 9093          	ldw	y,x
1679  010b 90ee0f        	ldw	y,(15,y)
1680  010e 90a30005      	cpw	y,#5
1681  0112 2408          	jruge	L135
1682                     ; 340                         btn->repeat_interval = MIN_REPEAT_INTERVAL_MS;
1684  0114 1e0c          	ldw	x,(OFST+4,sp)
1685  0116 90ae0005      	ldw	y,#5
1686  011a ef0f          	ldw	(15,x),y
1687  011c               L135:
1688                     ; 344                 return 1;
1690  011c a601          	ld	a,#1
1692  011e               L211:
1694  011e 5b09          	addw	sp,#9
1695  0120 81            	ret
1696  0121               L325:
1697                     ; 349     if (btn->stable == 1 && btn->pressed) {
1699  0121 1e0c          	ldw	x,(OFST+4,sp)
1700  0123 e601          	ld	a,(1,x)
1701  0125 a101          	cp	a,#1
1702  0127 260a          	jrne	L535
1704  0129 1e0c          	ldw	x,(OFST+4,sp)
1705  012b 6d02          	tnz	(2,x)
1706  012d 2704          	jreq	L535
1707                     ; 350         btn->pressed = 0;
1709  012f 1e0c          	ldw	x,(OFST+4,sp)
1710  0131 6f02          	clr	(2,x)
1711  0133               L535:
1712                     ; 353     return 0;
1714  0133 4f            	clr	a
1716  0134 20e8          	jra	L211
1781                     ; 356 void button_simple_init(ButtonSimple *btn) {
1782                     .text:	section	.text,new
1783  0000               _button_simple_init:
1787                     ; 357     btn->last_raw = 1;
1789  0000 a601          	ld	a,#1
1790  0002 f7            	ld	(x),a
1791                     ; 358     btn->stable = 1;
1793  0003 a601          	ld	a,#1
1794  0005 e701          	ld	(1,x),a
1795                     ; 359     btn->debounce_start = 0;
1797  0007 a600          	ld	a,#0
1798  0009 e705          	ld	(5,x),a
1799  000b a600          	ld	a,#0
1800  000d e704          	ld	(4,x),a
1801  000f a600          	ld	a,#0
1802  0011 e703          	ld	(3,x),a
1803  0013 a600          	ld	a,#0
1804  0015 e702          	ld	(2,x),a
1805                     ; 360 }
1808  0017 81            	ret
1865                     ; 361 uint8_t button_simple_check(uint8_t raw, ButtonSimple *btn)
1865                     ; 362 {
1866                     .text:	section	.text,new
1867  0000               _button_simple_check:
1869  0000 88            	push	a
1870  0001 5204          	subw	sp,#4
1871       00000004      OFST:	set	4
1874                     ; 363     uint32_t now = tim4_ms_counter;
1876  0003 be02          	ldw	x,L3_tim4_ms_counter+2
1877  0005 1f03          	ldw	(OFST-1,sp),x
1878  0007 be00          	ldw	x,L3_tim4_ms_counter
1879  0009 1f01          	ldw	(OFST-3,sp),x
1881                     ; 365     if (raw != btn->last_raw) {
1883  000b 1e08          	ldw	x,(OFST+4,sp)
1884  000d f6            	ld	a,(x)
1885  000e 1105          	cp	a,(OFST+1,sp)
1886  0010 2717          	jreq	L126
1887                     ; 366         btn->last_raw = raw;
1889  0012 7b05          	ld	a,(OFST+1,sp)
1890  0014 1e08          	ldw	x,(OFST+4,sp)
1891  0016 f7            	ld	(x),a
1892                     ; 367         btn->debounce_start = now;
1894  0017 1e08          	ldw	x,(OFST+4,sp)
1895  0019 7b04          	ld	a,(OFST+0,sp)
1896  001b e705          	ld	(5,x),a
1897  001d 7b03          	ld	a,(OFST-1,sp)
1898  001f e704          	ld	(4,x),a
1899  0021 7b02          	ld	a,(OFST-2,sp)
1900  0023 e703          	ld	(3,x),a
1901  0025 7b01          	ld	a,(OFST-3,sp)
1902  0027 e702          	ld	(2,x),a
1903  0029               L126:
1904                     ; 370     if ((uint32_t)(now - btn->debounce_start) >= DEBOUNCE_MS) {
1906  0029 96            	ldw	x,sp
1907  002a 1c0001        	addw	x,#OFST-3
1908  002d cd0000        	call	c_ltor
1910  0030 1e08          	ldw	x,(OFST+4,sp)
1911  0032 5c            	incw	x
1912  0033 5c            	incw	x
1913  0034 cd0000        	call	c_lsub
1915  0037 ae0008        	ldw	x,#L601
1916  003a cd0000        	call	c_lcmp
1918  003d 2518          	jrult	L326
1919                     ; 371         if (btn->stable != raw) {
1921  003f 1e08          	ldw	x,(OFST+4,sp)
1922  0041 e601          	ld	a,(1,x)
1923  0043 1105          	cp	a,(OFST+1,sp)
1924  0045 2710          	jreq	L326
1925                     ; 372             btn->stable = raw;
1927  0047 7b05          	ld	a,(OFST+1,sp)
1928  0049 1e08          	ldw	x,(OFST+4,sp)
1929  004b e701          	ld	(1,x),a
1930                     ; 374             if (btn->stable == 0) {
1932  004d 1e08          	ldw	x,(OFST+4,sp)
1933  004f 6d01          	tnz	(1,x)
1934  0051 2604          	jrne	L326
1935                     ; 375                 return 1;
1937  0053 a601          	ld	a,#1
1939  0055 2001          	jra	L421
1940  0057               L326:
1941                     ; 380     return 0;
1943  0057 4f            	clr	a
1945  0058               L421:
1947  0058 5b05          	addw	sp,#5
1948  005a 81            	ret
1971                     ; 383 void clock_setup(void)
1971                     ; 384 	{
1972                     .text:	section	.text,new
1973  0000               _clock_setup:
1977                     ; 385 		CLK_CKDIVR = 0;
1979  0000 725f50c6      	clr	20678
1980                     ; 386   }
1983  0004 81            	ret
2007                     ; 388 void tim4_isr_setup(void) {
2008                     .text:	section	.text,new
2009  0000               _tim4_isr_setup:
2013                     ; 389     TIM4_CR1 &= ~TIM_CR1_CEN;    
2015  0000 72115340      	bres	21312,#0
2016                     ; 390     TIM4_PSCR = 0x07;  
2018  0004 35075347      	mov	21319,#7
2019                     ; 391     TIM4_ARR = 124;    
2021  0008 357c5348      	mov	21320,#124
2022                     ; 392 		TIM4_CNTR = 0;
2024  000c 725f5346      	clr	21318
2025                     ; 393 		TIM4_SR &= ~TIM_SR1_UIF;
2027  0010 72115344      	bres	21316,#0
2028                     ; 394     TIM4_IER |= TIM_IER_UIE;
2030  0014 72105343      	bset	21315,#0
2031                     ; 395     TIM4_CR1 |= TIM_CR1_CEN;
2033  0018 72105340      	bset	21312,#0
2034                     ; 396     enableInterrupts();
2037  001c 9a            rim
2039                     ; 397 }
2042  001d 81            	ret
2070                     ; 410 void check_st_button(void) {
2071                     .text:	section	.text,new
2072  0000               _check_st_button:
2076                     ; 411         if (button_simple_check(STATUS_BTN_READ(), &status_btn)) {
2078  0000 ae0002        	ldw	x,#_status_btn
2079  0003 89            	pushw	x
2080  0004 c6500b        	ld	a,20491
2081  0007 a508          	bcp	a,#8
2082  0009 2704          	jreq	L431
2083  000b a601          	ld	a,#1
2084  000d 2001          	jra	L631
2085  000f               L431:
2086  000f 4f            	clr	a
2087  0010               L631:
2088  0010 cd0000        	call	_button_simple_check
2090  0013 85            	popw	x
2091  0014 4d            	tnz	a
2092  0015 2711          	jreq	L166
2093                     ; 412             current_screen++;
2095  0017 3c37          	inc	_current_screen
2096                     ; 413 						change_tracker=false;//track static changes, avoid refreshing not needed stuff
2098  0019 72110003      	bres	_change_tracker
2099                     ; 414             if (current_screen > memory_state) {
2101  001d b637          	ld	a,_current_screen
2102  001f a107          	cp	a,#7
2103  0021 2502          	jrult	L366
2104                     ; 415                 current_screen = frequency_state;
2106  0023 3f37          	clr	_current_screen
2107  0025               L366:
2108                     ; 417             pt6311_clear_display();	
2110  0025 cd0000        	call	_pt6311_clear_display
2112  0028               L166:
2113                     ; 419 }
2116  0028 81            	ret
2147                     ; 421 void update_screen(void) {
2148                     .text:	section	.text,new
2149  0000               _update_screen:
2153                     ; 422     switch (current_screen) {
2155  0000 b637          	ld	a,_current_screen
2157                     ; 453             break;
2158  0002 4d            	tnz	a
2159  0003 2716          	jreq	L566
2160  0005 4a            	dec	a
2161  0006 2718          	jreq	L766
2162  0008 4a            	dec	a
2163  0009 271a          	jreq	L176
2164  000b 4a            	dec	a
2165  000c 271c          	jreq	L376
2166  000e 4a            	dec	a
2167  000f 271e          	jreq	L576
2168  0011 4a            	dec	a
2169  0012 2720          	jreq	L776
2170  0014 4a            	dec	a
2171  0015 2722          	jreq	L107
2172  0017               L307:
2173                     ; 451         default:
2173                     ; 452             current_screen = frequency_state;
2175  0017 3f37          	clr	_current_screen
2176                     ; 453             break;
2178  0019 2021          	jra	L717
2179  001b               L566:
2180                     ; 423 				case frequency_state:
2180                     ; 424             frequency_screen();
2182  001b cd0000        	call	_frequency_screen
2184                     ; 425             break;
2186  001e 201c          	jra	L717
2187  0020               L766:
2188                     ; 427 				case channel_state:
2188                     ; 428             channel_screen();
2190  0020 cd0000        	call	_channel_screen
2192                     ; 429             break;
2194  0023 2017          	jra	L717
2195  0025               L176:
2196                     ; 431         case sound_state:
2196                     ; 432             sound_screen();
2198  0025 cd0000        	call	_sound_screen
2200                     ; 433             break;
2202  0028 2012          	jra	L717
2203  002a               L376:
2204                     ; 435         case ps_ratio_state:
2204                     ; 436             ps_ratio_screen();
2206  002a cd0000        	call	_ps_ratio_screen
2208                     ; 437             break;
2210  002d 200d          	jra	L717
2211  002f               L576:
2212                     ; 439         case tpen_state:
2212                     ; 440             tpen_screen();
2214  002f cd0000        	call	_tpen_screen
2216                     ; 441             break;
2218  0032 2008          	jra	L717
2219  0034               L776:
2220                     ; 443         case pwc_state:
2220                     ; 444             pwc_screen();
2222  0034 cd0000        	call	_pwc_screen
2224                     ; 445             break;
2226  0037 2003          	jra	L717
2227  0039               L107:
2228                     ; 447 				case memory_state:
2228                     ; 448             memory_screen();
2230  0039 cd0000        	call	_memory_screen
2232                     ; 449             break;		
2234  003c               L717:
2235                     ; 455 }
2238  003c 81            	ret
2293                     	switch	.const
2294  0010               L441:
2295  0010 000003e8      	dc.l	1000
2296                     ; 457 void freq_visuals(uint32_t mod_frequency){//onetime frequency load
2297                     .text:	section	.text,new
2298  0000               _freq_visuals:
2300  0000 5203          	subw	sp,#3
2301       00000003      OFST:	set	3
2304                     ; 460 	frec1 = (uint16_t)(mod_frequency / 1000);
2306  0002 96            	ldw	x,sp
2307  0003 1c0006        	addw	x,#OFST+3
2308  0006 cd0000        	call	c_ltor
2310  0009 ae0010        	ldw	x,#L441
2311  000c cd0000        	call	c_ludv
2313  000f be02          	ldw	x,c_lreg+2
2314  0011 1f02          	ldw	(OFST-1,sp),x
2316                     ; 461 	frec2 = (uint8_t)((mod_frequency % 1000) / 10);
2318  0013 96            	ldw	x,sp
2319  0014 1c0006        	addw	x,#OFST+3
2320  0017 cd0000        	call	c_ltor
2322  001a ae0010        	ldw	x,#L441
2323  001d cd0000        	call	c_lumd
2325  0020 ae0008        	ldw	x,#L601
2326  0023 cd0000        	call	c_ludv
2328  0026 b603          	ld	a,c_lreg+3
2329  0028 6b01          	ld	(OFST-2,sp),a
2331                     ; 463 	if (frec1<100){
2333  002a 1e02          	ldw	x,(OFST-1,sp)
2334  002c a30064        	cpw	x,#100
2335  002f 241a          	jruge	L747
2336                     ; 464 		pt6311_write_digit(3, 0x000000);
2338  0031 ae0000        	ldw	x,#0
2339  0034 89            	pushw	x
2340  0035 ae0000        	ldw	x,#0
2341  0038 89            	pushw	x
2342  0039 a603          	ld	a,#3
2343  003b cd0000        	call	_pt6311_write_digit
2345  003e 5b04          	addw	sp,#4
2346                     ; 465 		pt6311_write_int(4,frec1);//mhz
2348  0040 1e02          	ldw	x,(OFST-1,sp)
2349  0042 89            	pushw	x
2350  0043 a604          	ld	a,#4
2351  0045 cd0000        	call	_pt6311_write_int
2353  0048 85            	popw	x
2355  0049 2009          	jra	L157
2356  004b               L747:
2357                     ; 468 		pt6311_write_int(3,frec1);//mhz
2359  004b 1e02          	ldw	x,(OFST-1,sp)
2360  004d 89            	pushw	x
2361  004e a603          	ld	a,#3
2362  0050 cd0000        	call	_pt6311_write_int
2364  0053 85            	popw	x
2365  0054               L157:
2366                     ; 470 	if (frec2==0){
2368  0054 0d01          	tnz	(OFST-2,sp)
2369  0056 260c          	jrne	L357
2370                     ; 472 		pt6311_write_string(7,"00");//khz
2372  0058 ae0078        	ldw	x,#L557
2373  005b 89            	pushw	x
2374  005c a607          	ld	a,#7
2375  005e cd0000        	call	_pt6311_write_string
2377  0061 85            	popw	x
2379  0062 200f          	jra	L757
2380  0064               L357:
2381                     ; 475 		pt6311_write_int(7,frec2);//khz
2383  0064 7b01          	ld	a,(OFST-2,sp)
2384  0066 5f            	clrw	x
2385  0067 4d            	tnz	a
2386  0068 2a01          	jrpl	L641
2387  006a 53            	cplw	x
2388  006b               L641:
2389  006b 97            	ld	xl,a
2390  006c 89            	pushw	x
2391  006d a607          	ld	a,#7
2392  006f cd0000        	call	_pt6311_write_int
2394  0072 85            	popw	x
2395  0073               L757:
2396                     ; 477 	pt6311_write_digit(6, 0x80);//dec dot
2398  0073 ae0080        	ldw	x,#128
2399  0076 89            	pushw	x
2400  0077 ae0000        	ldw	x,#0
2401  007a 89            	pushw	x
2402  007b a606          	ld	a,#6
2403  007d cd0000        	call	_pt6311_write_digit
2405  0080 5b04          	addw	sp,#4
2406                     ; 478 }
2409  0082 5b03          	addw	sp,#3
2410  0084 81            	ret
2458                     ; 480 void freq_update_visuals(uint8_t move, uint16_t khz_step){//frequency updater
2459                     .text:	section	.text,new
2460  0000               _freq_update_visuals:
2462  0000 88            	push	a
2463  0001 5204          	subw	sp,#4
2464       00000004      OFST:	set	4
2467                     ; 481 	if (move) {
2469  0003 4d            	tnz	a
2470  0004 2732          	jreq	L3001
2471                     ; 482         if (mod_frequency <= (RF_FREQ_MAX_KHZ - khz_step)) {
2473  0006 1e08          	ldw	x,(OFST+4,sp)
2474  0008 cd0000        	call	c_uitolx
2476  000b 96            	ldw	x,sp
2477  000c 1c0001        	addw	x,#OFST-3
2478  000f cd0000        	call	c_rtol
2481  0012 ae6d80        	ldw	x,#28032
2482  0015 bf02          	ldw	c_lreg+2,x
2483  0017 ae000d        	ldw	x,#13
2484  001a bf00          	ldw	c_lreg,x
2485  001c 96            	ldw	x,sp
2486  001d 1c0001        	addw	x,#OFST-3
2487  0020 cd0000        	call	c_lsub
2489  0023 ae0004        	ldw	x,#_mod_frequency
2490  0026 cd0000        	call	c_lcmp
2492  0029 252b          	jrult	L7001
2493                     ; 483             mod_frequency += khz_step;
2495  002b 1e08          	ldw	x,(OFST+4,sp)
2496  002d cd0000        	call	c_uitolx
2498  0030 ae0004        	ldw	x,#_mod_frequency
2499  0033 cd0000        	call	c_lgadd
2501  0036 201e          	jra	L7001
2502  0038               L3001:
2503                     ; 486         if (mod_frequency >= (RF_FREQ_MIN_KHZ + khz_step)) {
2505  0038 1e08          	ldw	x,(OFST+4,sp)
2506  003a cd0000        	call	c_uitolx
2508  003d ae0000        	ldw	x,#L44
2509  0040 cd0000        	call	c_ladd
2511  0043 ae0004        	ldw	x,#_mod_frequency
2512  0046 cd0000        	call	c_lcmp
2514  0049 220b          	jrugt	L7001
2515                     ; 487             mod_frequency -= khz_step;
2517  004b 1e08          	ldw	x,(OFST+4,sp)
2518  004d cd0000        	call	c_uitolx
2520  0050 ae0004        	ldw	x,#_mod_frequency
2521  0053 cd0000        	call	c_lgsub
2523  0056               L7001:
2524                     ; 491 	freq_visuals(mod_frequency);			
2526  0056 be06          	ldw	x,_mod_frequency+2
2527  0058 89            	pushw	x
2528  0059 be04          	ldw	x,_mod_frequency
2529  005b 89            	pushw	x
2530  005c cd0000        	call	_freq_visuals
2532  005f 5b04          	addw	sp,#4
2533                     ; 492 	RFModulator_SetFrequency(&mod, mod_frequency);
2535  0061 be06          	ldw	x,_mod_frequency+2
2536  0063 89            	pushw	x
2537  0064 be04          	ldw	x,_mod_frequency
2538  0066 89            	pushw	x
2539  0067 ae002a        	ldw	x,#_mod
2540  006a cd0000        	call	_RFModulator_SetFrequency
2542  006d 5b04          	addw	sp,#4
2543                     ; 493 }
2546  006f 5b05          	addw	sp,#5
2547  0071 81            	ret
2578                     ; 495 void frequency_screen(void)//up or down 250 khz
2578                     ; 496 {
2579                     .text:	section	.text,new
2580  0000               _frequency_screen:
2584                     ; 497 		if (!change_tracker){
2586                     	btst	_change_tracker
2587  0005 2519          	jrult	L3201
2588                     ; 498 			pt6311_write_string(1,"F");
2590  0007 ae0089        	ldw	x,#L34
2591  000a 89            	pushw	x
2592  000b a601          	ld	a,#1
2593  000d cd0000        	call	_pt6311_write_string
2595  0010 85            	popw	x
2596                     ; 499 			freq_visuals(mod_frequency);
2598  0011 be06          	ldw	x,_mod_frequency+2
2599  0013 89            	pushw	x
2600  0014 be04          	ldw	x,_mod_frequency
2601  0016 89            	pushw	x
2602  0017 cd0000        	call	_freq_visuals
2604  001a 5b04          	addw	sp,#4
2605                     ; 500 			change_tracker=true;
2607  001c 72100003      	bset	_change_tracker
2608  0020               L3201:
2609                     ; 502     if (button_accel_check(UP_BTN_READ(), &up_btn)) {
2611  0020 ae0019        	ldw	x,#_up_btn
2612  0023 89            	pushw	x
2613  0024 c6500b        	ld	a,20491
2614  0027 a510          	bcp	a,#16
2615  0029 2704          	jreq	L451
2616  002b a601          	ld	a,#1
2617  002d 2001          	jra	L651
2618  002f               L451:
2619  002f 4f            	clr	a
2620  0030               L651:
2621  0030 cd0000        	call	_button_accel_check
2623  0033 85            	popw	x
2624  0034 4d            	tnz	a
2625  0035 270c          	jreq	L5201
2626                     ; 503         freq_update_visuals(1, RF_FREQ_STEP_KHZ);
2628  0037 ae00fa        	ldw	x,#250
2629  003a 89            	pushw	x
2630  003b a601          	ld	a,#1
2631  003d cd0000        	call	_freq_update_visuals
2633  0040 85            	popw	x
2635  0041 2020          	jra	L7201
2636  0043               L5201:
2637                     ; 504     } else if (button_accel_check(DOWN_BTN_READ(), &down_btn)) {
2639  0043 ae0008        	ldw	x,#_down_btn
2640  0046 89            	pushw	x
2641  0047 c65001        	ld	a,20481
2642  004a a508          	bcp	a,#8
2643  004c 2704          	jreq	L061
2644  004e a601          	ld	a,#1
2645  0050 2001          	jra	L261
2646  0052               L061:
2647  0052 4f            	clr	a
2648  0053               L261:
2649  0053 cd0000        	call	_button_accel_check
2651  0056 85            	popw	x
2652  0057 4d            	tnz	a
2653  0058 2709          	jreq	L7201
2654                     ; 505         freq_update_visuals(0, RF_FREQ_STEP_KHZ);
2656  005a ae00fa        	ldw	x,#250
2657  005d 89            	pushw	x
2658  005e 4f            	clr	a
2659  005f cd0000        	call	_freq_update_visuals
2661  0062 85            	popw	x
2662  0063               L7201:
2663                     ; 507 }
2666  0063 81            	ret
2707                     	switch	.const
2708  0014               L661:
2709  0014 000730d2      	dc.l	471250
2710  0018               L071:
2711  0018 0002ac92      	dc.l	175250
2712  001c               L271:
2713  001c 00012dc2      	dc.l	77250
2714  0020               L471:
2715  0020 0000c256      	dc.l	49750
2716                     ; 509 void channel_update_visuals(uint8_t move){
2717                     .text:	section	.text,new
2718  0000               _channel_update_visuals:
2722                     ; 510 		if (move){
2724  0000 4d            	tnz	a
2725  0001 2720          	jreq	L1501
2726                     ; 511 			if (channel < 12) {
2728  0003 b600          	ld	a,_channel
2729  0005 a10c          	cp	a,#12
2730  0007 2404          	jruge	L3501
2731                     ; 512 					channel++;
2733  0009 3c00          	inc	_channel
2735  000b 2034          	jra	L5601
2736  000d               L3501:
2737                     ; 513 				} else if (channel == 12) {
2739  000d b600          	ld	a,_channel
2740  000f a10c          	cp	a,#12
2741  0011 2606          	jrne	L7501
2742                     ; 514 						channel = 21;
2744  0013 35150000      	mov	_channel,#21
2746  0017 2028          	jra	L5601
2747  0019               L7501:
2748                     ; 515         } else if (channel < 71) {
2750  0019 b600          	ld	a,_channel
2751  001b a147          	cp	a,#71
2752  001d 2422          	jruge	L5601
2753                     ; 516             channel++;
2755  001f 3c00          	inc	_channel
2756  0021 201e          	jra	L5601
2757  0023               L1501:
2758                     ; 520 			if (channel > 21) {
2760  0023 b600          	ld	a,_channel
2761  0025 a116          	cp	a,#22
2762  0027 2504          	jrult	L7601
2763                     ; 521 							channel--;
2765  0029 3a00          	dec	_channel
2767  002b 2014          	jra	L5601
2768  002d               L7601:
2769                     ; 522         } else if (channel == 21) {
2771  002d b600          	ld	a,_channel
2772  002f a115          	cp	a,#21
2773  0031 2606          	jrne	L3701
2774                     ; 523             channel = 12;
2776  0033 350c0000      	mov	_channel,#12
2778  0037 2008          	jra	L5601
2779  0039               L3701:
2780                     ; 524         } else if (channel > 1) {
2782  0039 b600          	ld	a,_channel
2783  003b a102          	cp	a,#2
2784  003d 2502          	jrult	L5601
2785                     ; 525             channel--;
2787  003f 3a00          	dec	_channel
2788  0041               L5601:
2789                     ; 529 		if (channel >= 21) {
2791  0041 b600          	ld	a,_channel
2792  0043 a115          	cp	a,#21
2793  0045 251c          	jrult	L1011
2794                     ; 530         mod_frequency =
2794                     ; 531             CH21_FREQ_KHZ + ((uint32_t)(channel - 21) * 8000);
2796  0047 b600          	ld	a,_channel
2797  0049 5f            	clrw	x
2798  004a 97            	ld	xl,a
2799  004b 1d0015        	subw	x,#21
2800  004e 90ae1f40      	ldw	y,#8000
2801  0052 cd0000        	call	c_vmul
2803  0055 ae0014        	ldw	x,#L661
2804  0058 cd0000        	call	c_ladd
2806  005b ae0004        	ldw	x,#_mod_frequency
2807  005e cd0000        	call	c_rtol
2810  0061 205c          	jra	L3011
2811  0063               L1011:
2812                     ; 532     } else if (channel >= 6) {
2814  0063 b600          	ld	a,_channel
2815  0065 a106          	cp	a,#6
2816  0067 251c          	jrult	L5011
2817                     ; 533         mod_frequency =
2817                     ; 534             CH6_FREQ_KHZ + ((uint32_t)(channel - 6) * 8000);
2819  0069 b600          	ld	a,_channel
2820  006b 5f            	clrw	x
2821  006c 97            	ld	xl,a
2822  006d 1d0006        	subw	x,#6
2823  0070 90ae1f40      	ldw	y,#8000
2824  0074 cd0000        	call	c_vmul
2826  0077 ae0018        	ldw	x,#L071
2827  007a cd0000        	call	c_ladd
2829  007d ae0004        	ldw	x,#_mod_frequency
2830  0080 cd0000        	call	c_rtol
2833  0083 203a          	jra	L3011
2834  0085               L5011:
2835                     ; 535     } else if (channel >= 3) {
2837  0085 b600          	ld	a,_channel
2838  0087 a103          	cp	a,#3
2839  0089 251c          	jrult	L1111
2840                     ; 536         mod_frequency =
2840                     ; 537             CH3_FREQ_KHZ + ((uint32_t)(channel - 3) * 8000);
2842  008b b600          	ld	a,_channel
2843  008d 5f            	clrw	x
2844  008e 97            	ld	xl,a
2845  008f 1d0003        	subw	x,#3
2846  0092 90ae1f40      	ldw	y,#8000
2847  0096 cd0000        	call	c_vmul
2849  0099 ae001c        	ldw	x,#L271
2850  009c cd0000        	call	c_ladd
2852  009f ae0004        	ldw	x,#_mod_frequency
2853  00a2 cd0000        	call	c_rtol
2856  00a5 2018          	jra	L3011
2857  00a7               L1111:
2858                     ; 539         mod_frequency =
2858                     ; 540             CH1_FREQ_KHZ + ((uint32_t)(channel - 1) * 9500);
2860  00a7 b600          	ld	a,_channel
2861  00a9 5f            	clrw	x
2862  00aa 97            	ld	xl,a
2863  00ab 5a            	decw	x
2864  00ac 90ae251c      	ldw	y,#9500
2865  00b0 cd0000        	call	c_vmul
2867  00b3 ae0020        	ldw	x,#L471
2868  00b6 cd0000        	call	c_ladd
2870  00b9 ae0004        	ldw	x,#_mod_frequency
2871  00bc cd0000        	call	c_rtol
2873  00bf               L3011:
2874                     ; 542 		if (channel<10){
2876  00bf b600          	ld	a,_channel
2877  00c1 a10a          	cp	a,#10
2878  00c3 241c          	jruge	L5111
2879                     ; 543 			pt6311_write_digit(7, 0x000000);
2881  00c5 ae0000        	ldw	x,#0
2882  00c8 89            	pushw	x
2883  00c9 ae0000        	ldw	x,#0
2884  00cc 89            	pushw	x
2885  00cd a607          	ld	a,#7
2886  00cf cd0000        	call	_pt6311_write_digit
2888  00d2 5b04          	addw	sp,#4
2889                     ; 544 			pt6311_write_int(6, channel);
2891  00d4 b600          	ld	a,_channel
2892  00d6 5f            	clrw	x
2893  00d7 97            	ld	xl,a
2894  00d8 89            	pushw	x
2895  00d9 a606          	ld	a,#6
2896  00db cd0000        	call	_pt6311_write_int
2898  00de 85            	popw	x
2900  00df 200b          	jra	L7111
2901  00e1               L5111:
2902                     ; 547 			pt6311_write_int(6, channel);
2904  00e1 b600          	ld	a,_channel
2905  00e3 5f            	clrw	x
2906  00e4 97            	ld	xl,a
2907  00e5 89            	pushw	x
2908  00e6 a606          	ld	a,#6
2909  00e8 cd0000        	call	_pt6311_write_int
2911  00eb 85            	popw	x
2912  00ec               L7111:
2913                     ; 549 		RFModulator_SetFrequency(&mod, mod_frequency);
2915  00ec be06          	ldw	x,_mod_frequency+2
2916  00ee 89            	pushw	x
2917  00ef be04          	ldw	x,_mod_frequency
2918  00f1 89            	pushw	x
2919  00f2 ae002a        	ldw	x,#_mod
2920  00f5 cd0000        	call	_RFModulator_SetFrequency
2922  00f8 5b04          	addw	sp,#4
2923                     ; 550 }
2926  00fa 81            	ret
2965                     	switch	.const
2966  0024               L002:
2967  0024 000d4b53      	dc.l	871251
2968  0028               L202:
2969  0028 00001f40      	dc.l	8000
2970  002c               L402:
2971  002c 00036813      	dc.l	223251
2972  0030               L602:
2973  0030 00016c43      	dc.l	93251
2974  0034               L012:
2975  0034 0000e773      	dc.l	59251
2976  0038               L212:
2977  0038 0000251c      	dc.l	9500
2978                     ; 551 void channel_recalculate(uint32_t mod_frequency) {
2979                     .text:	section	.text,new
2980  0000               _channel_recalculate:
2982       00000000      OFST:	set	0
2985                     ; 552 		if (mod_frequency >= CH21_FREQ_KHZ && mod_frequency <= CH21_LAST_FREQ_KHZ) {
2987  0000 96            	ldw	x,sp
2988  0001 1c0003        	addw	x,#OFST+3
2989  0004 cd0000        	call	c_ltor
2991  0007 ae0014        	ldw	x,#L661
2992  000a cd0000        	call	c_lcmp
2994  000d 253c          	jrult	L7311
2996  000f 96            	ldw	x,sp
2997  0010 1c0003        	addw	x,#OFST+3
2998  0013 cd0000        	call	c_ltor
3000  0016 ae0024        	ldw	x,#L002
3001  0019 cd0000        	call	c_lcmp
3003  001c 242d          	jruge	L7311
3004                     ; 553         channel = (uint8_t)(21 + ((mod_frequency - CH21_FREQ_KHZ) / 8000));
3006  001e 96            	ldw	x,sp
3007  001f 1c0003        	addw	x,#OFST+3
3008  0022 cd0000        	call	c_ltor
3010  0025 ae0014        	ldw	x,#L661
3011  0028 cd0000        	call	c_lsub
3013  002b ae0028        	ldw	x,#L202
3014  002e cd0000        	call	c_ludv
3016  0031 a615          	ld	a,#21
3017  0033 cd0000        	call	c_ladc
3019  0036 b603          	ld	a,c_lreg+3
3020  0038 b700          	ld	_channel,a
3021                     ; 554         if (channel > 71) {
3023  003a b600          	ld	a,_channel
3024  003c a148          	cp	a,#72
3025  003e 2403          	jruge	L412
3026  0040 cc0125        	jp	L3411
3027  0043               L412:
3028                     ; 555             channel = 71;
3030  0043 35470000      	mov	_channel,#71
3031  0047 ac250125      	jpf	L3411
3032  004b               L7311:
3033                     ; 558     else if (mod_frequency >= CH6_FREQ_KHZ && mod_frequency <= CH12_FREQ_KHZ) {
3035  004b 96            	ldw	x,sp
3036  004c 1c0003        	addw	x,#OFST+3
3037  004f cd0000        	call	c_ltor
3039  0052 ae0018        	ldw	x,#L071
3040  0055 cd0000        	call	c_lcmp
3042  0058 253c          	jrult	L5411
3044  005a 96            	ldw	x,sp
3045  005b 1c0003        	addw	x,#OFST+3
3046  005e cd0000        	call	c_ltor
3048  0061 ae002c        	ldw	x,#L402
3049  0064 cd0000        	call	c_lcmp
3051  0067 242d          	jruge	L5411
3052                     ; 559         channel = (uint8_t)(6 + ((mod_frequency - CH6_FREQ_KHZ) / 8000));
3054  0069 96            	ldw	x,sp
3055  006a 1c0003        	addw	x,#OFST+3
3056  006d cd0000        	call	c_ltor
3058  0070 ae0018        	ldw	x,#L071
3059  0073 cd0000        	call	c_lsub
3061  0076 ae0028        	ldw	x,#L202
3062  0079 cd0000        	call	c_ludv
3064  007c a606          	ld	a,#6
3065  007e cd0000        	call	c_ladc
3067  0081 b603          	ld	a,c_lreg+3
3068  0083 b700          	ld	_channel,a
3069                     ; 560         if (channel > 12) {
3071  0085 b600          	ld	a,_channel
3072  0087 a10d          	cp	a,#13
3073  0089 2403          	jruge	L612
3074  008b cc0125        	jp	L3411
3075  008e               L612:
3076                     ; 561             channel = 12;
3078  008e 350c0000      	mov	_channel,#12
3079  0092 ac250125      	jpf	L3411
3080  0096               L5411:
3081                     ; 564     else if (mod_frequency >= CH3_FREQ_KHZ && mod_frequency <= CH5_FREQ_KHZ) {
3083  0096 96            	ldw	x,sp
3084  0097 1c0003        	addw	x,#OFST+3
3085  009a cd0000        	call	c_ltor
3087  009d ae001c        	ldw	x,#L271
3088  00a0 cd0000        	call	c_lcmp
3090  00a3 2537          	jrult	L3511
3092  00a5 96            	ldw	x,sp
3093  00a6 1c0003        	addw	x,#OFST+3
3094  00a9 cd0000        	call	c_ltor
3096  00ac ae0030        	ldw	x,#L602
3097  00af cd0000        	call	c_lcmp
3099  00b2 2428          	jruge	L3511
3100                     ; 565         channel = (uint8_t)(3 + ((mod_frequency - CH3_FREQ_KHZ) / 8000));
3102  00b4 96            	ldw	x,sp
3103  00b5 1c0003        	addw	x,#OFST+3
3104  00b8 cd0000        	call	c_ltor
3106  00bb ae001c        	ldw	x,#L271
3107  00be cd0000        	call	c_lsub
3109  00c1 ae0028        	ldw	x,#L202
3110  00c4 cd0000        	call	c_ludv
3112  00c7 a603          	ld	a,#3
3113  00c9 cd0000        	call	c_ladc
3115  00cc b603          	ld	a,c_lreg+3
3116  00ce b700          	ld	_channel,a
3117                     ; 566         if (channel > 5) {
3119  00d0 b600          	ld	a,_channel
3120  00d2 a106          	cp	a,#6
3121  00d4 254f          	jrult	L3411
3122                     ; 567             channel = 5;
3124  00d6 35050000      	mov	_channel,#5
3125  00da 2049          	jra	L3411
3126  00dc               L3511:
3127                     ; 570     else if (mod_frequency >= CH1_FREQ_KHZ && mod_frequency <= CH2_FREQ_KHZ) {
3129  00dc 96            	ldw	x,sp
3130  00dd 1c0003        	addw	x,#OFST+3
3131  00e0 cd0000        	call	c_ltor
3133  00e3 ae0020        	ldw	x,#L471
3134  00e6 cd0000        	call	c_lcmp
3136  00e9 2537          	jrult	L1611
3138  00eb 96            	ldw	x,sp
3139  00ec 1c0003        	addw	x,#OFST+3
3140  00ef cd0000        	call	c_ltor
3142  00f2 ae0034        	ldw	x,#L012
3143  00f5 cd0000        	call	c_lcmp
3145  00f8 2428          	jruge	L1611
3146                     ; 571         channel = (uint8_t)(1 + ((mod_frequency - CH1_FREQ_KHZ) / 9500));
3148  00fa 96            	ldw	x,sp
3149  00fb 1c0003        	addw	x,#OFST+3
3150  00fe cd0000        	call	c_ltor
3152  0101 ae0020        	ldw	x,#L471
3153  0104 cd0000        	call	c_lsub
3155  0107 ae0038        	ldw	x,#L212
3156  010a cd0000        	call	c_ludv
3158  010d a601          	ld	a,#1
3159  010f cd0000        	call	c_ladc
3161  0112 b603          	ld	a,c_lreg+3
3162  0114 b700          	ld	_channel,a
3163                     ; 572         if (channel > 2) {
3165  0116 b600          	ld	a,_channel
3166  0118 a103          	cp	a,#3
3167  011a 2509          	jrult	L3411
3168                     ; 573             channel = 2;
3170  011c 35020000      	mov	_channel,#2
3171  0120 2003          	jra	L3411
3172  0122               L1611:
3173                     ; 577         channel = last_channel;//if user goes out of channel range display last valid
3175  0122 450800        	mov	_channel,_last_channel
3176  0125               L3411:
3177                     ; 579 		last_channel=channel;//save last valid channel matching exact frequency
3179  0125 450008        	mov	_last_channel,_channel
3180                     ; 580     if (channel<10){
3182  0128 b600          	ld	a,_channel
3183  012a a10a          	cp	a,#10
3184  012c 241c          	jruge	L7611
3185                     ; 581 			pt6311_write_digit(7, 0x000000);
3187  012e ae0000        	ldw	x,#0
3188  0131 89            	pushw	x
3189  0132 ae0000        	ldw	x,#0
3190  0135 89            	pushw	x
3191  0136 a607          	ld	a,#7
3192  0138 cd0000        	call	_pt6311_write_digit
3194  013b 5b04          	addw	sp,#4
3195                     ; 582 			pt6311_write_int(6, channel);
3197  013d b600          	ld	a,_channel
3198  013f 5f            	clrw	x
3199  0140 97            	ld	xl,a
3200  0141 89            	pushw	x
3201  0142 a606          	ld	a,#6
3202  0144 cd0000        	call	_pt6311_write_int
3204  0147 85            	popw	x
3206  0148 200b          	jra	L1711
3207  014a               L7611:
3208                     ; 585 			pt6311_write_int(6, channel);
3210  014a b600          	ld	a,_channel
3211  014c 5f            	clrw	x
3212  014d 97            	ld	xl,a
3213  014e 89            	pushw	x
3214  014f a606          	ld	a,#6
3215  0151 cd0000        	call	_pt6311_write_int
3217  0154 85            	popw	x
3218  0155               L1711:
3219                     ; 587 }
3222  0155 81            	ret
3253                     ; 588 void channel_screen(void){
3254                     .text:	section	.text,new
3255  0000               _channel_screen:
3259                     ; 589 		if (!change_tracker){
3261                     	btst	_change_tracker
3262  0005 2519          	jrult	L3021
3263                     ; 590 				pt6311_write_string(1,"CHAN");
3265  0007 ae0073        	ldw	x,#L5021
3266  000a 89            	pushw	x
3267  000b a601          	ld	a,#1
3268  000d cd0000        	call	_pt6311_write_string
3270  0010 85            	popw	x
3271                     ; 591 				channel_recalculate(mod_frequency);
3273  0011 be06          	ldw	x,_mod_frequency+2
3274  0013 89            	pushw	x
3275  0014 be04          	ldw	x,_mod_frequency
3276  0016 89            	pushw	x
3277  0017 cd0000        	call	_channel_recalculate
3279  001a 5b04          	addw	sp,#4
3280                     ; 592 				change_tracker=true;
3282  001c 72100003      	bset	_change_tracker
3283  0020               L3021:
3284                     ; 594 		if (button_accel_check(UP_BTN_READ(), &up_btn)){
3286  0020 ae0019        	ldw	x,#_up_btn
3287  0023 89            	pushw	x
3288  0024 c6500b        	ld	a,20491
3289  0027 a510          	bcp	a,#16
3290  0029 2704          	jreq	L222
3291  002b a601          	ld	a,#1
3292  002d 2001          	jra	L422
3293  002f               L222:
3294  002f 4f            	clr	a
3295  0030               L422:
3296  0030 cd0000        	call	_button_accel_check
3298  0033 85            	popw	x
3299  0034 4d            	tnz	a
3300  0035 2707          	jreq	L7021
3301                     ; 595 					channel_update_visuals(1);
3303  0037 a601          	ld	a,#1
3304  0039 cd0000        	call	_channel_update_visuals
3307  003c 201b          	jra	L1121
3308  003e               L7021:
3309                     ; 596 		} else if (button_accel_check(DOWN_BTN_READ(), &down_btn))  {
3311  003e ae0008        	ldw	x,#_down_btn
3312  0041 89            	pushw	x
3313  0042 c65001        	ld	a,20481
3314  0045 a508          	bcp	a,#8
3315  0047 2704          	jreq	L622
3316  0049 a601          	ld	a,#1
3317  004b 2001          	jra	L032
3318  004d               L622:
3319  004d 4f            	clr	a
3320  004e               L032:
3321  004e cd0000        	call	_button_accel_check
3323  0051 85            	popw	x
3324  0052 4d            	tnz	a
3325  0053 2704          	jreq	L1121
3326                     ; 597 					channel_update_visuals(0);					
3328  0055 4f            	clr	a
3329  0056 cd0000        	call	_channel_update_visuals
3331  0059               L1121:
3332                     ; 599 }
3335  0059 81            	ret
3434                     ; 601 void bool_updaters(ScreenState screen){//bool updaters 
3435                     .text:	section	.text,new
3436  0000               _bool_updaters:
3438  0000 88            	push	a
3439       00000000      OFST:	set	0
3442                     ; 602 		if (screen == ps_ratio_state) {
3444  0001 a103          	cp	a,#3
3445  0003 2651          	jrne	L5521
3446                     ; 603 			if (ps_ratio){
3448                     	btst	_ps_ratio
3449  000a 2425          	jruge	L7521
3450                     ; 604 					pt6311_write_string(5,"16dB");
3452  000c ae006e        	ldw	x,#L1621
3453  000f 89            	pushw	x
3454  0010 a605          	ld	a,#5
3455  0012 cd0000        	call	_pt6311_write_string
3457  0015 85            	popw	x
3458                     ; 605 					RFModulator_SetPictureSoundRatio(&mod, MC44BS374T1_PS_16);
3460  0016 4b01          	push	#1
3461  0018 ae002a        	ldw	x,#_mod
3462  001b cd0000        	call	_RFModulator_SetPictureSoundRatio
3464  001e 84            	pop	a
3465                     ; 606 					pt6311_write_digit(0, 16384);
3467  001f ae4000        	ldw	x,#16384
3468  0022 89            	pushw	x
3469  0023 ae0000        	ldw	x,#0
3470  0026 89            	pushw	x
3471  0027 4f            	clr	a
3472  0028 cd0000        	call	_pt6311_write_digit
3474  002b 5b04          	addw	sp,#4
3476  002d acfa00fa      	jpf	L7621
3477  0031               L7521:
3478                     ; 609 					pt6311_write_string(5,"12dB");
3480  0031 ae0069        	ldw	x,#L5621
3481  0034 89            	pushw	x
3482  0035 a605          	ld	a,#5
3483  0037 cd0000        	call	_pt6311_write_string
3485  003a 85            	popw	x
3486                     ; 610 					RFModulator_SetPictureSoundRatio(&mod, MC44BS374T1_PS_12);
3488  003b 4b00          	push	#0
3489  003d ae002a        	ldw	x,#_mod
3490  0040 cd0000        	call	_RFModulator_SetPictureSoundRatio
3492  0043 84            	pop	a
3493                     ; 611 					pt6311_write_digit(0, 0x000000);
3495  0044 ae0000        	ldw	x,#0
3496  0047 89            	pushw	x
3497  0048 ae0000        	ldw	x,#0
3498  004b 89            	pushw	x
3499  004c 4f            	clr	a
3500  004d cd0000        	call	_pt6311_write_digit
3502  0050 5b04          	addw	sp,#4
3503  0052 acfa00fa      	jpf	L7621
3504  0056               L5521:
3505                     ; 615     else if (screen == tpen_state){
3507  0056 7b01          	ld	a,(OFST+1,sp)
3508  0058 a104          	cp	a,#4
3509  005a 264d          	jrne	L1721
3510                     ; 616         if (tpen){
3512                     	btst	_tpen
3513  0061 2423          	jruge	L3721
3514                     ; 617 					pt6311_write_string(6,"ON ");
3516  0063 ae0065        	ldw	x,#L5721
3517  0066 89            	pushw	x
3518  0067 a606          	ld	a,#6
3519  0069 cd0000        	call	_pt6311_write_string
3521  006c 85            	popw	x
3522                     ; 618 					RFModulator_SetTestPattern(&mod, MC44BS374T1_TPEN_ON);
3524  006d 4b01          	push	#1
3525  006f ae002a        	ldw	x,#_mod
3526  0072 cd0000        	call	_RFModulator_SetTestPattern
3528  0075 84            	pop	a
3529                     ; 619 					pt6311_write_digit(0, 64);
3531  0076 ae0040        	ldw	x,#64
3532  0079 89            	pushw	x
3533  007a ae0000        	ldw	x,#0
3534  007d 89            	pushw	x
3535  007e 4f            	clr	a
3536  007f cd0000        	call	_pt6311_write_digit
3538  0082 5b04          	addw	sp,#4
3540  0084 2074          	jra	L7621
3541  0086               L3721:
3542                     ; 622 					pt6311_write_string(6,"OFF");
3544  0086 ae0061        	ldw	x,#L1031
3545  0089 89            	pushw	x
3546  008a a606          	ld	a,#6
3547  008c cd0000        	call	_pt6311_write_string
3549  008f 85            	popw	x
3550                     ; 623 					RFModulator_SetTestPattern(&mod, MC44BS374T1_TPEN_OFF);
3552  0090 4b00          	push	#0
3553  0092 ae002a        	ldw	x,#_mod
3554  0095 cd0000        	call	_RFModulator_SetTestPattern
3556  0098 84            	pop	a
3557                     ; 624 					pt6311_write_digit(0, 0x000000);
3559  0099 ae0000        	ldw	x,#0
3560  009c 89            	pushw	x
3561  009d ae0000        	ldw	x,#0
3562  00a0 89            	pushw	x
3563  00a1 4f            	clr	a
3564  00a2 cd0000        	call	_pt6311_write_digit
3566  00a5 5b04          	addw	sp,#4
3567  00a7 2051          	jra	L7621
3568  00a9               L1721:
3569                     ; 627     else if (screen == pwc_state) {
3571  00a9 7b01          	ld	a,(OFST+1,sp)
3572  00ab a105          	cp	a,#5
3573  00ad 264b          	jrne	L7621
3574                     ; 628 			if (pwc){
3576                     	btst	_pwc
3577  00b4 2423          	jruge	L7031
3578                     ; 629 					pt6311_write_string(6,"OFF");
3580  00b6 ae0061        	ldw	x,#L1031
3581  00b9 89            	pushw	x
3582  00ba a606          	ld	a,#6
3583  00bc cd0000        	call	_pt6311_write_string
3585  00bf 85            	popw	x
3586                     ; 630 					RFModulator_SetPeakWhiteClip(&mod, MC44BS374T1_PWC_OFF);
3588  00c0 4b01          	push	#1
3589  00c2 ae002a        	ldw	x,#_mod
3590  00c5 cd0000        	call	_RFModulator_SetPeakWhiteClip
3592  00c8 84            	pop	a
3593                     ; 631 					pt6311_write_digit(0, 1024);
3595  00c9 ae0400        	ldw	x,#1024
3596  00cc 89            	pushw	x
3597  00cd ae0000        	ldw	x,#0
3598  00d0 89            	pushw	x
3599  00d1 4f            	clr	a
3600  00d2 cd0000        	call	_pt6311_write_digit
3602  00d5 5b04          	addw	sp,#4
3604  00d7 2021          	jra	L7621
3605  00d9               L7031:
3606                     ; 634 					pt6311_write_string(6,"ON ");
3608  00d9 ae0065        	ldw	x,#L5721
3609  00dc 89            	pushw	x
3610  00dd a606          	ld	a,#6
3611  00df cd0000        	call	_pt6311_write_string
3613  00e2 85            	popw	x
3614                     ; 635 					RFModulator_SetPeakWhiteClip(&mod,MC44BS374T1_PWC_ON);
3616  00e3 4b00          	push	#0
3617  00e5 ae002a        	ldw	x,#_mod
3618  00e8 cd0000        	call	_RFModulator_SetPeakWhiteClip
3620  00eb 84            	pop	a
3621                     ; 636 					pt6311_write_digit(0, 0x000000);
3623  00ec ae0000        	ldw	x,#0
3624  00ef 89            	pushw	x
3625  00f0 ae0000        	ldw	x,#0
3626  00f3 89            	pushw	x
3627  00f4 4f            	clr	a
3628  00f5 cd0000        	call	_pt6311_write_digit
3630  00f8 5b04          	addw	sp,#4
3631  00fa               L7621:
3632                     ; 639 }
3635  00fa 84            	pop	a
3636  00fb 81            	ret
3666                     ; 641 void tpen_screen(void)//test pattern toggle
3666                     ; 642 {
3667                     .text:	section	.text,new
3668  0000               _tpen_screen:
3672                     ; 643 		if (!change_tracker){
3674                     	btst	_change_tracker
3675  0005 2513          	jrult	L3231
3676                     ; 644 			pt6311_write_string(1,"TPEN");
3678  0007 ae005c        	ldw	x,#L5231
3679  000a 89            	pushw	x
3680  000b a601          	ld	a,#1
3681  000d cd0000        	call	_pt6311_write_string
3683  0010 85            	popw	x
3684                     ; 645 			bool_updaters(current_screen);
3686  0011 b637          	ld	a,_current_screen
3687  0013 cd0000        	call	_bool_updaters
3689                     ; 646 			change_tracker=true;
3691  0016 72100003      	bset	_change_tracker
3692  001a               L3231:
3693                     ; 648 		if (button_accel_check(UP_BTN_READ(), &up_btn)) {
3695  001a ae0019        	ldw	x,#_up_btn
3696  001d 89            	pushw	x
3697  001e c6500b        	ld	a,20491
3698  0021 a510          	bcp	a,#16
3699  0023 2704          	jreq	L632
3700  0025 a601          	ld	a,#1
3701  0027 2001          	jra	L042
3702  0029               L632:
3703  0029 4f            	clr	a
3704  002a               L042:
3705  002a cd0000        	call	_button_accel_check
3707  002d 85            	popw	x
3708  002e 4d            	tnz	a
3709  002f 2709          	jreq	L7231
3710                     ; 649 					tpen = !tpen;
3712  0031 90100001      	bcpl	_tpen
3713                     ; 650 					bool_updaters(current_screen);
3715  0035 b637          	ld	a,_current_screen
3716  0037 cd0000        	call	_bool_updaters
3718  003a               L7231:
3719                     ; 652 }
3722  003a 81            	ret
3752                     ; 654 void pwc_screen(void)
3752                     ; 655 {
3753                     .text:	section	.text,new
3754  0000               _pwc_screen:
3758                     ; 656 		if (!change_tracker){
3760                     	btst	_change_tracker
3761  0005 2513          	jrult	L1431
3762                     ; 657 			pt6311_write_string(1,"PWC");
3764  0007 ae0058        	ldw	x,#L3431
3765  000a 89            	pushw	x
3766  000b a601          	ld	a,#1
3767  000d cd0000        	call	_pt6311_write_string
3769  0010 85            	popw	x
3770                     ; 658 			bool_updaters(current_screen);
3772  0011 b637          	ld	a,_current_screen
3773  0013 cd0000        	call	_bool_updaters
3775                     ; 659 			change_tracker=true;
3777  0016 72100003      	bset	_change_tracker
3778  001a               L1431:
3779                     ; 661 		if (button_accel_check(UP_BTN_READ(), &up_btn)) {
3781  001a ae0019        	ldw	x,#_up_btn
3782  001d 89            	pushw	x
3783  001e c6500b        	ld	a,20491
3784  0021 a510          	bcp	a,#16
3785  0023 2704          	jreq	L442
3786  0025 a601          	ld	a,#1
3787  0027 2001          	jra	L642
3788  0029               L442:
3789  0029 4f            	clr	a
3790  002a               L642:
3791  002a cd0000        	call	_button_accel_check
3793  002d 85            	popw	x
3794  002e 4d            	tnz	a
3795  002f 2709          	jreq	L5431
3796                     ; 662 					pwc = !pwc;
3798  0031 90100002      	bcpl	_pwc
3799                     ; 663 					bool_updaters(current_screen);
3801  0035 b637          	ld	a,_current_screen
3802  0037 cd0000        	call	_bool_updaters
3804  003a               L5431:
3805                     ; 665 }
3808  003a 81            	ret
3838                     ; 667 void ps_ratio_screen(void)
3838                     ; 668 {
3839                     .text:	section	.text,new
3840  0000               _ps_ratio_screen:
3844                     ; 669 		if (!change_tracker){
3846                     	btst	_change_tracker
3847  0005 2513          	jrult	L7531
3848                     ; 670 			pt6311_write_string(1,"P-S");
3850  0007 ae0054        	ldw	x,#L1631
3851  000a 89            	pushw	x
3852  000b a601          	ld	a,#1
3853  000d cd0000        	call	_pt6311_write_string
3855  0010 85            	popw	x
3856                     ; 671 			bool_updaters(current_screen);
3858  0011 b637          	ld	a,_current_screen
3859  0013 cd0000        	call	_bool_updaters
3861                     ; 672 			change_tracker=true;
3863  0016 72100003      	bset	_change_tracker
3864  001a               L7531:
3865                     ; 674 		if (button_accel_check(UP_BTN_READ(), &up_btn)) {
3867  001a ae0019        	ldw	x,#_up_btn
3868  001d 89            	pushw	x
3869  001e c6500b        	ld	a,20491
3870  0021 a510          	bcp	a,#16
3871  0023 2704          	jreq	L252
3872  0025 a601          	ld	a,#1
3873  0027 2001          	jra	L452
3874  0029               L252:
3875  0029 4f            	clr	a
3876  002a               L452:
3877  002a cd0000        	call	_button_accel_check
3879  002d 85            	popw	x
3880  002e 4d            	tnz	a
3881  002f 2709          	jreq	L3631
3882                     ; 675 					ps_ratio = !ps_ratio;
3884  0031 90100000      	bcpl	_ps_ratio
3885                     ; 676 					bool_updaters(current_screen);
3887  0035 b637          	ld	a,_current_screen
3888  0037 cd0000        	call	_bool_updaters
3890  003a               L3631:
3891                     ; 678 }
3894  003a 81            	ret
3924                     ; 680 void sound_screen(void)
3924                     ; 681 {
3925                     .text:	section	.text,new
3926  0000               _sound_screen:
3930                     ; 682     if (!change_tracker) {
3932                     	btst	_change_tracker
3933  0005 2513          	jrult	L5731
3934                     ; 683         pt6311_write_string(1, "SYS");
3936  0007 ae0050        	ldw	x,#L7731
3937  000a 89            	pushw	x
3938  000b a601          	ld	a,#1
3939  000d cd0000        	call	_pt6311_write_string
3941  0010 85            	popw	x
3942                     ; 684         sound_system(sound);
3944  0011 b609          	ld	a,_sound
3945  0013 cd0000        	call	_sound_system
3947                     ; 685         change_tracker = true;
3949  0016 72100003      	bset	_change_tracker
3950  001a               L5731:
3951                     ; 688     if (button_accel_check(UP_BTN_READ(), &up_btn)) {
3953  001a ae0019        	ldw	x,#_up_btn
3954  001d 89            	pushw	x
3955  001e c6500b        	ld	a,20491
3956  0021 a510          	bcp	a,#16
3957  0023 2704          	jreq	L062
3958  0025 a601          	ld	a,#1
3959  0027 2001          	jra	L262
3960  0029               L062:
3961  0029 4f            	clr	a
3962  002a               L262:
3963  002a cd0000        	call	_button_accel_check
3965  002d 85            	popw	x
3966  002e 4d            	tnz	a
3967  002f 2713          	jreq	L1041
3968                     ; 689         if (sound >= DK_6_5MHZ) {
3970  0031 b609          	ld	a,_sound
3971  0033 a103          	cp	a,#3
3972  0035 2504          	jrult	L3041
3973                     ; 690             sound = MN_4_5MHZ;
3975  0037 3f09          	clr	_sound
3977  0039 2002          	jra	L5041
3978  003b               L3041:
3979                     ; 692             sound++;
3981  003b 3c09          	inc	_sound
3982  003d               L5041:
3983                     ; 694         sound_system(sound);
3985  003d b609          	ld	a,_sound
3986  003f cd0000        	call	_sound_system
3989  0042 2028          	jra	L7041
3990  0044               L1041:
3991                     ; 696     else if (button_accel_check(DOWN_BTN_READ(), &down_btn)) {
3993  0044 ae0008        	ldw	x,#_down_btn
3994  0047 89            	pushw	x
3995  0048 c65001        	ld	a,20481
3996  004b a508          	bcp	a,#8
3997  004d 2704          	jreq	L462
3998  004f a601          	ld	a,#1
3999  0051 2001          	jra	L662
4000  0053               L462:
4001  0053 4f            	clr	a
4002  0054               L662:
4003  0054 cd0000        	call	_button_accel_check
4005  0057 85            	popw	x
4006  0058 4d            	tnz	a
4007  0059 2711          	jreq	L7041
4008                     ; 697         if (sound == MN_4_5MHZ) {
4010  005b 3d09          	tnz	_sound
4011  005d 2606          	jrne	L3141
4012                     ; 698             sound = DK_6_5MHZ;
4014  005f 35030009      	mov	_sound,#3
4016  0063 2002          	jra	L5141
4017  0065               L3141:
4018                     ; 700             sound--;
4020  0065 3a09          	dec	_sound
4021  0067               L5141:
4022                     ; 702         sound_system(sound);
4024  0067 b609          	ld	a,_sound
4025  0069 cd0000        	call	_sound_system
4027  006c               L7041:
4028                     ; 704 }
4031  006c 81            	ret
4104                     ; 705 void sound_system(RFMod_sound_system value)
4104                     ; 706 {
4105                     .text:	section	.text,new
4106  0000               _sound_system:
4108  0000 88            	push	a
4109       00000000      OFST:	set	0
4112                     ; 707     if (value > DK_6_5MHZ) {
4114  0001 a104          	cp	a,#4
4115  0003 2502          	jrult	L1641
4116                     ; 708         value = MN_4_5MHZ;
4118  0005 0f01          	clr	(OFST+1,sp)
4119  0007               L1641:
4120                     ; 710     sound = value;
4122  0007 7b01          	ld	a,(OFST+1,sp)
4123  0009 b709          	ld	_sound,a
4124                     ; 711     switch (sound) {
4126  000b b609          	ld	a,_sound
4128                     ; 730         break;
4129  000d 4d            	tnz	a
4130  000e 270b          	jreq	L7141
4131  0010 4a            	dec	a
4132  0011 271d          	jreq	L1241
4133  0013 4a            	dec	a
4134  0014 272f          	jreq	L3241
4135  0016 4a            	dec	a
4136  0017 2741          	jreq	L5241
4137  0019 2052          	jra	L5641
4138  001b               L7141:
4139                     ; 712     case MN_4_5MHZ:
4139                     ; 713         pt6311_write_string(5, "M/N ");
4141  001b ae004b        	ldw	x,#L7641
4142  001e 89            	pushw	x
4143  001f a605          	ld	a,#5
4144  0021 cd0000        	call	_pt6311_write_string
4146  0024 85            	popw	x
4147                     ; 714         RFModulator_SetSoundSubcarrier(&mod, MC44BS374T1_SFD_45);
4149  0025 4b00          	push	#0
4150  0027 ae002a        	ldw	x,#_mod
4151  002a cd0000        	call	_RFModulator_SetSoundSubcarrier
4153  002d 84            	pop	a
4154                     ; 715         break;
4156  002e 203d          	jra	L5641
4157  0030               L1241:
4158                     ; 717     case BG_5_5MHZ:
4158                     ; 718         pt6311_write_string(5, "B/G ");
4160  0030 ae0046        	ldw	x,#L1741
4161  0033 89            	pushw	x
4162  0034 a605          	ld	a,#5
4163  0036 cd0000        	call	_pt6311_write_string
4165  0039 85            	popw	x
4166                     ; 719         RFModulator_SetSoundSubcarrier(&mod, MC44BS374T1_SFD_55);
4168  003a 4b01          	push	#1
4169  003c ae002a        	ldw	x,#_mod
4170  003f cd0000        	call	_RFModulator_SetSoundSubcarrier
4172  0042 84            	pop	a
4173                     ; 720         break;
4175  0043 2028          	jra	L5641
4176  0045               L3241:
4177                     ; 722     case I_6_0MHZ:
4177                     ; 723         pt6311_write_string(5, "I   ");
4179  0045 ae0041        	ldw	x,#L3741
4180  0048 89            	pushw	x
4181  0049 a605          	ld	a,#5
4182  004b cd0000        	call	_pt6311_write_string
4184  004e 85            	popw	x
4185                     ; 724         RFModulator_SetSoundSubcarrier(&mod, MC44BS374T1_SFD_60);
4187  004f 4b02          	push	#2
4188  0051 ae002a        	ldw	x,#_mod
4189  0054 cd0000        	call	_RFModulator_SetSoundSubcarrier
4191  0057 84            	pop	a
4192                     ; 725         break;
4194  0058 2013          	jra	L5641
4195  005a               L5241:
4196                     ; 727     case DK_6_5MHZ:
4196                     ; 728         pt6311_write_string(5, "D/K ");
4198  005a ae003c        	ldw	x,#L5741
4199  005d 89            	pushw	x
4200  005e a605          	ld	a,#5
4201  0060 cd0000        	call	_pt6311_write_string
4203  0063 85            	popw	x
4204                     ; 729         RFModulator_SetSoundSubcarrier(&mod, MC44BS374T1_SFD_65);
4206  0064 4b03          	push	#3
4207  0066 ae002a        	ldw	x,#_mod
4208  0069 cd0000        	call	_RFModulator_SetSoundSubcarrier
4210  006c 84            	pop	a
4211                     ; 730         break;
4213  006d               L5641:
4214                     ; 732 }
4217  006d 84            	pop	a
4218  006e 81            	ret
4242                     ; 733 @svlreg @far @interrupt void reset_handler(void)//skip stext
4242                     ; 734 {
4244                     .text:	section	.text,new
4245  0000               f_reset_handler:
4247  0000 8a            	push	cc
4248  0001 84            	pop	a
4249  0002 a4bf          	and	a,#191
4250  0004 88            	push	a
4251  0005 86            	pop	cc
4252  0006 3b0002        	push	c_x+2
4253  0009 be00          	ldw	x,c_x
4254  000b 89            	pushw	x
4255  000c 3b0002        	push	c_y+2
4256  000f be00          	ldw	x,c_y
4257  0011 89            	pushw	x
4258  0012 be02          	ldw	x,c_lreg+2
4259  0014 89            	pushw	x
4260  0015 be00          	ldw	x,c_lreg
4261  0017 89            	pushw	x
4264                     ; 736     main();
4266  0018 cd0000        	call	_main
4268                     ; 737 }
4271  001b 85            	popw	x
4272  001c bf00          	ldw	c_lreg,x
4273  001e 85            	popw	x
4274  001f bf02          	ldw	c_lreg+2,x
4275  0021 85            	popw	x
4276  0022 bf00          	ldw	c_y,x
4277  0024 320002        	pop	c_y+2
4278  0027 85            	popw	x
4279  0028 bf00          	ldw	c_x,x
4280  002a 320002        	pop	c_x+2
4281  002d 80            	iret
4531                     	xdef	f_reset_handler
4532                     	xdef	_main
4533                     	xdef	f_timer4_isr
4534                     	xdef	_sound_system
4535                     	xdef	_bool_updaters
4536                     	xdef	_channel_recalculate
4537                     	xdef	_channel_update_visuals
4538                     	xdef	_freq_update_visuals
4539                     	xdef	_freq_visuals
4540                     	xdef	_update_screen
4541                     	xdef	_btn_init
4542                     	xdef	_check_st_button
4543                     	xdef	_memory_screen
4544                     	xdef	_pwc_screen
4545                     	xdef	_tpen_screen
4546                     	xdef	_ps_ratio_screen
4547                     	xdef	_sound_screen
4548                     	xdef	_channel_screen
4549                     	xdef	_frequency_screen
4550                     	xdef	_memory_handler
4551                     	xdef	_tim4_isr_setup
4552                     	xdef	_clock_setup
4553                     	xdef	_button_simple_check
4554                     	xdef	_button_accel_check
4555                     	xdef	_button_simple_init
4556                     	xdef	_button_accel_init
4557                     	xdef	_change_tracker
4558                     	xdef	_sound
4559                     	xdef	_last_channel
4560                     	switch	.ubsct
4561  0000               _channel:
4562  0000 00            	ds.b	1
4563                     	xdef	_channel
4564                     	xdef	_pwc
4565                     	xdef	_tpen
4566                     	xdef	_ps_ratio
4567                     	xdef	_mod_frequency
4568  0001               _i:
4569  0001 00            	ds.b	1
4570                     	xdef	_i
4571  0002               _status_btn:
4572  0002 000000000000  	ds.b	6
4573                     	xdef	_status_btn
4574  0008               _down_btn:
4575  0008 000000000000  	ds.b	17
4576                     	xdef	_down_btn
4577  0019               _up_btn:
4578  0019 000000000000  	ds.b	17
4579                     	xdef	_up_btn
4580  002a               _mod:
4581  002a 000000000000  	ds.b	13
4582                     	xdef	_mod
4583  0037               _current_screen:
4584  0037 00            	ds.b	1
4585                     	xdef	_current_screen
4586                     	xref	_RFModulator_SetTestPattern
4587                     	xref	_RFModulator_SetPeakWhiteClip
4588                     	xref	_RFModulator_SetSoundSubcarrier
4589                     	xref	_RFModulator_SetPictureSoundRatio
4590                     	xref	_RFModulator_SetFrequency
4591                     	xref	_RFModulator_Init
4592                     	xref	_swi2c_init
4593                     	xref	_pt6311_write_digit
4594                     	xref	_pt6311_clear_display
4595                     	xref	_pt6311_write_int
4596                     	xref	_pt6311_write_string
4597                     	xref	_pt6311_set_display_state
4598                     	xref	_pt6311_init
4599                     	xref	_delay_ms
4600                     	switch	.const
4601  003c               L5741:
4602  003c 442f4b2000    	dc.b	"D/K ",0
4603  0041               L3741:
4604  0041 4920202000    	dc.b	"I   ",0
4605  0046               L1741:
4606  0046 422f472000    	dc.b	"B/G ",0
4607  004b               L7641:
4608  004b 4d2f4e2000    	dc.b	"M/N ",0
4609  0050               L7731:
4610  0050 53595300      	dc.b	"SYS",0
4611  0054               L1631:
4612  0054 502d5300      	dc.b	"P-S",0
4613  0058               L3431:
4614  0058 50574300      	dc.b	"PWC",0
4615  005c               L5231:
4616  005c 5450454e00    	dc.b	"TPEN",0
4617  0061               L1031:
4618  0061 4f464600      	dc.b	"OFF",0
4619  0065               L5721:
4620  0065 4f4e2000      	dc.b	"ON ",0
4621  0069               L5621:
4622  0069 3132644200    	dc.b	"12dB",0
4623  006e               L1621:
4624  006e 3136644200    	dc.b	"16dB",0
4625  0073               L5021:
4626  0073 4348414e00    	dc.b	"CHAN",0
4627  0078               L557:
4628  0078 303000        	dc.b	"00",0
4629  007b               L124:
4630  007b 5341564500    	dc.b	"SAVE",0
4631  0080               L714:
4632  0080 4f4b00        	dc.b	"OK",0
4633  0083               L314:
4634  0083 534156452000  	dc.b	"SAVE ",0
4635  0089               L34:
4636  0089 4600          	dc.b	"F",0
4637  008b               L14:
4638  008b 545654585631  	dc.b	"TVTXV1-0 ",0
4639                     	xref.b	c_lreg
4640                     	xref.b	c_x
4641                     	xref.b	c_y
4661                     	xref	c_ladc
4662                     	xref	c_vmul
4663                     	xref	c_lgsub
4664                     	xref	c_ladd
4665                     	xref	c_lgadd
4666                     	xref	c_lumd
4667                     	xref	c_ludv
4668                     	xref	c_rtol
4669                     	xref	c_uitolx
4670                     	xref	c_lsub
4671                     	xref	c_lcmp
4672                     	xref	c_ltor
4673                     	xref	c_lgadc
4674                     	end
