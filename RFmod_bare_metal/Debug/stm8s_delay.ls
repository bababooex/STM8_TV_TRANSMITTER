   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
  64                     ; 3 void delay_us(unsigned int  value)
  64                     ; 4 {
  66                     .text:	section	.text,new
  67  0000               _delay_us:
  69  0000 89            	pushw	x
  70       00000002      OFST:	set	2
  73                     ; 5 	register unsigned int loops =  (dly_const * value) ;
  75  0001 cd0000        	call	c_uitof
  77  0004 ae0000        	ldw	x,#L73
  78  0007 cd0000        	call	c_fmul
  80  000a cd0000        	call	c_ftoi
  82  000d 1f01          	ldw	(OFST-1,sp),x
  85  000f 2008          	jra	L74
  86  0011               L34:
  87                     ; 9 		_asm ("nop");
  90  0011 9d            nop
  92                     ; 10 		loops--;
  94  0012 1e01          	ldw	x,(OFST-1,sp)
  95  0014 1d0001        	subw	x,#1
  96  0017 1f01          	ldw	(OFST-1,sp),x
  98  0019               L74:
  99                     ; 7 	while(loops)
 101  0019 1e01          	ldw	x,(OFST-1,sp)
 102  001b 26f4          	jrne	L34
 103                     ; 12 }
 107  001d 85            	popw	x
 108  001e 81            	ret
 143                     ; 15 void delay_ms(unsigned int  value)
 143                     ; 16 {
 144                     .text:	section	.text,new
 145  0000               _delay_ms:
 147  0000 89            	pushw	x
 148       00000000      OFST:	set	0
 151  0001 200d          	jra	L37
 152  0003               L17:
 153                     ; 19 		delay_us(1000);
 155  0003 ae03e8        	ldw	x,#1000
 156  0006 cd0000        	call	_delay_us
 158                     ; 20 		value--;
 160  0009 1e01          	ldw	x,(OFST+1,sp)
 161  000b 1d0001        	subw	x,#1
 162  000e 1f01          	ldw	(OFST+1,sp),x
 163  0010               L37:
 164                     ; 17 	while(value)
 166  0010 1e01          	ldw	x,(OFST+1,sp)
 167  0012 26ef          	jrne	L17
 168                     ; 22 }
 172  0014 85            	popw	x
 173  0015 81            	ret
 186                     	xdef	_delay_ms
 187                     	xdef	_delay_us
 188                     .const:	section	.text
 189  0000               L73:
 190  0000 3f800000      	dc.w	16256,0
 191                     	xref.b	c_x
 211                     	xref	c_ftoi
 212                     	xref	c_fmul
 213                     	xref	c_uitof
 214                     	end
