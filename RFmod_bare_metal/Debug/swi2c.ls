   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
 122                     ; 12 uint8_t swi2c_write_eemem(uint8_t slv_addr, uint16_t address, uint8_t* data, uint16_t num){
 124                     .text:	section	.text,new
 125  0000               _swi2c_write_eemem:
 127  0000 88            	push	a
 128  0001 5204          	subw	sp,#4
 129       00000004      OFST:	set	4
 132                     ; 19 if(swi2c_START()){return 0xaa;} 
 134  0003 cd0000        	call	_swi2c_START
 136  0006 4d            	tnz	a
 137  0007 2704          	jreq	L36
 140  0009 a6aa          	ld	a,#170
 142  000b 2010          	jra	L6
 143  000d               L36:
 144                     ; 22 mask=0b1<<7;
 146  000d a680          	ld	a,#128
 147  000f 6b04          	ld	(OFST+0,sp),a
 149  0011               L56:
 150                     ; 24 if(swi2c_writebit(slv_addr & mask)){return 0xff;}
 152  0011 7b05          	ld	a,(OFST+1,sp)
 153  0013 1404          	and	a,(OFST+0,sp)
 154  0015 cd0000        	call	_swi2c_writebit
 156  0018 4d            	tnz	a
 157  0019 2705          	jreq	L37
 160  001b a6ff          	ld	a,#255
 162  001d               L6:
 164  001d 5b05          	addw	sp,#5
 165  001f 81            	ret
 166  0020               L37:
 167                     ; 25 mask = mask >>1;
 169  0020 0404          	srl	(OFST+0,sp)
 171                     ; 23 while(mask){
 173  0022 0d04          	tnz	(OFST+0,sp)
 174  0024 26eb          	jrne	L56
 175                     ; 27 ack=swi2c_readbit();
 177  0026 cd0000        	call	_swi2c_readbit
 179  0029 6b04          	ld	(OFST+0,sp),a
 181                     ; 28 if(ack){
 183  002b 0d04          	tnz	(OFST+0,sp)
 184  002d 270e          	jreq	L57
 185                     ; 29 	if(swi2c_STOP()){return 0xff;}
 187  002f cd0000        	call	_swi2c_STOP
 189  0032 4d            	tnz	a
 190  0033 2704          	jreq	L77
 193  0035 a6ff          	ld	a,#255
 195  0037 20e4          	jra	L6
 196  0039               L77:
 197                     ; 30 	return ack;
 199  0039 7b04          	ld	a,(OFST+0,sp)
 201  003b 20e0          	jra	L6
 202  003d               L57:
 203                     ; 34 tmp = address >> 8;
 205  003d 7b08          	ld	a,(OFST+4,sp)
 206  003f 6b01          	ld	(OFST-3,sp),a
 208                     ; 35 mask=0b1<<7;
 210  0041 a680          	ld	a,#128
 211  0043 6b04          	ld	(OFST+0,sp),a
 213  0045               L101:
 214                     ; 37 if(swi2c_writebit(tmp & mask)){return 0xff;}
 216  0045 7b01          	ld	a,(OFST-3,sp)
 217  0047 1404          	and	a,(OFST+0,sp)
 218  0049 cd0000        	call	_swi2c_writebit
 220  004c 4d            	tnz	a
 221  004d 2704          	jreq	L701
 224  004f a6ff          	ld	a,#255
 226  0051 20ca          	jra	L6
 227  0053               L701:
 228                     ; 38 mask = mask >>1;
 230  0053 0404          	srl	(OFST+0,sp)
 232                     ; 36 while(mask){
 234  0055 0d04          	tnz	(OFST+0,sp)
 235  0057 26ec          	jrne	L101
 236                     ; 40 ack=swi2c_readbit();
 238  0059 cd0000        	call	_swi2c_readbit
 240  005c 6b04          	ld	(OFST+0,sp),a
 242                     ; 41 if(ack){
 244  005e 0d04          	tnz	(OFST+0,sp)
 245  0060 270e          	jreq	L111
 246                     ; 42 	if(swi2c_STOP()){return 0xff;}
 248  0062 cd0000        	call	_swi2c_STOP
 250  0065 4d            	tnz	a
 251  0066 2704          	jreq	L311
 254  0068 a6ff          	ld	a,#255
 256  006a 20b1          	jra	L6
 257  006c               L311:
 258                     ; 43 	return ack;
 260  006c 7b04          	ld	a,(OFST+0,sp)
 262  006e 20ad          	jra	L6
 263  0070               L111:
 264                     ; 47 tmp = (uint8_t)address;
 266  0070 7b09          	ld	a,(OFST+5,sp)
 267  0072 6b01          	ld	(OFST-3,sp),a
 269                     ; 48 mask=0b1<<7;
 271  0074 a680          	ld	a,#128
 272  0076 6b04          	ld	(OFST+0,sp),a
 274  0078               L511:
 275                     ; 50 if(swi2c_writebit(tmp & mask)){return 0xff;}
 277  0078 7b01          	ld	a,(OFST-3,sp)
 278  007a 1404          	and	a,(OFST+0,sp)
 279  007c cd0000        	call	_swi2c_writebit
 281  007f 4d            	tnz	a
 282  0080 2704          	jreq	L321
 285  0082 a6ff          	ld	a,#255
 287  0084 2097          	jra	L6
 288  0086               L321:
 289                     ; 51 mask = mask >>1;
 291  0086 0404          	srl	(OFST+0,sp)
 293                     ; 49 while(mask){
 295  0088 0d04          	tnz	(OFST+0,sp)
 296  008a 26ec          	jrne	L511
 297                     ; 53 ack=swi2c_readbit();
 299  008c cd0000        	call	_swi2c_readbit
 301  008f 6b04          	ld	(OFST+0,sp),a
 303                     ; 54 if(ack){
 305  0091 0d04          	tnz	(OFST+0,sp)
 306  0093 2712          	jreq	L521
 307                     ; 55 	if(swi2c_STOP()){return 0xff;}
 309  0095 cd0000        	call	_swi2c_STOP
 311  0098 4d            	tnz	a
 312  0099 2706          	jreq	L721
 315  009b a6ff          	ld	a,#255
 317  009d ac1d001d      	jpf	L6
 318  00a1               L721:
 319                     ; 56 	return ack;
 321  00a1 7b04          	ld	a,(OFST+0,sp)
 323  00a3 ac1d001d      	jpf	L6
 324  00a7               L521:
 325                     ; 61 for(i=0;i<num;i++){
 327  00a7 5f            	clrw	x
 328  00a8 1f02          	ldw	(OFST-2,sp),x
 331  00aa 2040          	jra	L531
 332  00ac               L131:
 333                     ; 62 	mask=0b1<<7;
 335  00ac a680          	ld	a,#128
 336  00ae 6b04          	ld	(OFST+0,sp),a
 338  00b0               L141:
 339                     ; 64 	if(swi2c_writebit(data[i] & mask)){return 0xff;}
 341  00b0 1e0a          	ldw	x,(OFST+6,sp)
 342  00b2 72fb02        	addw	x,(OFST-2,sp)
 343  00b5 f6            	ld	a,(x)
 344  00b6 1404          	and	a,(OFST+0,sp)
 345  00b8 cd0000        	call	_swi2c_writebit
 347  00bb 4d            	tnz	a
 348  00bc 2706          	jreq	L741
 351  00be a6ff          	ld	a,#255
 353  00c0 ac1d001d      	jpf	L6
 354  00c4               L741:
 355                     ; 65 	mask = mask >>1;
 357  00c4 0404          	srl	(OFST+0,sp)
 359                     ; 63 	while(mask){
 361  00c6 0d04          	tnz	(OFST+0,sp)
 362  00c8 26e6          	jrne	L141
 363                     ; 67 	ack=swi2c_readbit();
 365  00ca cd0000        	call	_swi2c_readbit
 367  00cd 6b04          	ld	(OFST+0,sp),a
 369                     ; 68 	if(ack){
 371  00cf 0d04          	tnz	(OFST+0,sp)
 372  00d1 2712          	jreq	L151
 373                     ; 69 		if(swi2c_STOP()){return 0xff;}
 375  00d3 cd0000        	call	_swi2c_STOP
 377  00d6 4d            	tnz	a
 378  00d7 2706          	jreq	L351
 381  00d9 a6ff          	ld	a,#255
 383  00db ac1d001d      	jpf	L6
 384  00df               L351:
 385                     ; 70 		return ack;
 387  00df 7b04          	ld	a,(OFST+0,sp)
 389  00e1 ac1d001d      	jpf	L6
 390  00e5               L151:
 391                     ; 61 for(i=0;i<num;i++){
 393  00e5 1e02          	ldw	x,(OFST-2,sp)
 394  00e7 1c0001        	addw	x,#1
 395  00ea 1f02          	ldw	(OFST-2,sp),x
 397  00ec               L531:
 400  00ec 1e02          	ldw	x,(OFST-2,sp)
 401  00ee 130c          	cpw	x,(OFST+8,sp)
 402  00f0 25ba          	jrult	L131
 403                     ; 75 if(swi2c_STOP()){return 0xff;}
 405  00f2 cd0000        	call	_swi2c_STOP
 407  00f5 4d            	tnz	a
 408  00f6 2706          	jreq	L551
 411  00f8 a6ff          	ld	a,#255
 413  00fa ac1d001d      	jpf	L6
 414  00fe               L551:
 415                     ; 76 return 0;
 417  00fe 4f            	clr	a
 419  00ff ac1d001d      	jpf	L6
 531                     ; 86 uint8_t swi2c_read_eemem(uint8_t slv_addr, uint16_t address, uint8_t* data, uint16_t num){
 532                     .text:	section	.text,new
 533  0000               _swi2c_read_eemem:
 535  0000 88            	push	a
 536  0001 5204          	subw	sp,#4
 537       00000004      OFST:	set	4
 540                     ; 87 uint16_t i=0;	
 542                     ; 93 if(swi2c_START()){return 0xaa;} 
 544  0003 cd0000        	call	_swi2c_START
 546  0006 4d            	tnz	a
 547  0007 2704          	jreq	L532
 550  0009 a6aa          	ld	a,#170
 552  000b 2010          	jra	L21
 553  000d               L532:
 554                     ; 96 mask=0b1<<7;
 556  000d a680          	ld	a,#128
 557  000f 6b04          	ld	(OFST+0,sp),a
 559  0011               L732:
 560                     ; 98 if(swi2c_writebit(slv_addr & mask)){return 0xff;}
 562  0011 7b05          	ld	a,(OFST+1,sp)
 563  0013 1404          	and	a,(OFST+0,sp)
 564  0015 cd0000        	call	_swi2c_writebit
 566  0018 4d            	tnz	a
 567  0019 2705          	jreq	L542
 570  001b a6ff          	ld	a,#255
 572  001d               L21:
 574  001d 5b05          	addw	sp,#5
 575  001f 81            	ret
 576  0020               L542:
 577                     ; 99 mask = mask >>1;
 579  0020 0404          	srl	(OFST+0,sp)
 581                     ; 97 while(mask){
 583  0022 0d04          	tnz	(OFST+0,sp)
 584  0024 26eb          	jrne	L732
 585                     ; 101 ack=swi2c_readbit();
 587  0026 cd0000        	call	_swi2c_readbit
 589  0029 6b03          	ld	(OFST-1,sp),a
 591                     ; 102 if(ack){
 593  002b 0d03          	tnz	(OFST-1,sp)
 594  002d 270e          	jreq	L742
 595                     ; 103 	if(swi2c_STOP()){return 0xff;}
 597  002f cd0000        	call	_swi2c_STOP
 599  0032 4d            	tnz	a
 600  0033 2704          	jreq	L152
 603  0035 a6ff          	ld	a,#255
 605  0037 20e4          	jra	L21
 606  0039               L152:
 607                     ; 104 	return ack;
 609  0039 7b03          	ld	a,(OFST-1,sp)
 611  003b 20e0          	jra	L21
 612  003d               L742:
 613                     ; 108 tmp = address >> 8;
 615  003d 7b08          	ld	a,(OFST+4,sp)
 616  003f 6b03          	ld	(OFST-1,sp),a
 618                     ; 109 mask=0b1<<7;
 620  0041 a680          	ld	a,#128
 621  0043 6b04          	ld	(OFST+0,sp),a
 623  0045               L352:
 624                     ; 111 if(swi2c_writebit(tmp & mask)){return 0xff;}
 626  0045 7b03          	ld	a,(OFST-1,sp)
 627  0047 1404          	and	a,(OFST+0,sp)
 628  0049 cd0000        	call	_swi2c_writebit
 630  004c 4d            	tnz	a
 631  004d 2704          	jreq	L162
 634  004f a6ff          	ld	a,#255
 636  0051 20ca          	jra	L21
 637  0053               L162:
 638                     ; 112 mask = mask >>1;
 640  0053 0404          	srl	(OFST+0,sp)
 642                     ; 110 while(mask){
 644  0055 0d04          	tnz	(OFST+0,sp)
 645  0057 26ec          	jrne	L352
 646                     ; 114 ack=swi2c_readbit();
 648  0059 cd0000        	call	_swi2c_readbit
 650  005c 6b03          	ld	(OFST-1,sp),a
 652                     ; 115 if(ack){
 654  005e 0d03          	tnz	(OFST-1,sp)
 655  0060 270e          	jreq	L362
 656                     ; 116 	if(swi2c_STOP()){return 0xff;}
 658  0062 cd0000        	call	_swi2c_STOP
 660  0065 4d            	tnz	a
 661  0066 2704          	jreq	L562
 664  0068 a6ff          	ld	a,#255
 666  006a 20b1          	jra	L21
 667  006c               L562:
 668                     ; 117 	return ack;
 670  006c 7b03          	ld	a,(OFST-1,sp)
 672  006e 20ad          	jra	L21
 673  0070               L362:
 674                     ; 121 tmp = (uint8_t)address;
 676  0070 7b09          	ld	a,(OFST+5,sp)
 677  0072 6b03          	ld	(OFST-1,sp),a
 679                     ; 122 mask=0b1<<7;
 681  0074 a680          	ld	a,#128
 682  0076 6b04          	ld	(OFST+0,sp),a
 684  0078               L762:
 685                     ; 124 if(swi2c_writebit(tmp & mask)){return 0xff;}
 687  0078 7b03          	ld	a,(OFST-1,sp)
 688  007a 1404          	and	a,(OFST+0,sp)
 689  007c cd0000        	call	_swi2c_writebit
 691  007f 4d            	tnz	a
 692  0080 2704          	jreq	L572
 695  0082 a6ff          	ld	a,#255
 697  0084 2097          	jra	L21
 698  0086               L572:
 699                     ; 125 mask = mask >>1;
 701  0086 0404          	srl	(OFST+0,sp)
 703                     ; 123 while(mask){
 705  0088 0d04          	tnz	(OFST+0,sp)
 706  008a 26ec          	jrne	L762
 707                     ; 127 ack=swi2c_readbit();
 709  008c cd0000        	call	_swi2c_readbit
 711  008f 6b03          	ld	(OFST-1,sp),a
 713                     ; 128 if(ack){
 715  0091 0d03          	tnz	(OFST-1,sp)
 716  0093 2712          	jreq	L772
 717                     ; 129 	if(swi2c_STOP()){return 0xff;}
 719  0095 cd0000        	call	_swi2c_STOP
 721  0098 4d            	tnz	a
 722  0099 2706          	jreq	L103
 725  009b a6ff          	ld	a,#255
 727  009d ac1d001d      	jpf	L21
 728  00a1               L103:
 729                     ; 130 	return ack;
 731  00a1 7b03          	ld	a,(OFST-1,sp)
 733  00a3 ac1d001d      	jpf	L21
 734  00a7               L772:
 735                     ; 134 if(swi2c_RESTART()){return 0xff;} 
 737  00a7 cd0000        	call	_swi2c_RESTART
 739  00aa 4d            	tnz	a
 740  00ab 2706          	jreq	L303
 743  00ad a6ff          	ld	a,#255
 745  00af ac1d001d      	jpf	L21
 746  00b3               L303:
 747                     ; 137 mask=0b1<<7;
 749  00b3 a680          	ld	a,#128
 750  00b5 6b04          	ld	(OFST+0,sp),a
 752  00b7               L503:
 753                     ; 139 if(swi2c_writebit((slv_addr | 0b1) & mask)){return 0xff;}
 755  00b7 7b05          	ld	a,(OFST+1,sp)
 756  00b9 aa01          	or	a,#1
 757  00bb 1404          	and	a,(OFST+0,sp)
 758  00bd cd0000        	call	_swi2c_writebit
 760  00c0 4d            	tnz	a
 761  00c1 2706          	jreq	L313
 764  00c3 a6ff          	ld	a,#255
 766  00c5 ac1d001d      	jpf	L21
 767  00c9               L313:
 768                     ; 140 mask = mask >>1;
 770  00c9 0404          	srl	(OFST+0,sp)
 772                     ; 138 while(mask){
 774  00cb 0d04          	tnz	(OFST+0,sp)
 775  00cd 26e8          	jrne	L503
 776                     ; 142 ack=swi2c_readbit();
 778  00cf cd0000        	call	_swi2c_readbit
 780  00d2 6b03          	ld	(OFST-1,sp),a
 782                     ; 143 if(ack){
 784  00d4 0d03          	tnz	(OFST-1,sp)
 785  00d6 2712          	jreq	L513
 786                     ; 144 	if(swi2c_STOP()){return 0xff;}
 788  00d8 cd0000        	call	_swi2c_STOP
 790  00db 4d            	tnz	a
 791  00dc 2706          	jreq	L713
 794  00de a6ff          	ld	a,#255
 796  00e0 ac1d001d      	jpf	L21
 797  00e4               L713:
 798                     ; 145 	return ack;
 800  00e4 7b03          	ld	a,(OFST-1,sp)
 802  00e6 ac1d001d      	jpf	L21
 803  00ea               L513:
 804                     ; 150 for(i=0;i<num;i++){
 806  00ea 5f            	clrw	x
 807  00eb 1f01          	ldw	(OFST-3,sp),x
 810  00ed 2060          	jra	L523
 811  00ef               L123:
 812                     ; 151 	mask=0b1<<7;
 814  00ef a680          	ld	a,#128
 815  00f1 6b04          	ld	(OFST+0,sp),a
 817  00f3               L133:
 818                     ; 153 	bit = swi2c_readbit();
 820  00f3 cd0000        	call	_swi2c_readbit
 822  00f6 6b03          	ld	(OFST-1,sp),a
 824                     ; 154 	if(bit==0){data[i] &=~mask;}
 826  00f8 0d03          	tnz	(OFST-1,sp)
 827  00fa 260c          	jrne	L733
 830  00fc 1e0a          	ldw	x,(OFST+6,sp)
 831  00fe 72fb01        	addw	x,(OFST-3,sp)
 832  0101 7b04          	ld	a,(OFST+0,sp)
 833  0103 43            	cpl	a
 834  0104 f4            	and	a,(x)
 835  0105 f7            	ld	(x),a
 837  0106 200f          	jra	L143
 838  0108               L733:
 839                     ; 155 	else if(bit==1){data[i] |=mask;}
 841  0108 7b03          	ld	a,(OFST-1,sp)
 842  010a a101          	cp	a,#1
 843  010c 2624          	jrne	L343
 846  010e 1e0a          	ldw	x,(OFST+6,sp)
 847  0110 72fb01        	addw	x,(OFST-3,sp)
 848  0113 f6            	ld	a,(x)
 849  0114 1a04          	or	a,(OFST+0,sp)
 850  0116 f7            	ld	(x),a
 852  0117               L143:
 853                     ; 157 	mask = mask >>1;
 855  0117 0404          	srl	(OFST+0,sp)
 857                     ; 152 	while(mask){
 859  0119 0d04          	tnz	(OFST+0,sp)
 860  011b 26d6          	jrne	L133
 861                     ; 159 	if((i+1)==num){
 863  011d 1e01          	ldw	x,(OFST-3,sp)
 864  011f 5c            	incw	x
 865  0120 130c          	cpw	x,(OFST+8,sp)
 866  0122 2617          	jrne	L743
 867                     ; 160 		if(swi2c_writebit(1)){return 0xff;} // NACK
 869  0124 a601          	ld	a,#1
 870  0126 cd0000        	call	_swi2c_writebit
 872  0129 4d            	tnz	a
 873  012a 271c          	jreq	L353
 876  012c a6ff          	ld	a,#255
 878  012e ac1d001d      	jpf	L21
 879  0132               L343:
 880                     ; 156 	else{swi2c_STOP();return 0xff;}
 882  0132 cd0000        	call	_swi2c_STOP
 886  0135 a6ff          	ld	a,#255
 888  0137 ac1d001d      	jpf	L21
 889  013b               L743:
 890                     ; 162 		if(swi2c_writebit(0)){return 0xff;} // ACK
 892  013b 4f            	clr	a
 893  013c cd0000        	call	_swi2c_writebit
 895  013f 4d            	tnz	a
 896  0140 2706          	jreq	L353
 899  0142 a6ff          	ld	a,#255
 901  0144 ac1d001d      	jpf	L21
 902  0148               L353:
 903                     ; 150 for(i=0;i<num;i++){
 905  0148 1e01          	ldw	x,(OFST-3,sp)
 906  014a 1c0001        	addw	x,#1
 907  014d 1f01          	ldw	(OFST-3,sp),x
 909  014f               L523:
 912  014f 1e01          	ldw	x,(OFST-3,sp)
 913  0151 130c          	cpw	x,(OFST+8,sp)
 914  0153 259a          	jrult	L123
 915                     ; 167 if(swi2c_STOP()){return 0xff;}
 917  0155 cd0000        	call	_swi2c_STOP
 919  0158 4d            	tnz	a
 920  0159 2706          	jreq	L753
 923  015b a6ff          	ld	a,#255
 925  015d ac1d001d      	jpf	L21
 926  0161               L753:
 927                     ; 168 return 0;
 929  0161 4f            	clr	a
 931  0162 ac1d001d      	jpf	L21
1034                     ; 178 uint8_t swi2c_read_buf(uint8_t slv_addr, uint8_t address, uint8_t* data, uint16_t num){
1035                     .text:	section	.text,new
1036  0000               _swi2c_read_buf:
1038  0000 89            	pushw	x
1039  0001 5204          	subw	sp,#4
1040       00000004      OFST:	set	4
1043                     ; 179 uint16_t i=0;	
1045                     ; 184 if(swi2c_START()){return 0xaa;} 
1047  0003 cd0000        	call	_swi2c_START
1049  0006 4d            	tnz	a
1050  0007 2704          	jreq	L334
1053  0009 a6aa          	ld	a,#170
1055  000b 2010          	jra	L61
1056  000d               L334:
1057                     ; 187 mask=0b1<<7;
1059  000d a680          	ld	a,#128
1060  000f 6b04          	ld	(OFST+0,sp),a
1062  0011               L534:
1063                     ; 189 if(swi2c_writebit(slv_addr & mask)){return 0xff;}
1065  0011 7b05          	ld	a,(OFST+1,sp)
1066  0013 1404          	and	a,(OFST+0,sp)
1067  0015 cd0000        	call	_swi2c_writebit
1069  0018 4d            	tnz	a
1070  0019 2705          	jreq	L344
1073  001b a6ff          	ld	a,#255
1075  001d               L61:
1077  001d 5b06          	addw	sp,#6
1078  001f 81            	ret
1079  0020               L344:
1080                     ; 190 mask = mask >>1;
1082  0020 0404          	srl	(OFST+0,sp)
1084                     ; 188 while(mask){
1086  0022 0d04          	tnz	(OFST+0,sp)
1087  0024 26eb          	jrne	L534
1088                     ; 192 ack=swi2c_readbit();
1090  0026 cd0000        	call	_swi2c_readbit
1092  0029 6b03          	ld	(OFST-1,sp),a
1094                     ; 193 if(ack){
1096  002b 0d03          	tnz	(OFST-1,sp)
1097  002d 270e          	jreq	L544
1098                     ; 194 	if(swi2c_STOP()){return 0xff;}
1100  002f cd0000        	call	_swi2c_STOP
1102  0032 4d            	tnz	a
1103  0033 2704          	jreq	L744
1106  0035 a6ff          	ld	a,#255
1108  0037 20e4          	jra	L61
1109  0039               L744:
1110                     ; 195 	return ack;
1112  0039 7b03          	ld	a,(OFST-1,sp)
1114  003b 20e0          	jra	L61
1115  003d               L544:
1116                     ; 199 mask=0b1<<7;
1118  003d a680          	ld	a,#128
1119  003f 6b04          	ld	(OFST+0,sp),a
1121  0041               L154:
1122                     ; 201 if(swi2c_writebit(address & mask)){return 0xff;}
1124  0041 7b06          	ld	a,(OFST+2,sp)
1125  0043 1404          	and	a,(OFST+0,sp)
1126  0045 cd0000        	call	_swi2c_writebit
1128  0048 4d            	tnz	a
1129  0049 2704          	jreq	L754
1132  004b a6ff          	ld	a,#255
1134  004d 20ce          	jra	L61
1135  004f               L754:
1136                     ; 202 mask = mask >>1;
1138  004f 0404          	srl	(OFST+0,sp)
1140                     ; 200 while(mask){
1142  0051 0d04          	tnz	(OFST+0,sp)
1143  0053 26ec          	jrne	L154
1144                     ; 204 ack=swi2c_readbit();
1146  0055 cd0000        	call	_swi2c_readbit
1148  0058 6b03          	ld	(OFST-1,sp),a
1150                     ; 205 if(ack){
1152  005a 0d03          	tnz	(OFST-1,sp)
1153  005c 270e          	jreq	L164
1154                     ; 206 	if(swi2c_STOP()){return 0xff;}
1156  005e cd0000        	call	_swi2c_STOP
1158  0061 4d            	tnz	a
1159  0062 2704          	jreq	L364
1162  0064 a6ff          	ld	a,#255
1164  0066 20b5          	jra	L61
1165  0068               L364:
1166                     ; 207 	return ack;
1168  0068 7b03          	ld	a,(OFST-1,sp)
1170  006a 20b1          	jra	L61
1171  006c               L164:
1172                     ; 211 if(swi2c_RESTART()){return 0xff;} 
1174  006c cd0000        	call	_swi2c_RESTART
1176  006f 4d            	tnz	a
1177  0070 2704          	jreq	L564
1180  0072 a6ff          	ld	a,#255
1182  0074 20a7          	jra	L61
1183  0076               L564:
1184                     ; 214 mask=0b1<<7;
1186  0076 a680          	ld	a,#128
1187  0078 6b04          	ld	(OFST+0,sp),a
1189  007a               L764:
1190                     ; 216 if(swi2c_writebit((slv_addr | 0b1) & mask)){return 0xff;}
1192  007a 7b05          	ld	a,(OFST+1,sp)
1193  007c aa01          	or	a,#1
1194  007e 1404          	and	a,(OFST+0,sp)
1195  0080 cd0000        	call	_swi2c_writebit
1197  0083 4d            	tnz	a
1198  0084 2704          	jreq	L574
1201  0086 a6ff          	ld	a,#255
1203  0088 2093          	jra	L61
1204  008a               L574:
1205                     ; 217 mask = mask >>1;
1207  008a 0404          	srl	(OFST+0,sp)
1209                     ; 215 while(mask){
1211  008c 0d04          	tnz	(OFST+0,sp)
1212  008e 26ea          	jrne	L764
1213                     ; 219 ack=swi2c_readbit();
1215  0090 cd0000        	call	_swi2c_readbit
1217  0093 6b03          	ld	(OFST-1,sp),a
1219                     ; 220 if(ack){
1221  0095 0d03          	tnz	(OFST-1,sp)
1222  0097 2712          	jreq	L774
1223                     ; 221 	if(swi2c_STOP()){return 0xff;}
1225  0099 cd0000        	call	_swi2c_STOP
1227  009c 4d            	tnz	a
1228  009d 2706          	jreq	L105
1231  009f a6ff          	ld	a,#255
1233  00a1 ac1d001d      	jpf	L61
1234  00a5               L105:
1235                     ; 222 	return ack;
1237  00a5 7b03          	ld	a,(OFST-1,sp)
1239  00a7 ac1d001d      	jpf	L61
1240  00ab               L774:
1241                     ; 227 for(i=0;i<num;i++){
1243  00ab 5f            	clrw	x
1244  00ac 1f01          	ldw	(OFST-3,sp),x
1247  00ae 2060          	jra	L705
1248  00b0               L305:
1249                     ; 228 	mask=0b1<<7;
1251  00b0 a680          	ld	a,#128
1252  00b2 6b04          	ld	(OFST+0,sp),a
1254  00b4               L315:
1255                     ; 230 	bit = swi2c_readbit();
1257  00b4 cd0000        	call	_swi2c_readbit
1259  00b7 6b03          	ld	(OFST-1,sp),a
1261                     ; 231 	if(bit==0){data[i] &=~mask;}
1263  00b9 0d03          	tnz	(OFST-1,sp)
1264  00bb 260c          	jrne	L125
1267  00bd 1e09          	ldw	x,(OFST+5,sp)
1268  00bf 72fb01        	addw	x,(OFST-3,sp)
1269  00c2 7b04          	ld	a,(OFST+0,sp)
1270  00c4 43            	cpl	a
1271  00c5 f4            	and	a,(x)
1272  00c6 f7            	ld	(x),a
1274  00c7 200f          	jra	L325
1275  00c9               L125:
1276                     ; 232 	else if(bit==1){data[i] |=mask;}
1278  00c9 7b03          	ld	a,(OFST-1,sp)
1279  00cb a101          	cp	a,#1
1280  00cd 2624          	jrne	L525
1283  00cf 1e09          	ldw	x,(OFST+5,sp)
1284  00d1 72fb01        	addw	x,(OFST-3,sp)
1285  00d4 f6            	ld	a,(x)
1286  00d5 1a04          	or	a,(OFST+0,sp)
1287  00d7 f7            	ld	(x),a
1289  00d8               L325:
1290                     ; 234 	mask = mask >>1;
1292  00d8 0404          	srl	(OFST+0,sp)
1294                     ; 229 	while(mask){
1296  00da 0d04          	tnz	(OFST+0,sp)
1297  00dc 26d6          	jrne	L315
1298                     ; 236 	if((i+1)==num){
1300  00de 1e01          	ldw	x,(OFST-3,sp)
1301  00e0 5c            	incw	x
1302  00e1 130b          	cpw	x,(OFST+7,sp)
1303  00e3 2617          	jrne	L135
1304                     ; 237 		if(swi2c_writebit(1)){return 0xff;} // NACK
1306  00e5 a601          	ld	a,#1
1307  00e7 cd0000        	call	_swi2c_writebit
1309  00ea 4d            	tnz	a
1310  00eb 271c          	jreq	L535
1313  00ed a6ff          	ld	a,#255
1315  00ef ac1d001d      	jpf	L61
1316  00f3               L525:
1317                     ; 233 	else{swi2c_STOP();return 0xff;}
1319  00f3 cd0000        	call	_swi2c_STOP
1323  00f6 a6ff          	ld	a,#255
1325  00f8 ac1d001d      	jpf	L61
1326  00fc               L135:
1327                     ; 239 		if(swi2c_writebit(0)){return 0xff;} // ACK
1329  00fc 4f            	clr	a
1330  00fd cd0000        	call	_swi2c_writebit
1332  0100 4d            	tnz	a
1333  0101 2706          	jreq	L535
1336  0103 a6ff          	ld	a,#255
1338  0105 ac1d001d      	jpf	L61
1339  0109               L535:
1340                     ; 227 for(i=0;i<num;i++){
1342  0109 1e01          	ldw	x,(OFST-3,sp)
1343  010b 1c0001        	addw	x,#1
1344  010e 1f01          	ldw	(OFST-3,sp),x
1346  0110               L705:
1349  0110 1e01          	ldw	x,(OFST-3,sp)
1350  0112 130b          	cpw	x,(OFST+7,sp)
1351  0114 259a          	jrult	L305
1352                     ; 244 if(swi2c_STOP()){return 0xff;}
1354  0116 cd0000        	call	_swi2c_STOP
1356  0119 4d            	tnz	a
1357  011a 2706          	jreq	L145
1360  011c a6ff          	ld	a,#255
1362  011e ac1d001d      	jpf	L61
1363  0122               L145:
1364                     ; 245 return 0;
1366  0122 4f            	clr	a
1368  0123 ac1d001d      	jpf	L61
1461                     ; 256 uint8_t swi2c_write_buf(uint8_t slv_addr, uint8_t address, uint8_t* data, uint16_t num){
1462                     .text:	section	.text,new
1463  0000               _swi2c_write_buf:
1465  0000 89            	pushw	x
1466  0001 5203          	subw	sp,#3
1467       00000003      OFST:	set	3
1470                     ; 262 if(swi2c_START()){return 0xaa;} 
1472  0003 cd0000        	call	_swi2c_START
1474  0006 4d            	tnz	a
1475  0007 2704          	jreq	L116
1478  0009 a6aa          	ld	a,#170
1480  000b 2010          	jra	L22
1481  000d               L116:
1482                     ; 265 mask=0b1<<7;
1484  000d a680          	ld	a,#128
1485  000f 6b03          	ld	(OFST+0,sp),a
1487  0011               L316:
1488                     ; 267 if(swi2c_writebit(slv_addr & mask)){return 0xff;}
1490  0011 7b04          	ld	a,(OFST+1,sp)
1491  0013 1403          	and	a,(OFST+0,sp)
1492  0015 cd0000        	call	_swi2c_writebit
1494  0018 4d            	tnz	a
1495  0019 2705          	jreq	L126
1498  001b a6ff          	ld	a,#255
1500  001d               L22:
1502  001d 5b05          	addw	sp,#5
1503  001f 81            	ret
1504  0020               L126:
1505                     ; 268 mask = mask >>1;
1507  0020 0403          	srl	(OFST+0,sp)
1509                     ; 266 while(mask){
1511  0022 0d03          	tnz	(OFST+0,sp)
1512  0024 26eb          	jrne	L316
1513                     ; 270 ack=swi2c_readbit();
1515  0026 cd0000        	call	_swi2c_readbit
1517  0029 6b03          	ld	(OFST+0,sp),a
1519                     ; 271 if(ack){
1521  002b 0d03          	tnz	(OFST+0,sp)
1522  002d 270e          	jreq	L326
1523                     ; 272 	if(swi2c_STOP()){return 0xff;}
1525  002f cd0000        	call	_swi2c_STOP
1527  0032 4d            	tnz	a
1528  0033 2704          	jreq	L526
1531  0035 a6ff          	ld	a,#255
1533  0037 20e4          	jra	L22
1534  0039               L526:
1535                     ; 273 	return ack;
1537  0039 7b03          	ld	a,(OFST+0,sp)
1539  003b 20e0          	jra	L22
1540  003d               L326:
1541                     ; 277 mask=0b1<<7;
1543  003d a680          	ld	a,#128
1544  003f 6b03          	ld	(OFST+0,sp),a
1546  0041               L726:
1547                     ; 279 if(swi2c_writebit(address & mask)){return 0xff;}
1549  0041 7b05          	ld	a,(OFST+2,sp)
1550  0043 1403          	and	a,(OFST+0,sp)
1551  0045 cd0000        	call	_swi2c_writebit
1553  0048 4d            	tnz	a
1554  0049 2704          	jreq	L536
1557  004b a6ff          	ld	a,#255
1559  004d 20ce          	jra	L22
1560  004f               L536:
1561                     ; 280 mask = mask >>1;
1563  004f 0403          	srl	(OFST+0,sp)
1565                     ; 278 while(mask){
1567  0051 0d03          	tnz	(OFST+0,sp)
1568  0053 26ec          	jrne	L726
1569                     ; 282 ack=swi2c_readbit();
1571  0055 cd0000        	call	_swi2c_readbit
1573  0058 6b03          	ld	(OFST+0,sp),a
1575                     ; 283 if(ack){
1577  005a 0d03          	tnz	(OFST+0,sp)
1578  005c 270e          	jreq	L736
1579                     ; 284 	if(swi2c_STOP()){return 0xff;}
1581  005e cd0000        	call	_swi2c_STOP
1583  0061 4d            	tnz	a
1584  0062 2704          	jreq	L146
1587  0064 a6ff          	ld	a,#255
1589  0066 20b5          	jra	L22
1590  0068               L146:
1591                     ; 285 	return ack;
1593  0068 7b03          	ld	a,(OFST+0,sp)
1595  006a 20b1          	jra	L22
1596  006c               L736:
1597                     ; 289 for(i=0;i<num;i++){
1599  006c 5f            	clrw	x
1600  006d 1f01          	ldw	(OFST-2,sp),x
1603  006f 203e          	jra	L746
1604  0071               L346:
1605                     ; 290 	mask=0b1<<7;
1607  0071 a680          	ld	a,#128
1608  0073 6b03          	ld	(OFST+0,sp),a
1610  0075               L356:
1611                     ; 292 	if(swi2c_writebit(data[i] & mask)){return 0xff;}
1613  0075 1e08          	ldw	x,(OFST+5,sp)
1614  0077 72fb01        	addw	x,(OFST-2,sp)
1615  007a f6            	ld	a,(x)
1616  007b 1403          	and	a,(OFST+0,sp)
1617  007d cd0000        	call	_swi2c_writebit
1619  0080 4d            	tnz	a
1620  0081 2704          	jreq	L166
1623  0083 a6ff          	ld	a,#255
1625  0085 2096          	jra	L22
1626  0087               L166:
1627                     ; 293 	mask = mask >>1;
1629  0087 0403          	srl	(OFST+0,sp)
1631                     ; 291 	while(mask){
1633  0089 0d03          	tnz	(OFST+0,sp)
1634  008b 26e8          	jrne	L356
1635                     ; 295 	ack=swi2c_readbit();
1637  008d cd0000        	call	_swi2c_readbit
1639  0090 6b03          	ld	(OFST+0,sp),a
1641                     ; 296 	if(ack){
1643  0092 0d03          	tnz	(OFST+0,sp)
1644  0094 2712          	jreq	L366
1645                     ; 297 		if(swi2c_STOP()){return 0xff;}
1647  0096 cd0000        	call	_swi2c_STOP
1649  0099 4d            	tnz	a
1650  009a 2706          	jreq	L566
1653  009c a6ff          	ld	a,#255
1655  009e ac1d001d      	jpf	L22
1656  00a2               L566:
1657                     ; 298 		return ack;
1659  00a2 7b03          	ld	a,(OFST+0,sp)
1661  00a4 ac1d001d      	jpf	L22
1662  00a8               L366:
1663                     ; 289 for(i=0;i<num;i++){
1665  00a8 1e01          	ldw	x,(OFST-2,sp)
1666  00aa 1c0001        	addw	x,#1
1667  00ad 1f01          	ldw	(OFST-2,sp),x
1669  00af               L746:
1672  00af 1e01          	ldw	x,(OFST-2,sp)
1673  00b1 130a          	cpw	x,(OFST+7,sp)
1674  00b3 25bc          	jrult	L346
1675                     ; 303 if(swi2c_STOP()){return 0xff;}
1677  00b5 cd0000        	call	_swi2c_STOP
1679  00b8 4d            	tnz	a
1680  00b9 2706          	jreq	L766
1683  00bb a6ff          	ld	a,#255
1685  00bd ac1d001d      	jpf	L22
1686  00c1               L766:
1687                     ; 304 return 0;
1689  00c1 4f            	clr	a
1691  00c2 ac1d001d      	jpf	L22
1775                     ; 314 uint8_t swi2c_write_array(uint8_t slv_addr, uint8_t* data, uint16_t num){
1776                     .text:	section	.text,new
1777  0000               _swi2c_write_array:
1779  0000 88            	push	a
1780  0001 5203          	subw	sp,#3
1781       00000003      OFST:	set	3
1784                     ; 320 if(swi2c_START()){return 0xaa;} 
1786  0003 cd0000        	call	_swi2c_START
1788  0006 4d            	tnz	a
1789  0007 2704          	jreq	L337
1792  0009 a6aa          	ld	a,#170
1794  000b 2010          	jra	L62
1795  000d               L337:
1796                     ; 323 mask=0b1<<7;
1798  000d a680          	ld	a,#128
1799  000f 6b03          	ld	(OFST+0,sp),a
1801  0011               L537:
1802                     ; 325 if(swi2c_writebit(slv_addr & mask)){return 0xff;}
1804  0011 7b04          	ld	a,(OFST+1,sp)
1805  0013 1403          	and	a,(OFST+0,sp)
1806  0015 cd0000        	call	_swi2c_writebit
1808  0018 4d            	tnz	a
1809  0019 2705          	jreq	L347
1812  001b a6ff          	ld	a,#255
1814  001d               L62:
1816  001d 5b04          	addw	sp,#4
1817  001f 81            	ret
1818  0020               L347:
1819                     ; 326 mask = mask >>1;
1821  0020 0403          	srl	(OFST+0,sp)
1823                     ; 324 while(mask){
1825  0022 0d03          	tnz	(OFST+0,sp)
1826  0024 26eb          	jrne	L537
1827                     ; 328 ack=swi2c_readbit();
1829  0026 cd0000        	call	_swi2c_readbit
1831  0029 6b03          	ld	(OFST+0,sp),a
1833                     ; 329 if(ack){
1835  002b 0d03          	tnz	(OFST+0,sp)
1836  002d 270e          	jreq	L547
1837                     ; 330 	if(swi2c_STOP()){return 0xff;}
1839  002f cd0000        	call	_swi2c_STOP
1841  0032 4d            	tnz	a
1842  0033 2704          	jreq	L747
1845  0035 a6ff          	ld	a,#255
1847  0037 20e4          	jra	L62
1848  0039               L747:
1849                     ; 331 	return ack;
1851  0039 7b03          	ld	a,(OFST+0,sp)
1853  003b 20e0          	jra	L62
1854  003d               L547:
1855                     ; 335 for(i=0;i<num;i++){
1857  003d 5f            	clrw	x
1858  003e 1f01          	ldw	(OFST-2,sp),x
1861  0040 203a          	jra	L557
1862  0042               L157:
1863                     ; 336 	mask=0b1<<7;
1865  0042 a680          	ld	a,#128
1866  0044 6b03          	ld	(OFST+0,sp),a
1868  0046               L167:
1869                     ; 338 	if(swi2c_writebit(data[i] & mask)){return 0xff;}
1871  0046 1e07          	ldw	x,(OFST+4,sp)
1872  0048 72fb01        	addw	x,(OFST-2,sp)
1873  004b f6            	ld	a,(x)
1874  004c 1403          	and	a,(OFST+0,sp)
1875  004e cd0000        	call	_swi2c_writebit
1877  0051 4d            	tnz	a
1878  0052 2704          	jreq	L767
1881  0054 a6ff          	ld	a,#255
1883  0056 20c5          	jra	L62
1884  0058               L767:
1885                     ; 339 	mask = mask >>1;
1887  0058 0403          	srl	(OFST+0,sp)
1889                     ; 337 	while(mask){
1891  005a 0d03          	tnz	(OFST+0,sp)
1892  005c 26e8          	jrne	L167
1893                     ; 341 	ack=swi2c_readbit();
1895  005e cd0000        	call	_swi2c_readbit
1897  0061 6b03          	ld	(OFST+0,sp),a
1899                     ; 342 	if(ack){
1901  0063 0d03          	tnz	(OFST+0,sp)
1902  0065 270e          	jreq	L177
1903                     ; 343 		if(swi2c_STOP()){return 0xff;}
1905  0067 cd0000        	call	_swi2c_STOP
1907  006a 4d            	tnz	a
1908  006b 2704          	jreq	L377
1911  006d a6ff          	ld	a,#255
1913  006f 20ac          	jra	L62
1914  0071               L377:
1915                     ; 344 		return ack;
1917  0071 7b03          	ld	a,(OFST+0,sp)
1919  0073 20a8          	jra	L62
1920  0075               L177:
1921                     ; 335 for(i=0;i<num;i++){
1923  0075 1e01          	ldw	x,(OFST-2,sp)
1924  0077 1c0001        	addw	x,#1
1925  007a 1f01          	ldw	(OFST-2,sp),x
1927  007c               L557:
1930  007c 1e01          	ldw	x,(OFST-2,sp)
1931  007e 1309          	cpw	x,(OFST+6,sp)
1932  0080 25c0          	jrult	L157
1933                     ; 349 if(swi2c_STOP()){return 0xff;}
1935  0082 cd0000        	call	_swi2c_STOP
1937  0085 4d            	tnz	a
1938  0086 2704          	jreq	L577
1941  0088 a6ff          	ld	a,#255
1943  008a 2091          	jra	L62
1944  008c               L577:
1945                     ; 350 return 0;
1947  008c 4f            	clr	a
1949  008d 208e          	jra	L62
2042                     ; 355 uint8_t swi2c_read_array(uint8_t slv_addr, uint8_t* data, uint16_t num)
2042                     ; 356 {
2043                     .text:	section	.text,new
2044  0000               _swi2c_read_array:
2046  0000 88            	push	a
2047  0001 5204          	subw	sp,#4
2048       00000004      OFST:	set	4
2051                     ; 357     uint16_t i = 0;
2053                     ; 362     if (swi2c_START()) { return 0xaa; }
2055  0003 cd0000        	call	_swi2c_START
2057  0006 4d            	tnz	a
2058  0007 2704          	jreq	L5401
2061  0009 a6aa          	ld	a,#170
2063  000b 2012          	jra	L23
2064  000d               L5401:
2065                     ; 365     mask = 0b1 << 7;
2067  000d a680          	ld	a,#128
2068  000f 6b04          	ld	(OFST+0,sp),a
2070  0011               L7401:
2071                     ; 367         if (swi2c_writebit((slv_addr | 0b1) & mask)) { return 0xff; }
2073  0011 7b05          	ld	a,(OFST+1,sp)
2074  0013 aa01          	or	a,#1
2075  0015 1404          	and	a,(OFST+0,sp)
2076  0017 cd0000        	call	_swi2c_writebit
2078  001a 4d            	tnz	a
2079  001b 2705          	jreq	L5501
2082  001d a6ff          	ld	a,#255
2084  001f               L23:
2086  001f 5b05          	addw	sp,#5
2087  0021 81            	ret
2088  0022               L5501:
2089                     ; 368         mask = mask >> 1;
2091  0022 0404          	srl	(OFST+0,sp)
2093                     ; 366     while (mask) {
2095  0024 0d04          	tnz	(OFST+0,sp)
2096  0026 26e9          	jrne	L7401
2097                     ; 370     ack = swi2c_readbit();
2099  0028 cd0000        	call	_swi2c_readbit
2101  002b 6b01          	ld	(OFST-3,sp),a
2103                     ; 371     if (ack) {
2105  002d 0d01          	tnz	(OFST-3,sp)
2106  002f 270e          	jreq	L7501
2107                     ; 372         if (swi2c_STOP()) { return 0xff; }
2109  0031 cd0000        	call	_swi2c_STOP
2111  0034 4d            	tnz	a
2112  0035 2704          	jreq	L1601
2115  0037 a6ff          	ld	a,#255
2117  0039 20e4          	jra	L23
2118  003b               L1601:
2119                     ; 373         return ack;
2121  003b 7b01          	ld	a,(OFST-3,sp)
2123  003d 20e0          	jra	L23
2124  003f               L7501:
2125                     ; 377     for (i = 0; i < num; i++) {
2127  003f 5f            	clrw	x
2128  0040 1f02          	ldw	(OFST-2,sp),x
2131  0042 205a          	jra	L7601
2132  0044               L3601:
2133                     ; 378         mask = 0b1 << 7;
2135  0044 a680          	ld	a,#128
2136  0046 6b04          	ld	(OFST+0,sp),a
2138  0048               L3701:
2139                     ; 380             bit = swi2c_readbit();
2141  0048 cd0000        	call	_swi2c_readbit
2143  004b 6b01          	ld	(OFST-3,sp),a
2145                     ; 381             if (bit == 0) { data[i] &= ~mask; }
2147  004d 0d01          	tnz	(OFST-3,sp)
2148  004f 260c          	jrne	L1011
2151  0051 1e08          	ldw	x,(OFST+4,sp)
2152  0053 72fb02        	addw	x,(OFST-2,sp)
2153  0056 7b04          	ld	a,(OFST+0,sp)
2154  0058 43            	cpl	a
2155  0059 f4            	and	a,(x)
2156  005a f7            	ld	(x),a
2158  005b 200f          	jra	L3011
2159  005d               L1011:
2160                     ; 382             else if (bit == 1) { data[i] |= mask; }
2162  005d 7b01          	ld	a,(OFST-3,sp)
2163  005f a101          	cp	a,#1
2164  0061 2622          	jrne	L5011
2167  0063 1e08          	ldw	x,(OFST+4,sp)
2168  0065 72fb02        	addw	x,(OFST-2,sp)
2169  0068 f6            	ld	a,(x)
2170  0069 1a04          	or	a,(OFST+0,sp)
2171  006b f7            	ld	(x),a
2173  006c               L3011:
2174                     ; 384             mask = mask >> 1;
2176  006c 0404          	srl	(OFST+0,sp)
2178                     ; 379         while (mask) {
2180  006e 0d04          	tnz	(OFST+0,sp)
2181  0070 26d6          	jrne	L3701
2182                     ; 388         if ((i + 1) == num) {
2184  0072 1e02          	ldw	x,(OFST-2,sp)
2185  0074 5c            	incw	x
2186  0075 130a          	cpw	x,(OFST+6,sp)
2187  0077 2613          	jrne	L1111
2188                     ; 389             if (swi2c_writebit(1)) { return 0xff; } // NACK
2190  0079 a601          	ld	a,#1
2191  007b cd0000        	call	_swi2c_writebit
2193  007e 4d            	tnz	a
2194  007f 2716          	jreq	L5111
2197  0081 a6ff          	ld	a,#255
2199  0083 209a          	jra	L23
2200  0085               L5011:
2201                     ; 383             else { swi2c_STOP(); return 0xff; }
2203  0085 cd0000        	call	_swi2c_STOP
2207  0088 a6ff          	ld	a,#255
2209  008a 2093          	jra	L23
2210  008c               L1111:
2211                     ; 391             if (swi2c_writebit(0)) { return 0xff; } // ACK
2213  008c 4f            	clr	a
2214  008d cd0000        	call	_swi2c_writebit
2216  0090 4d            	tnz	a
2217  0091 2704          	jreq	L5111
2220  0093 a6ff          	ld	a,#255
2222  0095 2088          	jra	L23
2223  0097               L5111:
2224                     ; 377     for (i = 0; i < num; i++) {
2226  0097 1e02          	ldw	x,(OFST-2,sp)
2227  0099 1c0001        	addw	x,#1
2228  009c 1f02          	ldw	(OFST-2,sp),x
2230  009e               L7601:
2233  009e 1e02          	ldw	x,(OFST-2,sp)
2234  00a0 130a          	cpw	x,(OFST+6,sp)
2235  00a2 25a0          	jrult	L3601
2236                     ; 396     if (swi2c_STOP()) { return 0xff; }
2238  00a4 cd0000        	call	_swi2c_STOP
2240  00a7 4d            	tnz	a
2241  00a8 2706          	jreq	L1211
2244  00aa a6ff          	ld	a,#255
2246  00ac ac1f001f      	jpf	L23
2247  00b0               L1211:
2248                     ; 397     return 0;
2250  00b0 4f            	clr	a
2252  00b1 ac1f001f      	jpf	L23
2308                     ; 406 uint8_t swi2c_test_slave(uint8_t slvaddr){
2309                     .text:	section	.text,new
2310  0000               _swi2c_test_slave:
2312  0000 88            	push	a
2313  0001 88            	push	a
2314       00000001      OFST:	set	1
2317                     ; 408 uint8_t mask=0b1<<7;
2319  0002 a680          	ld	a,#128
2320  0004 6b01          	ld	(OFST+0,sp),a
2322                     ; 409 if(swi2c_START()){return 0xaa;}
2324  0006 cd0000        	call	_swi2c_START
2326  0009 4d            	tnz	a
2327  000a 2714          	jreq	L5511
2330  000c a6aa          	ld	a,#170
2332  000e 200c          	jra	L63
2333  0010               L3511:
2334                     ; 411 if(swi2c_writebit(slvaddr & mask)){return 0xff;}
2336  0010 7b02          	ld	a,(OFST+1,sp)
2337  0012 1401          	and	a,(OFST+0,sp)
2338  0014 cd0000        	call	_swi2c_writebit
2340  0017 4d            	tnz	a
2341  0018 2704          	jreq	L1611
2344  001a a6ff          	ld	a,#255
2346  001c               L63:
2348  001c 85            	popw	x
2349  001d 81            	ret
2350  001e               L1611:
2351                     ; 412 mask = mask >>1;
2353  001e 0401          	srl	(OFST+0,sp)
2355  0020               L5511:
2356                     ; 410 while(mask){
2358  0020 0d01          	tnz	(OFST+0,sp)
2359  0022 26ec          	jrne	L3511
2360                     ; 414 ack=swi2c_readbit();
2362  0024 cd0000        	call	_swi2c_readbit
2364  0027 6b01          	ld	(OFST+0,sp),a
2366                     ; 415 if(swi2c_STOP()){return 0xff;}
2368  0029 cd0000        	call	_swi2c_STOP
2370  002c 4d            	tnz	a
2371  002d 2704          	jreq	L3611
2374  002f a6ff          	ld	a,#255
2376  0031 20e9          	jra	L63
2377  0033               L3611:
2378                     ; 416 return ack;
2380  0033 7b01          	ld	a,(OFST+0,sp)
2382  0035 20e5          	jra	L63
2405                     ; 420 void swi2c_init(void){
2406                     .text:	section	.text,new
2407  0000               _swi2c_init:
2411                     ; 421 		PORT(SCL_GPIO, DDR) |= SCL_PIN;   // Set SCL as Output
2413  0000 72165011      	bset	20497,#3
2414                     ; 422     PORT(SCL_GPIO, CR1) &= ~SCL_PIN;  // Set SCL as Open-Drain
2416  0004 72175012      	bres	20498,#3
2417                     ; 423     PORT(SCL_GPIO, CR2) &= ~SCL_PIN;  // Set SCL as Slow Speed
2419  0008 72175013      	bres	20499,#3
2420                     ; 424     PORT(SCL_GPIO, ODR) |= SCL_PIN;   // release important!
2422  000c 7216500f      	bset	20495,#3
2423                     ; 426     PORT(SDA_GPIO, DDR) |= SDA_PIN;   // Set SDA as Output
2425  0010 72145011      	bset	20497,#2
2426                     ; 427     PORT(SDA_GPIO, CR1) &= ~SDA_PIN;  // Set SDA as Open-Drain
2428  0014 72155012      	bres	20498,#2
2429                     ; 428     PORT(SDA_GPIO, CR2) &= ~SDA_PIN;  // Set SDA as Slow Speed
2431  0018 72155013      	bres	20499,#2
2432                     ; 429     PORT(SDA_GPIO, ODR) |= SDA_PIN;   // release important!
2434  001c 7214500f      	bset	20495,#2
2435                     ; 430 }
2438  0020 81            	ret
2482                     ; 438 uint8_t swi2c_readbit(void){
2483                     .text:	section	.text,new
2484  0000               _swi2c_readbit:
2486  0000 5203          	subw	sp,#3
2487       00000003      OFST:	set	3
2490                     ; 439 uint16_t timeout=SWI2C_TIMEOUT;
2492  0002 aeffff        	ldw	x,#65535
2493  0005 1f02          	ldw	(OFST-1,sp),x
2495                     ; 441 SDA_HIGH; // release SDA
2497  0007 7214500f      	bset	20495,#2
2498                     ; 442 SWI2C_SETUP_TIME;
2500  000b ae0005        	ldw	x,#5
2501  000e cd0000        	call	_delay_us
2503                     ; 443 SCL_HIGH;
2505  0011 7216500f      	bset	20495,#3
2507  0015 2007          	jra	L1221
2508  0017               L7121:
2509                     ; 444 while(SCL_stat() == RESET && timeout){timeout--;}
2511  0017 1e02          	ldw	x,(OFST-1,sp)
2512  0019 1d0001        	subw	x,#1
2513  001c 1f02          	ldw	(OFST-1,sp),x
2515  001e               L1221:
2518  001e c65010        	ld	a,20496
2519  0021 a508          	bcp	a,#8
2520  0023 2604          	jrne	L5221
2522  0025 1e02          	ldw	x,(OFST-1,sp)
2523  0027 26ee          	jrne	L7121
2524  0029               L5221:
2525                     ; 445 if(timeout==0){return 0xff;}
2527  0029 1e02          	ldw	x,(OFST-1,sp)
2528  002b 2604          	jrne	L7221
2531  002d a6ff          	ld	a,#255
2533  002f 2021          	jra	L44
2534  0031               L7221:
2535                     ; 446 SWI2C_SCL_HIGH_TIME;
2537  0031 ae0005        	ldw	x,#5
2538  0034 cd0000        	call	_delay_us
2540                     ; 447 if(SDA_stat() == RESET){retval = 0;}else{retval=1;}
2542  0037 c65010        	ld	a,20496
2543  003a a504          	bcp	a,#4
2544  003c 2604          	jrne	L1321
2547  003e 0f01          	clr	(OFST-2,sp)
2550  0040 2004          	jra	L3321
2551  0042               L1321:
2554  0042 a601          	ld	a,#1
2555  0044 6b01          	ld	(OFST-2,sp),a
2557  0046               L3321:
2558                     ; 448 SCL_LOW;
2560  0046 7217500f      	bres	20495,#3
2561                     ; 449 SWI2C_HOLD_TIME; // hold time
2563  004a ae0005        	ldw	x,#5
2564  004d cd0000        	call	_delay_us
2566                     ; 450 return retval;
2568  0050 7b01          	ld	a,(OFST-2,sp)
2570  0052               L44:
2572  0052 5b03          	addw	sp,#3
2573  0054 81            	ret
2617                     ; 456 uint8_t swi2c_writebit(uint8_t bit){
2618                     .text:	section	.text,new
2619  0000               _swi2c_writebit:
2621  0000 89            	pushw	x
2622       00000002      OFST:	set	2
2625                     ; 457 uint16_t timeout=SWI2C_TIMEOUT;
2627  0001 aeffff        	ldw	x,#65535
2628  0004 1f01          	ldw	(OFST-1,sp),x
2630                     ; 458 if(bit){SDA_HIGH;}else{SDA_LOW;} // set desired SDA value
2632  0006 4d            	tnz	a
2633  0007 2706          	jreq	L7521
2636  0009 7214500f      	bset	20495,#2
2638  000d 2004          	jra	L1621
2639  000f               L7521:
2642  000f 7215500f      	bres	20495,#2
2643  0013               L1621:
2644                     ; 459 SWI2C_SETUP_TIME; // setup time
2646  0013 ae0005        	ldw	x,#5
2647  0016 cd0000        	call	_delay_us
2649                     ; 460 SCL_HIGH;		
2651  0019 7216500f      	bset	20495,#3
2653  001d 2007          	jra	L5621
2654  001f               L3621:
2655                     ; 461 while(SCL_stat() == RESET && timeout){timeout--;} // wait until SCL is not high
2657  001f 1e01          	ldw	x,(OFST-1,sp)
2658  0021 1d0001        	subw	x,#1
2659  0024 1f01          	ldw	(OFST-1,sp),x
2661  0026               L5621:
2664  0026 c65010        	ld	a,20496
2665  0029 a508          	bcp	a,#8
2666  002b 2604          	jrne	L1721
2668  002d 1e01          	ldw	x,(OFST-1,sp)
2669  002f 26ee          	jrne	L3621
2670  0031               L1721:
2671                     ; 462 if(timeout==0){SDA_HIGH; return 0xff;} // generate timeout error if SCL is held Low too long
2673  0031 1e01          	ldw	x,(OFST-1,sp)
2674  0033 2608          	jrne	L3721
2677  0035 7214500f      	bset	20495,#2
2680  0039 a6ff          	ld	a,#255
2682  003b 2011          	jra	L05
2683  003d               L3721:
2684                     ; 463 SWI2C_SCL_HIGH_TIME;
2686  003d ae0005        	ldw	x,#5
2687  0040 cd0000        	call	_delay_us
2689                     ; 464 SCL_LOW;
2691  0043 7217500f      	bres	20495,#3
2692                     ; 465 SWI2C_HOLD_TIME; // hold time
2694  0047 ae0005        	ldw	x,#5
2695  004a cd0000        	call	_delay_us
2697                     ; 466 return 0;
2699  004d 4f            	clr	a
2701  004e               L05:
2703  004e 85            	popw	x
2704  004f 81            	ret
2739                     ; 472 uint8_t swi2c_RESTART(void){
2740                     .text:	section	.text,new
2741  0000               _swi2c_RESTART:
2743  0000 89            	pushw	x
2744       00000002      OFST:	set	2
2747                     ; 473 uint16_t timeout=SWI2C_TIMEOUT;
2749  0001 aeffff        	ldw	x,#65535
2750  0004 1f01          	ldw	(OFST-1,sp),x
2752                     ; 474 SCL_LOW;
2754  0006 7217500f      	bres	20495,#3
2755                     ; 475 SDA_HIGH;
2757  000a 7214500f      	bset	20495,#2
2759  000e 2007          	jra	L5131
2760  0010               L3131:
2761                     ; 476 while(SDA_stat() == RESET && timeout){timeout--;}
2763  0010 1e01          	ldw	x,(OFST-1,sp)
2764  0012 1d0001        	subw	x,#1
2765  0015 1f01          	ldw	(OFST-1,sp),x
2767  0017               L5131:
2770  0017 c65010        	ld	a,20496
2771  001a a504          	bcp	a,#4
2772  001c 2604          	jrne	L1231
2774  001e 1e01          	ldw	x,(OFST-1,sp)
2775  0020 26ee          	jrne	L3131
2776  0022               L1231:
2777                     ; 477 if(timeout==0){SCL_HIGH; return 0xff;}
2779  0022 1e01          	ldw	x,(OFST-1,sp)
2780  0024 2608          	jrne	L3231
2783  0026 7216500f      	bset	20495,#3
2786  002a a6ff          	ld	a,#255
2788  002c 2024          	jra	L45
2789  002e               L3231:
2790                     ; 478 SWI2C_SS_TIME;
2792  002e ae0005        	ldw	x,#5
2793  0031 cd0000        	call	_delay_us
2795                     ; 479 SCL_HIGH;
2797  0034 7216500f      	bset	20495,#3
2799  0038 2007          	jra	L7231
2800  003a               L5231:
2801                     ; 480 while(SCL_stat() == RESET && timeout){timeout--;}
2803  003a 1e01          	ldw	x,(OFST-1,sp)
2804  003c 1d0001        	subw	x,#1
2805  003f 1f01          	ldw	(OFST-1,sp),x
2807  0041               L7231:
2810  0041 c65010        	ld	a,20496
2811  0044 a508          	bcp	a,#8
2812  0046 2604          	jrne	L3331
2814  0048 1e01          	ldw	x,(OFST-1,sp)
2815  004a 26ee          	jrne	L5231
2816  004c               L3331:
2817                     ; 481 if(timeout==0){return 0xff;}
2819  004c 1e01          	ldw	x,(OFST-1,sp)
2820  004e 2604          	jrne	L5331
2823  0050 a6ff          	ld	a,#255
2825  0052               L45:
2827  0052 85            	popw	x
2828  0053 81            	ret
2829  0054               L5331:
2830                     ; 482 SWI2C_SS_TIME;
2832  0054 ae0005        	ldw	x,#5
2833  0057 cd0000        	call	_delay_us
2835                     ; 483 SDA_LOW;
2837  005a 7215500f      	bres	20495,#2
2838                     ; 484 SWI2C_SS_TIME;
2840  005e ae0005        	ldw	x,#5
2841  0061 cd0000        	call	_delay_us
2843                     ; 485 SCL_LOW;
2845  0064 7217500f      	bres	20495,#3
2846                     ; 486 SWI2C_SS_TIME;
2848  0068 ae0005        	ldw	x,#5
2849  006b cd0000        	call	_delay_us
2851                     ; 487 return 0;
2853  006e 4f            	clr	a
2855  006f 20e1          	jra	L45
2890                     ; 493 uint8_t swi2c_START(void){
2891                     .text:	section	.text,new
2892  0000               _swi2c_START:
2894  0000 89            	pushw	x
2895       00000002      OFST:	set	2
2898                     ; 494 uint16_t timeout=SWI2C_TIMEOUT;
2900  0001 aeffff        	ldw	x,#65535
2901  0004 1f01          	ldw	(OFST-1,sp),x
2904  0006 2007          	jra	L1631
2905  0008               L5531:
2906                     ; 495 while((SCL_stat() == RESET || SDA_stat() == RESET) && timeout){timeout--;}
2908  0008 1e01          	ldw	x,(OFST-1,sp)
2909  000a 1d0001        	subw	x,#1
2910  000d 1f01          	ldw	(OFST-1,sp),x
2912  000f               L1631:
2915  000f c65010        	ld	a,20496
2916  0012 a508          	bcp	a,#8
2917  0014 2707          	jreq	L7631
2919  0016 c65010        	ld	a,20496
2920  0019 a504          	bcp	a,#4
2921  001b 2604          	jrne	L5631
2922  001d               L7631:
2924  001d 1e01          	ldw	x,(OFST-1,sp)
2925  001f 26e7          	jrne	L5531
2926  0021               L5631:
2927                     ; 496 if(timeout == 0){return 0xff;}
2929  0021 1e01          	ldw	x,(OFST-1,sp)
2930  0023 2604          	jrne	L1731
2933  0025 a6ff          	ld	a,#255
2935  0027 2015          	jra	L06
2936  0029               L1731:
2937                     ; 498 SDA_LOW;
2939  0029 7215500f      	bres	20495,#2
2940                     ; 499 SWI2C_SS_TIME;
2942  002d ae0005        	ldw	x,#5
2943  0030 cd0000        	call	_delay_us
2945                     ; 500 SCL_LOW;
2947  0033 7217500f      	bres	20495,#3
2948                     ; 501 SWI2C_SS_TIME;
2950  0037 ae0005        	ldw	x,#5
2951  003a cd0000        	call	_delay_us
2953                     ; 502 return 0;
2955  003d 4f            	clr	a
2957  003e               L06:
2959  003e 85            	popw	x
2960  003f 81            	ret
3004                     ; 508 uint8_t swi2c_STOP(void){
3005                     .text:	section	.text,new
3006  0000               _swi2c_STOP:
3008  0000 5203          	subw	sp,#3
3009       00000003      OFST:	set	3
3012                     ; 509 uint16_t timeout=SWI2C_TIMEOUT;
3014  0002 aeffff        	ldw	x,#65535
3015  0005 1f02          	ldw	(OFST-1,sp),x
3017                     ; 510 uint8_t retval = 0;
3019  0007 0f01          	clr	(OFST-2,sp)
3021                     ; 511 SDA_LOW;
3023  0009 7215500f      	bres	20495,#2
3024                     ; 512 SWI2C_SS_TIME;
3026  000d ae0005        	ldw	x,#5
3027  0010 cd0000        	call	_delay_us
3029                     ; 513 SCL_HIGH;
3031  0013 7216500f      	bset	20495,#3
3033  0017 2007          	jra	L7141
3034  0019               L5141:
3035                     ; 514 while(SCL_stat() == RESET && timeout){timeout--;}
3037  0019 1e02          	ldw	x,(OFST-1,sp)
3038  001b 1d0001        	subw	x,#1
3039  001e 1f02          	ldw	(OFST-1,sp),x
3041  0020               L7141:
3044  0020 c65010        	ld	a,20496
3045  0023 a508          	bcp	a,#8
3046  0025 2604          	jrne	L3241
3048  0027 1e02          	ldw	x,(OFST-1,sp)
3049  0029 26ee          	jrne	L5141
3050  002b               L3241:
3051                     ; 515 if(timeout==0){retval = 0xff;}
3053  002b 1e02          	ldw	x,(OFST-1,sp)
3054  002d 2604          	jrne	L5241
3057  002f a6ff          	ld	a,#255
3058  0031 6b01          	ld	(OFST-2,sp),a
3060  0033               L5241:
3061                     ; 516 SWI2C_SS_TIME;
3063  0033 ae0005        	ldw	x,#5
3064  0036 cd0000        	call	_delay_us
3066                     ; 517 SDA_HIGH;
3068  0039 7214500f      	bset	20495,#2
3069                     ; 518 return retval;
3071  003d 7b01          	ld	a,(OFST-2,sp)
3074  003f 5b03          	addw	sp,#3
3075  0041 81            	ret
3120                     ; 525 uint8_t swi2c_recover(void){
3121                     .text:	section	.text,new
3122  0000               _swi2c_recover:
3124  0000 5203          	subw	sp,#3
3125       00000003      OFST:	set	3
3128                     ; 526 uint16_t timeout=SWI2C_TIMEOUT;
3130  0002 aeffff        	ldw	x,#65535
3131  0005 1f02          	ldw	(OFST-1,sp),x
3133                     ; 528 SCL_HIGH; // release both lines
3135  0007 7216500f      	bset	20495,#3
3136                     ; 529 SDA_HIGH;
3138  000b 7214500f      	bset	20495,#2
3139                     ; 530 SWI2C_SETUP_TIME;
3141  000f ae0005        	ldw	x,#5
3142  0012 cd0000        	call	_delay_us
3144                     ; 532 if(SCL_stat() != RESET && SDA_stat() != RESET){return 0;}
3146  0015 c65010        	ld	a,20496
3147  0018 a508          	bcp	a,#8
3148  001a 270a          	jreq	L1541
3150  001c c65010        	ld	a,20496
3151  001f a504          	bcp	a,#4
3152  0021 2703          	jreq	L1541
3155  0023 4f            	clr	a
3157  0024 2031          	jra	L66
3158  0026               L1541:
3159                     ; 534 if(SDA_stat() == RESET){
3161  0026 c65010        	ld	a,20496
3162  0029 a504          	bcp	a,#4
3163  002b 264b          	jrne	L3541
3164                     ; 535 	for(i=0;i<9;i++){ // try nine times try to read one bit and pray for SDA release
3166  002d 0f01          	clr	(OFST-2,sp)
3168  002f               L5541:
3169                     ; 536 		SCL_LOW;
3171  002f 7217500f      	bres	20495,#3
3172                     ; 537 		SWI2C_HOLD_TIME; 
3174  0033 ae0005        	ldw	x,#5
3175  0036 cd0000        	call	_delay_us
3177                     ; 538 		SCL_HIGH; 
3179  0039 7216500f      	bset	20495,#3
3181  003d 2007          	jra	L5641
3182  003f               L3641:
3183                     ; 539 		while(SCL_stat() == RESET && timeout){timeout--;}
3185  003f 1e02          	ldw	x,(OFST-1,sp)
3186  0041 1d0001        	subw	x,#1
3187  0044 1f02          	ldw	(OFST-1,sp),x
3189  0046               L5641:
3192  0046 c65010        	ld	a,20496
3193  0049 a508          	bcp	a,#8
3194  004b 2604          	jrne	L1741
3196  004d 1e02          	ldw	x,(OFST-1,sp)
3197  004f 26ee          	jrne	L3641
3198  0051               L1741:
3199                     ; 540 		if(timeout==0){return 0xff;}
3201  0051 1e02          	ldw	x,(OFST-1,sp)
3202  0053 2605          	jrne	L3741
3205  0055 a6ff          	ld	a,#255
3207  0057               L66:
3209  0057 5b03          	addw	sp,#3
3210  0059 81            	ret
3211  005a               L3741:
3212                     ; 541 		SWI2C_SCL_HIGH_TIME; 
3214  005a ae0005        	ldw	x,#5
3215  005d cd0000        	call	_delay_us
3217                     ; 542 		if(SDA_stat() != RESET){ // if slave released SDA line, generate STOP
3219  0060 c65010        	ld	a,20496
3220  0063 a504          	bcp	a,#4
3221  0065 2705          	jreq	L5741
3222                     ; 543 			return(swi2c_STOP());
3224  0067 cd0000        	call	_swi2c_STOP
3227  006a 20eb          	jra	L66
3228  006c               L5741:
3229                     ; 535 	for(i=0;i<9;i++){ // try nine times try to read one bit and pray for SDA release
3231  006c 0c01          	inc	(OFST-2,sp)
3235  006e 7b01          	ld	a,(OFST-2,sp)
3236  0070 a109          	cp	a,#9
3237  0072 25bb          	jrult	L5541
3238                     ; 546 		return 0xee;
3240  0074 a6ee          	ld	a,#238
3242  0076 20df          	jra	L66
3243  0078               L3541:
3244                     ; 548 }
3246  0078 20dd          	jra	L66
3259                     	xdef	_swi2c_STOP
3260                     	xdef	_swi2c_RESTART
3261                     	xdef	_swi2c_START
3262                     	xdef	_swi2c_readbit
3263                     	xdef	_swi2c_writebit
3264                     	xdef	_swi2c_recover
3265                     	xdef	_swi2c_read_eemem
3266                     	xdef	_swi2c_write_eemem
3267                     	xdef	_swi2c_read_array
3268                     	xdef	_swi2c_write_array
3269                     	xdef	_swi2c_read_buf
3270                     	xdef	_swi2c_write_buf
3271                     	xdef	_swi2c_test_slave
3272                     	xdef	_swi2c_init
3273                     	xref	_delay_us
3292                     	end
