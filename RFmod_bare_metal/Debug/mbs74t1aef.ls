   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
  73                     ; 4 void bitWrite(uint8_t* byte, uint8_t bit, uint8_t value) {
  75                     .text:	section	.text,new
  76  0000               _bitWrite:
  78  0000 89            	pushw	x
  79       00000000      OFST:	set	0
  82                     ; 5     if (value) {
  84  0001 0d06          	tnz	(OFST+6,sp)
  85  0003 2715          	jreq	L73
  86                     ; 6         *byte |= (1 << bit);
  88  0005 7b05          	ld	a,(OFST+5,sp)
  89  0007 905f          	clrw	y
  90  0009 9097          	ld	yl,a
  91  000b a601          	ld	a,#1
  92  000d 905d          	tnzw	y
  93  000f 2705          	jreq	L6
  94  0011               L01:
  95  0011 48            	sll	a
  96  0012 905a          	decw	y
  97  0014 26fb          	jrne	L01
  98  0016               L6:
  99  0016 fa            	or	a,(x)
 100  0017 f7            	ld	(x),a
 102  0018 2016          	jra	L14
 103  001a               L73:
 104                     ; 8         *byte &= ~(1 << bit);
 106  001a 1e01          	ldw	x,(OFST+1,sp)
 107  001c 7b05          	ld	a,(OFST+5,sp)
 108  001e 905f          	clrw	y
 109  0020 9097          	ld	yl,a
 110  0022 a601          	ld	a,#1
 111  0024 905d          	tnzw	y
 112  0026 2705          	jreq	L21
 113  0028               L41:
 114  0028 48            	sll	a
 115  0029 905a          	decw	y
 116  002b 26fb          	jrne	L41
 117  002d               L21:
 118  002d 43            	cpl	a
 119  002e f4            	and	a,(x)
 120  002f f7            	ld	(x),a
 121  0030               L14:
 122                     ; 10 }
 125  0030 85            	popw	x
 126  0031 81            	ret
 263                     ; 12 void RFModulator_Init(RFModulator* mod, uint8_t address) {
 264                     .text:	section	.text,new
 265  0000               _RFModulator_Init:
 267  0000 89            	pushw	x
 268       00000000      OFST:	set	0
 271                     ; 13     mod->i2c_address = address;
 273  0001 7b05          	ld	a,(OFST+5,sp)
 274  0003 1e01          	ldw	x,(OFST+1,sp)
 275  0005 f7            	ld	(x),a
 276                     ; 14     mod->rf_test = MC44BS374T1_WM2_NORMAL;
 278  0006 1e01          	ldw	x,(OFST+1,sp)
 279  0008 6f04          	clr	(4,x)
 280                     ; 15     mod->rf_divider = MC44BS374T1_WM1_NORMAL;
 282  000a 1e01          	ldw	x,(OFST+1,sp)
 283  000c 6f03          	clr	(3,x)
 284                     ; 16     mod->rf_so = MC44BS374T1_SO_ON;
 286  000e 1e01          	ldw	x,(OFST+1,sp)
 287  0010 6f05          	clr	(5,x)
 288                     ; 17     mod->rf_lop = MC44BS374T1_LOP_HIGH;
 290  0012 1e01          	ldw	x,(OFST+1,sp)
 291  0014 a601          	ld	a,#1
 292  0016 e706          	ld	(6,x),a
 293                     ; 18     mod->rf_ps = MC44BS374T1_PS_12;
 295  0018 1e01          	ldw	x,(OFST+1,sp)
 296  001a 6f07          	clr	(7,x)
 297                     ; 19     mod->rf_pwc = MC44BS374T1_PWC_ON;
 299  001c 1e01          	ldw	x,(OFST+1,sp)
 300  001e 6f08          	clr	(8,x)
 301                     ; 20     mod->rf_osc = MC44BS374T1_OSC_NORMAL;
 303  0020 1e01          	ldw	x,(OFST+1,sp)
 304  0022 a601          	ld	a,#1
 305  0024 e709          	ld	(9,x),a
 306                     ; 21     mod->rf_att = MC44BS374T1_ATT_NORMAL;
 308  0026 1e01          	ldw	x,(OFST+1,sp)
 309  0028 6f0a          	clr	(10,x)
 310                     ; 22     mod->rf_sfd = MC44BS374T1_SFD_65;
 312  002a 1e01          	ldw	x,(OFST+1,sp)
 313  002c a603          	ld	a,#3
 314  002e e70b          	ld	(11,x),a
 315                     ; 23     mod->rf_tpen = MC44BS374T1_TPEN_OFF;
 317  0030 1e01          	ldw	x,(OFST+1,sp)
 318  0032 6f0c          	clr	(12,x)
 319                     ; 24     mod->rf_value = 0;
 321  0034 1e01          	ldw	x,(OFST+1,sp)
 322  0036 905f          	clrw	y
 323  0038 ef01          	ldw	(1,x),y
 324                     ; 25 }
 327  003a 85            	popw	x
 328  003b 81            	ret
 413                     ; 27 void RFModulator_SendDataRaw(RFModulator* mod, uint8_t c1, uint8_t c0, uint8_t fm, uint8_t fl) {
 414                     .text:	section	.text,new
 415  0000               _RFModulator_SendDataRaw:
 417  0000 89            	pushw	x
 418  0001 5204          	subw	sp,#4
 419       00000004      OFST:	set	4
 422                     ; 29     data[0] = c1;
 424  0003 7b09          	ld	a,(OFST+5,sp)
 425  0005 6b01          	ld	(OFST-3,sp),a
 427                     ; 30     data[1] = c0;
 429  0007 7b0a          	ld	a,(OFST+6,sp)
 430  0009 6b02          	ld	(OFST-2,sp),a
 432                     ; 31     data[2] = fm;
 434  000b 7b0b          	ld	a,(OFST+7,sp)
 435  000d 6b03          	ld	(OFST-1,sp),a
 437                     ; 32     data[3] = fl;
 439  000f 7b0c          	ld	a,(OFST+8,sp)
 440  0011 6b04          	ld	(OFST+0,sp),a
 442                     ; 33     swi2c_write_array(mod->i2c_address, data, 4);
 444  0013 ae0004        	ldw	x,#4
 445  0016 89            	pushw	x
 446  0017 96            	ldw	x,sp
 447  0018 1c0003        	addw	x,#OFST-1
 448  001b 89            	pushw	x
 449  001c 1e09          	ldw	x,(OFST+5,sp)
 450  001e f6            	ld	a,(x)
 451  001f cd0000        	call	_swi2c_write_array
 453  0022 5b04          	addw	sp,#4
 454                     ; 34 }
 457  0024 5b06          	addw	sp,#6
 458  0026 81            	ret
 539                     ; 36 uint8_t RFModulator_RegisterC1(uint8_t so, uint8_t lop, uint8_t ps, uint8_t wm2, uint8_t wm1) {
 540                     .text:	section	.text,new
 541  0000               _RFModulator_RegisterC1:
 543  0000 89            	pushw	x
 544  0001 88            	push	a
 545       00000001      OFST:	set	1
 548                     ; 37     uint8_t output = 0x80;
 550  0002 a680          	ld	a,#128
 551  0004 6b01          	ld	(OFST+0,sp),a
 553                     ; 38     bitWrite(&output, 5, so);
 555  0006 9e            	ld	a,xh
 556  0007 88            	push	a
 557  0008 4b05          	push	#5
 558  000a 96            	ldw	x,sp
 559  000b 1c0003        	addw	x,#OFST+2
 560  000e cd0000        	call	_bitWrite
 562  0011 85            	popw	x
 563                     ; 39     bitWrite(&output, 4, lop);
 565  0012 7b03          	ld	a,(OFST+2,sp)
 566  0014 88            	push	a
 567  0015 4b04          	push	#4
 568  0017 96            	ldw	x,sp
 569  0018 1c0003        	addw	x,#OFST+2
 570  001b cd0000        	call	_bitWrite
 572  001e 85            	popw	x
 573                     ; 40     bitWrite(&output, 3, ps);
 575  001f 7b06          	ld	a,(OFST+5,sp)
 576  0021 88            	push	a
 577  0022 4b03          	push	#3
 578  0024 96            	ldw	x,sp
 579  0025 1c0003        	addw	x,#OFST+2
 580  0028 cd0000        	call	_bitWrite
 582  002b 85            	popw	x
 583                     ; 41     bitWrite(&output, 2, (wm2 & 0x01));
 585  002c 7b07          	ld	a,(OFST+6,sp)
 586  002e a401          	and	a,#1
 587  0030 88            	push	a
 588  0031 4b02          	push	#2
 589  0033 96            	ldw	x,sp
 590  0034 1c0003        	addw	x,#OFST+2
 591  0037 cd0000        	call	_bitWrite
 593  003a 85            	popw	x
 594                     ; 42     bitWrite(&output, 1, (wm1 & 0x04) >> 2);
 596  003b 7b08          	ld	a,(OFST+7,sp)
 597  003d 44            	srl	a
 598  003e 44            	srl	a
 599  003f a401          	and	a,#1
 600  0041 88            	push	a
 601  0042 4b01          	push	#1
 602  0044 96            	ldw	x,sp
 603  0045 1c0003        	addw	x,#OFST+2
 604  0048 cd0000        	call	_bitWrite
 606  004b 85            	popw	x
 607                     ; 43     bitWrite(&output, 0, 0);
 609  004c 4b00          	push	#0
 610  004e 4b00          	push	#0
 611  0050 96            	ldw	x,sp
 612  0051 1c0003        	addw	x,#OFST+2
 613  0054 cd0000        	call	_bitWrite
 615  0057 85            	popw	x
 616                     ; 44     return output;
 618  0058 7b01          	ld	a,(OFST+0,sp)
 621  005a 5b03          	addw	sp,#3
 622  005c 81            	ret
 703                     ; 47 uint8_t RFModulator_RegisterC0(uint8_t pwc, uint8_t osc, uint8_t att, uint8_t sfd, uint8_t wm2) {
 704                     .text:	section	.text,new
 705  0000               _RFModulator_RegisterC0:
 707  0000 89            	pushw	x
 708  0001 88            	push	a
 709       00000001      OFST:	set	1
 712                     ; 48     uint8_t output = 0x00;
 714  0002 0f01          	clr	(OFST+0,sp)
 716                     ; 49     bitWrite(&output, 7, pwc);
 718  0004 9e            	ld	a,xh
 719  0005 88            	push	a
 720  0006 4b07          	push	#7
 721  0008 96            	ldw	x,sp
 722  0009 1c0003        	addw	x,#OFST+2
 723  000c cd0000        	call	_bitWrite
 725  000f 85            	popw	x
 726                     ; 50     bitWrite(&output, 6, osc);
 728  0010 7b03          	ld	a,(OFST+2,sp)
 729  0012 88            	push	a
 730  0013 4b06          	push	#6
 731  0015 96            	ldw	x,sp
 732  0016 1c0003        	addw	x,#OFST+2
 733  0019 cd0000        	call	_bitWrite
 735  001c 85            	popw	x
 736                     ; 51     bitWrite(&output, 5, att);
 738  001d 7b06          	ld	a,(OFST+5,sp)
 739  001f 88            	push	a
 740  0020 4b05          	push	#5
 741  0022 96            	ldw	x,sp
 742  0023 1c0003        	addw	x,#OFST+2
 743  0026 cd0000        	call	_bitWrite
 745  0029 85            	popw	x
 746                     ; 52     bitWrite(&output, 4, (sfd & 0x02) >> 1);
 748  002a 7b07          	ld	a,(OFST+6,sp)
 749  002c 44            	srl	a
 750  002d a401          	and	a,#1
 751  002f 88            	push	a
 752  0030 4b04          	push	#4
 753  0032 96            	ldw	x,sp
 754  0033 1c0003        	addw	x,#OFST+2
 755  0036 cd0000        	call	_bitWrite
 757  0039 85            	popw	x
 758                     ; 53     bitWrite(&output, 3, (sfd & 0x01));
 760  003a 7b07          	ld	a,(OFST+6,sp)
 761  003c a401          	and	a,#1
 762  003e 88            	push	a
 763  003f 4b03          	push	#3
 764  0041 96            	ldw	x,sp
 765  0042 1c0003        	addw	x,#OFST+2
 766  0045 cd0000        	call	_bitWrite
 768  0048 85            	popw	x
 769                     ; 54     bitWrite(&output, 2, 0);
 771  0049 4b00          	push	#0
 772  004b 4b02          	push	#2
 773  004d 96            	ldw	x,sp
 774  004e 1c0003        	addw	x,#OFST+2
 775  0051 cd0000        	call	_bitWrite
 777  0054 85            	popw	x
 778                     ; 55     bitWrite(&output, 1, (wm2 & 0x04) >> 2);
 780  0055 7b08          	ld	a,(OFST+7,sp)
 781  0057 44            	srl	a
 782  0058 44            	srl	a
 783  0059 a401          	and	a,#1
 784  005b 88            	push	a
 785  005c 4b01          	push	#1
 786  005e 96            	ldw	x,sp
 787  005f 1c0003        	addw	x,#OFST+2
 788  0062 cd0000        	call	_bitWrite
 790  0065 85            	popw	x
 791                     ; 56     bitWrite(&output, 0, (wm2 & 0x02) >> 1);
 793  0066 7b08          	ld	a,(OFST+7,sp)
 794  0068 44            	srl	a
 795  0069 a401          	and	a,#1
 796  006b 88            	push	a
 797  006c 4b00          	push	#0
 798  006e 96            	ldw	x,sp
 799  006f 1c0003        	addw	x,#OFST+2
 800  0072 cd0000        	call	_bitWrite
 802  0075 85            	popw	x
 803                     ; 57     return output;
 805  0076 7b01          	ld	a,(OFST+0,sp)
 808  0078 5b03          	addw	sp,#3
 809  007a 81            	ret
 863                     ; 60 uint8_t RFModulator_RegisterFM(uint8_t tpen, uint16_t divider) {
 864                     .text:	section	.text,new
 865  0000               _RFModulator_RegisterFM:
 867  0000 88            	push	a
 868  0001 88            	push	a
 869       00000001      OFST:	set	1
 872                     ; 61     uint8_t output = 0x00;
 874  0002 0f01          	clr	(OFST+0,sp)
 876                     ; 62     bitWrite(&output, 6, tpen);
 878  0004 88            	push	a
 879  0005 4b06          	push	#6
 880  0007 96            	ldw	x,sp
 881  0008 1c0003        	addw	x,#OFST+2
 882  000b cd0000        	call	_bitWrite
 884  000e 85            	popw	x
 885                     ; 63     bitWrite(&output, 5, (divider & 0x800) >> 11);
 887  000f 1e05          	ldw	x,(OFST+4,sp)
 888  0011 4f            	clr	a
 889  0012 01            	rrwa	x,a
 890  0013 54            	srlw	x
 891  0014 54            	srlw	x
 892  0015 54            	srlw	x
 893  0016 01            	rrwa	x,a
 894  0017 a401          	and	a,#1
 895  0019 5f            	clrw	x
 896  001a 88            	push	a
 897  001b 4b05          	push	#5
 898  001d 96            	ldw	x,sp
 899  001e 1c0003        	addw	x,#OFST+2
 900  0021 cd0000        	call	_bitWrite
 902  0024 85            	popw	x
 903                     ; 64     bitWrite(&output, 4, (divider & 0x400) >> 10);
 905  0025 1e05          	ldw	x,(OFST+4,sp)
 906  0027 4f            	clr	a
 907  0028 01            	rrwa	x,a
 908  0029 54            	srlw	x
 909  002a 54            	srlw	x
 910  002b 01            	rrwa	x,a
 911  002c a401          	and	a,#1
 912  002e 5f            	clrw	x
 913  002f 88            	push	a
 914  0030 4b04          	push	#4
 915  0032 96            	ldw	x,sp
 916  0033 1c0003        	addw	x,#OFST+2
 917  0036 cd0000        	call	_bitWrite
 919  0039 85            	popw	x
 920                     ; 65     bitWrite(&output, 3, (divider & 0x200) >> 9);
 922  003a 1e05          	ldw	x,(OFST+4,sp)
 923  003c 4f            	clr	a
 924  003d 01            	rrwa	x,a
 925  003e 54            	srlw	x
 926  003f 01            	rrwa	x,a
 927  0040 a401          	and	a,#1
 928  0042 5f            	clrw	x
 929  0043 88            	push	a
 930  0044 4b03          	push	#3
 931  0046 96            	ldw	x,sp
 932  0047 1c0003        	addw	x,#OFST+2
 933  004a cd0000        	call	_bitWrite
 935  004d 85            	popw	x
 936                     ; 66     bitWrite(&output, 2, (divider & 0x100) >> 8);
 938  004e 7b05          	ld	a,(OFST+4,sp)
 939  0050 a401          	and	a,#1
 940  0052 88            	push	a
 941  0053 4b02          	push	#2
 942  0055 96            	ldw	x,sp
 943  0056 1c0003        	addw	x,#OFST+2
 944  0059 cd0000        	call	_bitWrite
 946  005c 85            	popw	x
 947                     ; 67     bitWrite(&output, 1, (divider & 0x080) >> 7);
 949  005d 7b06          	ld	a,(OFST+5,sp)
 950  005f 49            	rlc	a
 951  0060 4f            	clr	a
 952  0061 49            	rlc	a
 953  0062 a401          	and	a,#1
 954  0064 88            	push	a
 955  0065 4b01          	push	#1
 956  0067 96            	ldw	x,sp
 957  0068 1c0003        	addw	x,#OFST+2
 958  006b cd0000        	call	_bitWrite
 960  006e 85            	popw	x
 961                     ; 68     bitWrite(&output, 0, (divider & 0x040) >> 6);
 963  006f 7b06          	ld	a,(OFST+5,sp)
 964  0071 4e            	swap	a
 965  0072 44            	srl	a
 966  0073 44            	srl	a
 967  0074 a403          	and	a,#3
 968  0076 a401          	and	a,#1
 969  0078 88            	push	a
 970  0079 4b00          	push	#0
 971  007b 96            	ldw	x,sp
 972  007c 1c0003        	addw	x,#OFST+2
 973  007f cd0000        	call	_bitWrite
 975  0082 85            	popw	x
 976                     ; 69     return output;
 978  0083 7b01          	ld	a,(OFST+0,sp)
 981  0085 85            	popw	x
 982  0086 81            	ret
1036                     ; 72 uint8_t RFModulator_RegisterFL(uint16_t divider, uint8_t wm1) {
1037                     .text:	section	.text,new
1038  0000               _RFModulator_RegisterFL:
1040  0000 89            	pushw	x
1041  0001 88            	push	a
1042       00000001      OFST:	set	1
1045                     ; 73     uint8_t output = 0x00;
1047  0002 0f01          	clr	(OFST+0,sp)
1049                     ; 74     bitWrite(&output, 7, (divider & 0x020) >> 5);
1051  0004 9f            	ld	a,xl
1052  0005 4e            	swap	a
1053  0006 44            	srl	a
1054  0007 a407          	and	a,#7
1055  0009 a401          	and	a,#1
1056  000b 88            	push	a
1057  000c 4b07          	push	#7
1058  000e 96            	ldw	x,sp
1059  000f 1c0003        	addw	x,#OFST+2
1060  0012 cd0000        	call	_bitWrite
1062  0015 85            	popw	x
1063                     ; 75     bitWrite(&output, 6, (divider & 0x010) >> 4);
1065  0016 7b03          	ld	a,(OFST+2,sp)
1066  0018 4e            	swap	a
1067  0019 a40f          	and	a,#15
1068  001b a401          	and	a,#1
1069  001d 88            	push	a
1070  001e 4b06          	push	#6
1071  0020 96            	ldw	x,sp
1072  0021 1c0003        	addw	x,#OFST+2
1073  0024 cd0000        	call	_bitWrite
1075  0027 85            	popw	x
1076                     ; 76     bitWrite(&output, 5, (divider & 0x008) >> 3);
1078  0028 7b03          	ld	a,(OFST+2,sp)
1079  002a 44            	srl	a
1080  002b 44            	srl	a
1081  002c 44            	srl	a
1082  002d a401          	and	a,#1
1083  002f 88            	push	a
1084  0030 4b05          	push	#5
1085  0032 96            	ldw	x,sp
1086  0033 1c0003        	addw	x,#OFST+2
1087  0036 cd0000        	call	_bitWrite
1089  0039 85            	popw	x
1090                     ; 77     bitWrite(&output, 4, (divider & 0x004) >> 2);
1092  003a 7b03          	ld	a,(OFST+2,sp)
1093  003c 44            	srl	a
1094  003d 44            	srl	a
1095  003e a401          	and	a,#1
1096  0040 88            	push	a
1097  0041 4b04          	push	#4
1098  0043 96            	ldw	x,sp
1099  0044 1c0003        	addw	x,#OFST+2
1100  0047 cd0000        	call	_bitWrite
1102  004a 85            	popw	x
1103                     ; 78     bitWrite(&output, 3, (divider & 0x002) >> 1);
1105  004b 7b03          	ld	a,(OFST+2,sp)
1106  004d 44            	srl	a
1107  004e a401          	and	a,#1
1108  0050 88            	push	a
1109  0051 4b03          	push	#3
1110  0053 96            	ldw	x,sp
1111  0054 1c0003        	addw	x,#OFST+2
1112  0057 cd0000        	call	_bitWrite
1114  005a 85            	popw	x
1115                     ; 79     bitWrite(&output, 2, (divider & 0x001));
1117  005b 7b03          	ld	a,(OFST+2,sp)
1118  005d a401          	and	a,#1
1119  005f 88            	push	a
1120  0060 4b02          	push	#2
1121  0062 96            	ldw	x,sp
1122  0063 1c0003        	addw	x,#OFST+2
1123  0066 cd0000        	call	_bitWrite
1125  0069 85            	popw	x
1126                     ; 80     bitWrite(&output, 1, (wm1 & 0x02) >> 1);
1128  006a 7b06          	ld	a,(OFST+5,sp)
1129  006c 44            	srl	a
1130  006d a401          	and	a,#1
1131  006f 88            	push	a
1132  0070 4b01          	push	#1
1133  0072 96            	ldw	x,sp
1134  0073 1c0003        	addw	x,#OFST+2
1135  0076 cd0000        	call	_bitWrite
1137  0079 85            	popw	x
1138                     ; 81     bitWrite(&output, 0, (wm1 & 0x01));
1140  007a 7b06          	ld	a,(OFST+5,sp)
1141  007c a401          	and	a,#1
1142  007e 88            	push	a
1143  007f 4b00          	push	#0
1144  0081 96            	ldw	x,sp
1145  0082 1c0003        	addw	x,#OFST+2
1146  0085 cd0000        	call	_bitWrite
1148  0088 85            	popw	x
1149                     ; 82     return output;
1151  0089 7b01          	ld	a,(OFST+0,sp)
1154  008b 5b03          	addw	sp,#3
1155  008d 81            	ret
1221                     .const:	section	.text
1222  0000               L43:
1223  0000 000d6d81      	dc.l	880001
1224  0004               L63:
1225  0004 000704e1      	dc.l	460001
1226  0008               L04:
1227  0008 00038271      	dc.l	230001
1228  000c               L24:
1229  000c 0001c139      	dc.l	115001
1230  0010               L44:
1231  0010 0000e09d      	dc.l	57501
1232  0014               L64:
1233  0014 0000afc9      	dc.l	45001
1234  0018               L05:
1235  0018 0000000a      	dc.l	10
1236  001c               L25:
1237  001c 00000064      	dc.l	100
1238                     ; 85 void RFModulator_SetFrequency(RFModulator* mod, uint32_t freq) {
1239                     .text:	section	.text,new
1240  0000               _RFModulator_SetFrequency:
1242  0000 89            	pushw	x
1243  0001 5205          	subw	sp,#5
1244       00000005      OFST:	set	5
1247                     ; 86     uint8_t rfdivider = 1;
1249                     ; 88     if((freq <= MC44BS374T1_UHF_MAX) && (freq > MC44BS374T1_UHF_MIN)) {
1251  0003 96            	ldw	x,sp
1252  0004 1c000a        	addw	x,#OFST+5
1253  0007 cd0000        	call	c_ltor
1255  000a ae0000        	ldw	x,#L43
1256  000d cd0000        	call	c_lcmp
1258  0010 241b          	jruge	L304
1260  0012 96            	ldw	x,sp
1261  0013 1c000a        	addw	x,#OFST+5
1262  0016 cd0000        	call	c_ltor
1264  0019 ae0004        	ldw	x,#L63
1265  001c cd0000        	call	c_lcmp
1267  001f 250c          	jrult	L304
1268                     ; 89         rfdivider = 1;
1270  0021 a601          	ld	a,#1
1271  0023 6b05          	ld	(OFST+0,sp),a
1273                     ; 90         mod->rf_divider = MC44BS374T1_WM1_NORMAL;
1275  0025 1e06          	ldw	x,(OFST+1,sp)
1276  0027 6f03          	clr	(3,x)
1278  0029 ace900e9      	jpf	L504
1279  002d               L304:
1280                     ; 92     else if((freq <= MC44BS374T1_VHF_MAX) && (freq > 230000)) {
1282  002d 96            	ldw	x,sp
1283  002e 1c000a        	addw	x,#OFST+5
1284  0031 cd0000        	call	c_ltor
1286  0034 ae0004        	ldw	x,#L63
1287  0037 cd0000        	call	c_lcmp
1289  003a 241d          	jruge	L704
1291  003c 96            	ldw	x,sp
1292  003d 1c000a        	addw	x,#OFST+5
1293  0040 cd0000        	call	c_ltor
1295  0043 ae0008        	ldw	x,#L04
1296  0046 cd0000        	call	c_lcmp
1298  0049 250e          	jrult	L704
1299                     ; 93         rfdivider = 2;
1301  004b a602          	ld	a,#2
1302  004d 6b05          	ld	(OFST+0,sp),a
1304                     ; 94         mod->rf_divider = MC44BS374T1_WM1_RF2;
1306  004f 1e06          	ldw	x,(OFST+1,sp)
1307  0051 a601          	ld	a,#1
1308  0053 e703          	ld	(3,x),a
1310  0055 ace900e9      	jpf	L504
1311  0059               L704:
1312                     ; 96     else if((freq <= 230000) && (freq > 115000)) {
1314  0059 96            	ldw	x,sp
1315  005a 1c000a        	addw	x,#OFST+5
1316  005d cd0000        	call	c_ltor
1318  0060 ae0008        	ldw	x,#L04
1319  0063 cd0000        	call	c_lcmp
1321  0066 241b          	jruge	L314
1323  0068 96            	ldw	x,sp
1324  0069 1c000a        	addw	x,#OFST+5
1325  006c cd0000        	call	c_ltor
1327  006f ae000c        	ldw	x,#L24
1328  0072 cd0000        	call	c_lcmp
1330  0075 250c          	jrult	L314
1331                     ; 97         rfdivider = 4;
1333  0077 a604          	ld	a,#4
1334  0079 6b05          	ld	(OFST+0,sp),a
1336                     ; 98         mod->rf_divider = MC44BS374T1_WM1_RF4;
1338  007b 1e06          	ldw	x,(OFST+1,sp)
1339  007d a602          	ld	a,#2
1340  007f e703          	ld	(3,x),a
1342  0081 2066          	jra	L504
1343  0083               L314:
1344                     ; 100     else if((freq <= 115000) && (freq > 57500)) {
1346  0083 96            	ldw	x,sp
1347  0084 1c000a        	addw	x,#OFST+5
1348  0087 cd0000        	call	c_ltor
1350  008a ae000c        	ldw	x,#L24
1351  008d cd0000        	call	c_lcmp
1353  0090 241b          	jruge	L714
1355  0092 96            	ldw	x,sp
1356  0093 1c000a        	addw	x,#OFST+5
1357  0096 cd0000        	call	c_ltor
1359  0099 ae0010        	ldw	x,#L44
1360  009c cd0000        	call	c_lcmp
1362  009f 250c          	jrult	L714
1363                     ; 101         rfdivider = 8;
1365  00a1 a608          	ld	a,#8
1366  00a3 6b05          	ld	(OFST+0,sp),a
1368                     ; 102         mod->rf_divider = MC44BS374T1_WM1_RF8;
1370  00a5 1e06          	ldw	x,(OFST+1,sp)
1371  00a7 a603          	ld	a,#3
1372  00a9 e703          	ld	(3,x),a
1374  00ab 203c          	jra	L504
1375  00ad               L714:
1376                     ; 104     else if((freq <= 57500) && (freq > MC44BS374T1_VHF_MIN)) {
1378  00ad 96            	ldw	x,sp
1379  00ae 1c000a        	addw	x,#OFST+5
1380  00b1 cd0000        	call	c_ltor
1382  00b4 ae0010        	ldw	x,#L44
1383  00b7 cd0000        	call	c_lcmp
1385  00ba 241b          	jruge	L324
1387  00bc 96            	ldw	x,sp
1388  00bd 1c000a        	addw	x,#OFST+5
1389  00c0 cd0000        	call	c_ltor
1391  00c3 ae0014        	ldw	x,#L64
1392  00c6 cd0000        	call	c_lcmp
1394  00c9 250c          	jrult	L324
1395                     ; 105         rfdivider = 16;
1397  00cb a610          	ld	a,#16
1398  00cd 6b05          	ld	(OFST+0,sp),a
1400                     ; 106         mod->rf_divider = MC44BS374T1_WM1_RF16;
1402  00cf 1e06          	ldw	x,(OFST+1,sp)
1403  00d1 a604          	ld	a,#4
1404  00d3 e703          	ld	(3,x),a
1406  00d5 2012          	jra	L504
1407  00d7               L324:
1408                     ; 109         rfdivider = 1;
1410  00d7 a601          	ld	a,#1
1411  00d9 6b05          	ld	(OFST+0,sp),a
1413                     ; 110         mod->rf_divider = MC44BS374T1_WM1_NORMAL;
1415  00db 1e06          	ldw	x,(OFST+1,sp)
1416  00dd 6f03          	clr	(3,x)
1417                     ; 111         freq = 871250;
1419  00df ae4b52        	ldw	x,#19282
1420  00e2 1f0c          	ldw	(OFST+7,sp),x
1421  00e4 ae000d        	ldw	x,#13
1422  00e7 1f0a          	ldw	(OFST+5,sp),x
1423  00e9               L504:
1424                     ; 114     freqdiv = freq / 10;
1426  00e9 96            	ldw	x,sp
1427  00ea 1c000a        	addw	x,#OFST+5
1428  00ed cd0000        	call	c_ltor
1430  00f0 ae0018        	ldw	x,#L05
1431  00f3 cd0000        	call	c_ludv
1433  00f6 96            	ldw	x,sp
1434  00f7 1c0001        	addw	x,#OFST-4
1435  00fa cd0000        	call	c_rtol
1438                     ; 115     freqdiv *= 4 * rfdivider;
1440  00fd 7b05          	ld	a,(OFST+0,sp)
1441  00ff 97            	ld	xl,a
1442  0100 a604          	ld	a,#4
1443  0102 42            	mul	x,a
1444  0103 cd0000        	call	c_itolx
1446  0106 96            	ldw	x,sp
1447  0107 1c0001        	addw	x,#OFST-4
1448  010a cd0000        	call	c_lgmul
1451                     ; 116     mod->rf_value = (uint16_t)(freqdiv / 100);
1453  010d 96            	ldw	x,sp
1454  010e 1c0001        	addw	x,#OFST-4
1455  0111 cd0000        	call	c_ltor
1457  0114 ae001c        	ldw	x,#L25
1458  0117 cd0000        	call	c_ludv
1460  011a be02          	ldw	x,c_lreg+2
1461  011c 1606          	ldw	y,(OFST+1,sp)
1462  011e 90ef01        	ldw	(1,y),x
1463                     ; 118     RFModulator_SendRegister(mod);
1465  0121 1e06          	ldw	x,(OFST+1,sp)
1466  0123 cd0000        	call	_RFModulator_SendRegister
1468                     ; 119 }
1471  0126 5b07          	addw	sp,#7
1472  0128 81            	ret
1520                     ; 121 void RFModulator_SetPictureSoundRatio(RFModulator* mod, uint8_t val) {
1521                     .text:	section	.text,new
1522  0000               _RFModulator_SetPictureSoundRatio:
1524  0000 89            	pushw	x
1525       00000000      OFST:	set	0
1528                     ; 122     mod->rf_ps = val;
1530  0001 7b05          	ld	a,(OFST+5,sp)
1531  0003 1e01          	ldw	x,(OFST+1,sp)
1532  0005 e707          	ld	(7,x),a
1533                     ; 123     RFModulator_SendRegister(mod);
1535  0007 1e01          	ldw	x,(OFST+1,sp)
1536  0009 cd0000        	call	_RFModulator_SendRegister
1538                     ; 124 }
1541  000c 85            	popw	x
1542  000d 81            	ret
1590                     ; 126 void RFModulator_SetSoundSubcarrier(RFModulator* mod, uint8_t val) {
1591                     .text:	section	.text,new
1592  0000               _RFModulator_SetSoundSubcarrier:
1594  0000 89            	pushw	x
1595       00000000      OFST:	set	0
1598                     ; 127     mod->rf_sfd = val;
1600  0001 7b05          	ld	a,(OFST+5,sp)
1601  0003 1e01          	ldw	x,(OFST+1,sp)
1602  0005 e70b          	ld	(11,x),a
1603                     ; 128     RFModulator_SendRegister(mod);
1605  0007 1e01          	ldw	x,(OFST+1,sp)
1606  0009 cd0000        	call	_RFModulator_SendRegister
1608                     ; 129 }
1611  000c 85            	popw	x
1612  000d 81            	ret
1660                     ; 146 void RFModulator_SetSoundOscillator(RFModulator* mod, uint8_t state) {
1661                     .text:	section	.text,new
1662  0000               _RFModulator_SetSoundOscillator:
1664  0000 89            	pushw	x
1665       00000000      OFST:	set	0
1668                     ; 147     mod->rf_so = state;
1670  0001 7b05          	ld	a,(OFST+5,sp)
1671  0003 1e01          	ldw	x,(OFST+1,sp)
1672  0005 e705          	ld	(5,x),a
1673                     ; 148     RFModulator_SendRegister(mod);
1675  0007 1e01          	ldw	x,(OFST+1,sp)
1676  0009 cd0000        	call	_RFModulator_SendRegister
1678                     ; 149 }
1681  000c 85            	popw	x
1682  000d 81            	ret
1730                     ; 151 void RFModulator_SetLogicOutputPort(RFModulator* mod, uint8_t state) {
1731                     .text:	section	.text,new
1732  0000               _RFModulator_SetLogicOutputPort:
1734  0000 89            	pushw	x
1735       00000000      OFST:	set	0
1738                     ; 152     mod->rf_lop = state;
1740  0001 7b05          	ld	a,(OFST+5,sp)
1741  0003 1e01          	ldw	x,(OFST+1,sp)
1742  0005 e706          	ld	(6,x),a
1743                     ; 153     RFModulator_SendRegister(mod);
1745  0007 1e01          	ldw	x,(OFST+1,sp)
1746  0009 cd0000        	call	_RFModulator_SendRegister
1748                     ; 154 }
1751  000c 85            	popw	x
1752  000d 81            	ret
1800                     ; 156 void RFModulator_SetPeakWhiteClip(RFModulator* mod, uint8_t state) {
1801                     .text:	section	.text,new
1802  0000               _RFModulator_SetPeakWhiteClip:
1804  0000 89            	pushw	x
1805       00000000      OFST:	set	0
1808                     ; 157     mod->rf_pwc = state;
1810  0001 7b05          	ld	a,(OFST+5,sp)
1811  0003 1e01          	ldw	x,(OFST+1,sp)
1812  0005 e708          	ld	(8,x),a
1813                     ; 158     RFModulator_SendRegister(mod);
1815  0007 1e01          	ldw	x,(OFST+1,sp)
1816  0009 cd0000        	call	_RFModulator_SendRegister
1818                     ; 159 }
1821  000c 85            	popw	x
1822  000d 81            	ret
1870                     ; 161 void RFModulator_SetOscillator(RFModulator* mod, uint8_t state) {
1871                     .text:	section	.text,new
1872  0000               _RFModulator_SetOscillator:
1874  0000 89            	pushw	x
1875       00000000      OFST:	set	0
1878                     ; 162     mod->rf_osc = state;
1880  0001 7b05          	ld	a,(OFST+5,sp)
1881  0003 1e01          	ldw	x,(OFST+1,sp)
1882  0005 e709          	ld	(9,x),a
1883                     ; 163     RFModulator_SendRegister(mod);
1885  0007 1e01          	ldw	x,(OFST+1,sp)
1886  0009 cd0000        	call	_RFModulator_SendRegister
1888                     ; 164 }
1891  000c 85            	popw	x
1892  000d 81            	ret
1940                     ; 166 void RFModulator_SetAttenuation(RFModulator* mod, uint8_t state) {
1941                     .text:	section	.text,new
1942  0000               _RFModulator_SetAttenuation:
1944  0000 89            	pushw	x
1945       00000000      OFST:	set	0
1948                     ; 167     mod->rf_att = state;
1950  0001 7b05          	ld	a,(OFST+5,sp)
1951  0003 1e01          	ldw	x,(OFST+1,sp)
1952  0005 e70a          	ld	(10,x),a
1953                     ; 168     RFModulator_SendRegister(mod);
1955  0007 1e01          	ldw	x,(OFST+1,sp)
1956  0009 cd0000        	call	_RFModulator_SendRegister
1958                     ; 169 }
1961  000c 85            	popw	x
1962  000d 81            	ret
2010                     ; 171 void RFModulator_SetTestPattern(RFModulator* mod, uint8_t state) {
2011                     .text:	section	.text,new
2012  0000               _RFModulator_SetTestPattern:
2014  0000 89            	pushw	x
2015       00000000      OFST:	set	0
2018                     ; 172     mod->rf_tpen = state;
2020  0001 7b05          	ld	a,(OFST+5,sp)
2021  0003 1e01          	ldw	x,(OFST+1,sp)
2022  0005 e70c          	ld	(12,x),a
2023                     ; 173     RFModulator_SendRegister(mod);
2025  0007 1e01          	ldw	x,(OFST+1,sp)
2026  0009 cd0000        	call	_RFModulator_SendRegister
2028                     ; 174 }
2031  000c 85            	popw	x
2032  000d 81            	ret
2080                     ; 176 void RFModulator_SetTestMode(RFModulator* mod, uint8_t state) {
2081                     .text:	section	.text,new
2082  0000               _RFModulator_SetTestMode:
2084  0000 89            	pushw	x
2085       00000000      OFST:	set	0
2088                     ; 177     mod->rf_test = state;
2090  0001 7b05          	ld	a,(OFST+5,sp)
2091  0003 1e01          	ldw	x,(OFST+1,sp)
2092  0005 e704          	ld	(4,x),a
2093                     ; 178     RFModulator_SendRegister(mod);
2095  0007 1e01          	ldw	x,(OFST+1,sp)
2096  0009 cd0000        	call	_RFModulator_SendRegister
2098                     ; 179 }
2101  000c 85            	popw	x
2102  000d 81            	ret
2105                     	switch	.const
2106  0020               L317_data:
2107  0020 00            	dc.b	0
2163                     ; 181 uint8_t RFModulator_GetStatus(RFModulator* mod) {
2164                     .text:	section	.text,new
2165  0000               _RFModulator_GetStatus:
2167  0000 89            	pushw	x
2168  0001 89            	pushw	x
2169       00000002      OFST:	set	2
2172                     ; 182     uint8_t data[1] = {0};
2174  0002 c60020        	ld	a,L317_data
2175  0005 6b02          	ld	(OFST+0,sp),a
2176                     ; 183     uint8_t result = swi2c_read_array(mod->i2c_address, data, 1);
2178  0007 ae0001        	ldw	x,#1
2179  000a 89            	pushw	x
2180  000b 96            	ldw	x,sp
2181  000c 1c0004        	addw	x,#OFST+2
2182  000f 89            	pushw	x
2183  0010 1e07          	ldw	x,(OFST+5,sp)
2184  0012 f6            	ld	a,(x)
2185  0013 cd0000        	call	_swi2c_read_array
2187  0016 5b04          	addw	sp,#4
2188  0018 6b01          	ld	(OFST-1,sp),a
2190                     ; 184     if(result == 0) {
2192  001a 0d01          	tnz	(OFST-1,sp)
2193  001c 2604          	jrne	L547
2194                     ; 185         return data[0];
2196  001e 7b02          	ld	a,(OFST+0,sp)
2198  0020 2002          	jra	L001
2199  0022               L547:
2200                     ; 187     return 0xFF;
2202  0022 a6ff          	ld	a,#255
2204  0024               L001:
2206  0024 5b04          	addw	sp,#4
2207  0026 81            	ret
2286                     ; 190 void RFModulator_SendRegister(RFModulator* mod) {
2287                     .text:	section	.text,new
2288  0000               _RFModulator_SendRegister:
2290  0000 89            	pushw	x
2291  0001 5204          	subw	sp,#4
2292       00000004      OFST:	set	4
2295                     ; 191     uint8_t c0 = RFModulator_RegisterC0(mod->rf_pwc, mod->rf_osc, mod->rf_att, mod->rf_sfd, mod->rf_test);
2297  0003 e604          	ld	a,(4,x)
2298  0005 88            	push	a
2299  0006 e60b          	ld	a,(11,x)
2300  0008 88            	push	a
2301  0009 e60a          	ld	a,(10,x)
2302  000b 88            	push	a
2303  000c e609          	ld	a,(9,x)
2304  000e 97            	ld	xl,a
2305  000f 1608          	ldw	y,(OFST+4,sp)
2306  0011 90e608        	ld	a,(8,y)
2307  0014 95            	ld	xh,a
2308  0015 cd0000        	call	_RFModulator_RegisterC0
2310  0018 5b03          	addw	sp,#3
2311  001a 6b01          	ld	(OFST-3,sp),a
2313                     ; 192     uint8_t c1 = RFModulator_RegisterC1(mod->rf_so, mod->rf_lop, mod->rf_ps, mod->rf_test, mod->rf_divider);
2315  001c 1e05          	ldw	x,(OFST+1,sp)
2316  001e e603          	ld	a,(3,x)
2317  0020 88            	push	a
2318  0021 1e06          	ldw	x,(OFST+2,sp)
2319  0023 e604          	ld	a,(4,x)
2320  0025 88            	push	a
2321  0026 1e07          	ldw	x,(OFST+3,sp)
2322  0028 e607          	ld	a,(7,x)
2323  002a 88            	push	a
2324  002b 1e08          	ldw	x,(OFST+4,sp)
2325  002d e606          	ld	a,(6,x)
2326  002f 97            	ld	xl,a
2327  0030 1608          	ldw	y,(OFST+4,sp)
2328  0032 90e605        	ld	a,(5,y)
2329  0035 95            	ld	xh,a
2330  0036 cd0000        	call	_RFModulator_RegisterC1
2332  0039 5b03          	addw	sp,#3
2333  003b 6b02          	ld	(OFST-2,sp),a
2335                     ; 193     uint8_t fm = RFModulator_RegisterFM(mod->rf_tpen, mod->rf_value);
2337  003d 1e05          	ldw	x,(OFST+1,sp)
2338  003f ee01          	ldw	x,(1,x)
2339  0041 89            	pushw	x
2340  0042 1e07          	ldw	x,(OFST+3,sp)
2341  0044 e60c          	ld	a,(12,x)
2342  0046 cd0000        	call	_RFModulator_RegisterFM
2344  0049 85            	popw	x
2345  004a 6b03          	ld	(OFST-1,sp),a
2347                     ; 194     uint8_t fl = RFModulator_RegisterFL(mod->rf_value, mod->rf_divider);
2349  004c 1e05          	ldw	x,(OFST+1,sp)
2350  004e e603          	ld	a,(3,x)
2351  0050 88            	push	a
2352  0051 1e06          	ldw	x,(OFST+2,sp)
2353  0053 ee01          	ldw	x,(1,x)
2354  0055 cd0000        	call	_RFModulator_RegisterFL
2356  0058 5b01          	addw	sp,#1
2357  005a 6b04          	ld	(OFST+0,sp),a
2359                     ; 196     RFModulator_SendDataRaw(mod, c1, c0, fm, fl);
2361  005c 7b04          	ld	a,(OFST+0,sp)
2362  005e 88            	push	a
2363  005f 7b04          	ld	a,(OFST+0,sp)
2364  0061 88            	push	a
2365  0062 7b03          	ld	a,(OFST-1,sp)
2366  0064 88            	push	a
2367  0065 7b05          	ld	a,(OFST+1,sp)
2368  0067 88            	push	a
2369  0068 1e09          	ldw	x,(OFST+5,sp)
2370  006a cd0000        	call	_RFModulator_SendDataRaw
2372  006d 5b04          	addw	sp,#4
2373                     ; 197 }
2376  006f 5b06          	addw	sp,#6
2377  0071 81            	ret
2390                     	xdef	_bitWrite
2391                     	xdef	_RFModulator_SendRegister
2392                     	xdef	_RFModulator_RegisterFL
2393                     	xdef	_RFModulator_RegisterFM
2394                     	xdef	_RFModulator_RegisterC0
2395                     	xdef	_RFModulator_RegisterC1
2396                     	xdef	_RFModulator_SendDataRaw
2397                     	xdef	_RFModulator_GetStatus
2398                     	xdef	_RFModulator_SetTestMode
2399                     	xdef	_RFModulator_SetTestPattern
2400                     	xdef	_RFModulator_SetAttenuation
2401                     	xdef	_RFModulator_SetOscillator
2402                     	xdef	_RFModulator_SetPeakWhiteClip
2403                     	xdef	_RFModulator_SetLogicOutputPort
2404                     	xdef	_RFModulator_SetSoundOscillator
2405                     	xdef	_RFModulator_SetSoundSubcarrier
2406                     	xdef	_RFModulator_SetPictureSoundRatio
2407                     	xdef	_RFModulator_SetFrequency
2408                     	xdef	_RFModulator_Init
2409                     	xref	_swi2c_read_array
2410                     	xref	_swi2c_write_array
2411                     	xref.b	c_lreg
2412                     	xref.b	c_x
2431                     	xref	c_lgmul
2432                     	xref	c_itolx
2433                     	xref	c_rtol
2434                     	xref	c_ludv
2435                     	xref	c_lcmp
2436                     	xref	c_ltor
2437                     	end
