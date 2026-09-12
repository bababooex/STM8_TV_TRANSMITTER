   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
  15                     	bsct
  16  0000               _set_brightness:
  17  0000 07            	dc.b	7
  18  0001               _set_state:
  19  0001 08            	dc.b	8
  59                     .const:	section	.text
  60  0000               L01:
  61  0000 02f5          	dc.w	L112
  62  0002 032c          	dc.w	L322
  63  0004 032c          	dc.w	L322
  64  0006 030b          	dc.w	L512
  65  0008 0300          	dc.w	L312
  66  000a 032c          	dc.w	L322
  67  000c 02d4          	dc.w	L302
  68  000e 0321          	dc.w	L122
  69  0010 0316          	dc.w	L712
  70  0012 001f          	dc.w	L5
  71  0014 002a          	dc.w	L7
  72  0016 0035          	dc.w	L11
  73  0018 0040          	dc.w	L31
  74  001a 004b          	dc.w	L51
  75  001c 0056          	dc.w	L71
  76  001e 0061          	dc.w	L12
  77  0020 006c          	dc.w	L32
  78  0022 0077          	dc.w	L52
  79  0024 0082          	dc.w	L72
  80  0026 032c          	dc.w	L322
  81  0028 032c          	dc.w	L322
  82  002a 032c          	dc.w	L322
  83  002c 032c          	dc.w	L322
  84  002e 032c          	dc.w	L322
  85  0030 032c          	dc.w	L322
  86  0032 032c          	dc.w	L322
  87  0034 008d          	dc.w	L13
  88  0036 0098          	dc.w	L33
  89  0038 00a3          	dc.w	L53
  90  003a 00ae          	dc.w	L73
  91  003c 00b9          	dc.w	L14
  92  003e 00c4          	dc.w	L34
  93  0040 00cf          	dc.w	L54
  94  0042 00da          	dc.w	L74
  95  0044 00e5          	dc.w	L15
  96  0046 00f0          	dc.w	L35
  97  0048 00fb          	dc.w	L55
  98  004a 0106          	dc.w	L75
  99  004c 0111          	dc.w	L16
 100  004e 011c          	dc.w	L36
 101  0050 0127          	dc.w	L56
 102  0052 0132          	dc.w	L76
 103  0054 013d          	dc.w	L17
 104  0056 0148          	dc.w	L37
 105  0058 0153          	dc.w	L57
 106  005a 015e          	dc.w	L77
 107  005c 0169          	dc.w	L101
 108  005e 0174          	dc.w	L301
 109  0060 017f          	dc.w	L501
 110  0062 018a          	dc.w	L701
 111  0064 0195          	dc.w	L111
 112  0066 01a0          	dc.w	L311
 113  0068 032c          	dc.w	L322
 114  006a 032c          	dc.w	L322
 115  006c 032c          	dc.w	L322
 116  006e 032c          	dc.w	L322
 117  0070 02df          	dc.w	L502
 118  0072 032c          	dc.w	L322
 119  0074 01ab          	dc.w	L511
 120  0076 01b6          	dc.w	L711
 121  0078 01c1          	dc.w	L121
 122  007a 01cc          	dc.w	L321
 123  007c 01d7          	dc.w	L521
 124  007e 01e2          	dc.w	L721
 125  0080 01ed          	dc.w	L131
 126  0082 01f8          	dc.w	L331
 127  0084 0203          	dc.w	L531
 128  0086 020e          	dc.w	L731
 129  0088 0219          	dc.w	L141
 130  008a 0224          	dc.w	L341
 131  008c 022f          	dc.w	L541
 132  008e 023a          	dc.w	L741
 133  0090 0245          	dc.w	L151
 134  0092 0250          	dc.w	L351
 135  0094 025b          	dc.w	L551
 136  0096 0266          	dc.w	L751
 137  0098 0271          	dc.w	L161
 138  009a 027c          	dc.w	L361
 139  009c 0287          	dc.w	L561
 140  009e 0292          	dc.w	L761
 141  00a0 029d          	dc.w	L171
 142  00a2 02a8          	dc.w	L371
 143  00a4 02b3          	dc.w	L571
 144  00a6 02be          	dc.w	L771
 145                     ; 7 static uint32_t pt6311_font(char chr)
 145                     ; 8 {
 146                     	scross	off
 147                     .text:	section	.text,new
 148  0000               L3_pt6311_font:
 152                     ; 9     switch(chr)
 155                     ; 88         default: return 0;
 156  0000 a027          	sub	a,#39
 157  0002 a154          	cp	a,#84
 158  0004 2407          	jruge	L6
 159  0006 5f            	clrw	x
 160  0007 97            	ld	xl,a
 161  0008 58            	sllw	x
 162  0009 de0000        	ldw	x,(L01,x)
 163  000c fc            	jp	(x)
 164  000d               L6:
 165  000d a0f9          	sub	a,#-7
 166  000f 2603          	jrne	L21
 167  0011 cc02c9        	jp	L102
 168  0014               L21:
 169  0014 a002          	sub	a,#2
 170  0016 2603          	jrne	L41
 171  0018 cc02ea        	jp	L702
 172  001b               L41:
 173  001b ac2c032c      	jpf	L322
 174  001f               L5:
 175                     ; 12         case '0': return SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_F;
 177  001f ae003f        	ldw	x,#63
 178  0022 bf02          	ldw	c_lreg+2,x
 179  0024 ae0000        	ldw	x,#0
 180  0027 bf00          	ldw	c_lreg,x
 183  0029 81            	ret
 184  002a               L7:
 185                     ; 13         case '1': return SEG_B | SEG_C | SEG_J ;
 187  002a ae0406        	ldw	x,#1030
 188  002d bf02          	ldw	c_lreg+2,x
 189  002f ae0000        	ldw	x,#0
 190  0032 bf00          	ldw	c_lreg,x
 193  0034 81            	ret
 194  0035               L11:
 195                     ; 14         case '2': return SEG_A | SEG_B | SEG_G1 | SEG_G2 | SEG_D | SEG_E;
 197  0035 ae00db        	ldw	x,#219
 198  0038 bf02          	ldw	c_lreg+2,x
 199  003a ae0000        	ldw	x,#0
 200  003d bf00          	ldw	c_lreg,x
 203  003f 81            	ret
 204  0040               L31:
 205                     ; 15         case '3': return SEG_A | SEG_B | SEG_C | SEG_D | SEG_G1 | SEG_G2;
 207  0040 ae00cf        	ldw	x,#207
 208  0043 bf02          	ldw	c_lreg+2,x
 209  0045 ae0000        	ldw	x,#0
 210  0048 bf00          	ldw	c_lreg,x
 213  004a 81            	ret
 214  004b               L51:
 215                     ; 16         case '4': return SEG_F | SEG_G1 | SEG_G2 | SEG_B | SEG_C;
 217  004b ae00e6        	ldw	x,#230
 218  004e bf02          	ldw	c_lreg+2,x
 219  0050 ae0000        	ldw	x,#0
 220  0053 bf00          	ldw	c_lreg,x
 223  0055 81            	ret
 224  0056               L71:
 225                     ; 17         case '5': return SEG_A | SEG_F | SEG_G1 | SEG_M | SEG_D;
 227  0056 ae2069        	ldw	x,#8297
 228  0059 bf02          	ldw	c_lreg+2,x
 229  005b ae0000        	ldw	x,#0
 230  005e bf00          	ldw	c_lreg,x
 233  0060 81            	ret
 234  0061               L12:
 235                     ; 18         case '6': return SEG_A | SEG_F | SEG_E | SEG_D | SEG_C | SEG_G1 | SEG_G2;
 237  0061 ae00fd        	ldw	x,#253
 238  0064 bf02          	ldw	c_lreg+2,x
 239  0066 ae0000        	ldw	x,#0
 240  0069 bf00          	ldw	c_lreg,x
 243  006b 81            	ret
 244  006c               L32:
 245                     ; 19         case '7': return SEG_A | SEG_B | SEG_C;
 247  006c ae0007        	ldw	x,#7
 248  006f bf02          	ldw	c_lreg+2,x
 249  0071 ae0000        	ldw	x,#0
 250  0074 bf00          	ldw	c_lreg,x
 253  0076 81            	ret
 254  0077               L52:
 255                     ; 20         case '8': return SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_F | SEG_G1 | SEG_G2;
 257  0077 ae00ff        	ldw	x,#255
 258  007a bf02          	ldw	c_lreg+2,x
 259  007c ae0000        	ldw	x,#0
 260  007f bf00          	ldw	c_lreg,x
 263  0081 81            	ret
 264  0082               L72:
 265                     ; 21         case '9': return SEG_A | SEG_B | SEG_C | SEG_D | SEG_F | SEG_G1 | SEG_G2;
 267  0082 ae00ef        	ldw	x,#239
 268  0085 bf02          	ldw	c_lreg+2,x
 269  0087 ae0000        	ldw	x,#0
 270  008a bf00          	ldw	c_lreg,x
 273  008c 81            	ret
 274  008d               L13:
 275                     ; 24 				case 'A': return SEG_A|SEG_B|SEG_C|SEG_E|SEG_F|SEG_G1|SEG_G2;
 277  008d ae00f7        	ldw	x,#247
 278  0090 bf02          	ldw	c_lreg+2,x
 279  0092 ae0000        	ldw	x,#0
 280  0095 bf00          	ldw	c_lreg,x
 283  0097 81            	ret
 284  0098               L33:
 285                     ; 25 				case 'B': return SEG_A|SEG_B|SEG_C|SEG_D|SEG_G1|SEG_G2|SEG_I|SEG_L;
 287  0098 ae12cf        	ldw	x,#4815
 288  009b bf02          	ldw	c_lreg+2,x
 289  009d ae0000        	ldw	x,#0
 290  00a0 bf00          	ldw	c_lreg,x
 293  00a2 81            	ret
 294  00a3               L53:
 295                     ; 26 				case 'C': return SEG_A|SEG_D|SEG_E|SEG_F;
 297  00a3 ae0039        	ldw	x,#57
 298  00a6 bf02          	ldw	c_lreg+2,x
 299  00a8 ae0000        	ldw	x,#0
 300  00ab bf00          	ldw	c_lreg,x
 303  00ad 81            	ret
 304  00ae               L73:
 305                     ; 27 				case 'D': return SEG_A|SEG_B|SEG_C|SEG_D|SEG_I|SEG_L;
 307  00ae ae120f        	ldw	x,#4623
 308  00b1 bf02          	ldw	c_lreg+2,x
 309  00b3 ae0000        	ldw	x,#0
 310  00b6 bf00          	ldw	c_lreg,x
 313  00b8 81            	ret
 314  00b9               L14:
 315                     ; 28 				case 'E': return SEG_A|SEG_D|SEG_E|SEG_F|SEG_G1|SEG_G2;
 317  00b9 ae00f9        	ldw	x,#249
 318  00bc bf02          	ldw	c_lreg+2,x
 319  00be ae0000        	ldw	x,#0
 320  00c1 bf00          	ldw	c_lreg,x
 323  00c3 81            	ret
 324  00c4               L34:
 325                     ; 29 				case 'F': return SEG_A|SEG_E|SEG_F|SEG_G1|SEG_G2;
 327  00c4 ae00f1        	ldw	x,#241
 328  00c7 bf02          	ldw	c_lreg+2,x
 329  00c9 ae0000        	ldw	x,#0
 330  00cc bf00          	ldw	c_lreg,x
 333  00ce 81            	ret
 334  00cf               L54:
 335                     ; 30 				case 'G': return SEG_A|SEG_C|SEG_D|SEG_E|SEG_F|SEG_G2;
 337  00cf ae00bd        	ldw	x,#189
 338  00d2 bf02          	ldw	c_lreg+2,x
 339  00d4 ae0000        	ldw	x,#0
 340  00d7 bf00          	ldw	c_lreg,x
 343  00d9 81            	ret
 344  00da               L74:
 345                     ; 31 				case 'H': return SEG_B|SEG_C|SEG_E|SEG_F|SEG_G1|SEG_G2;
 347  00da ae00f6        	ldw	x,#246
 348  00dd bf02          	ldw	c_lreg+2,x
 349  00df ae0000        	ldw	x,#0
 350  00e2 bf00          	ldw	c_lreg,x
 353  00e4 81            	ret
 354  00e5               L15:
 355                     ; 32 				case 'I': return SEG_A|SEG_D|SEG_I|SEG_L;
 357  00e5 ae1209        	ldw	x,#4617
 358  00e8 bf02          	ldw	c_lreg+2,x
 359  00ea ae0000        	ldw	x,#0
 360  00ed bf00          	ldw	c_lreg,x
 363  00ef 81            	ret
 364  00f0               L35:
 365                     ; 33 				case 'J': return SEG_B|SEG_C|SEG_D|SEG_E;
 367  00f0 ae001e        	ldw	x,#30
 368  00f3 bf02          	ldw	c_lreg+2,x
 369  00f5 ae0000        	ldw	x,#0
 370  00f8 bf00          	ldw	c_lreg,x
 373  00fa 81            	ret
 374  00fb               L55:
 375                     ; 34 				case 'K': return SEG_E|SEG_F|SEG_G1|SEG_J|SEG_M;
 377  00fb ae2470        	ldw	x,#9328
 378  00fe bf02          	ldw	c_lreg+2,x
 379  0100 ae0000        	ldw	x,#0
 380  0103 bf00          	ldw	c_lreg,x
 383  0105 81            	ret
 384  0106               L75:
 385                     ; 35 				case 'L': return SEG_D|SEG_E|SEG_F;
 387  0106 ae0038        	ldw	x,#56
 388  0109 bf02          	ldw	c_lreg+2,x
 389  010b ae0000        	ldw	x,#0
 390  010e bf00          	ldw	c_lreg,x
 393  0110 81            	ret
 394  0111               L16:
 395                     ; 36 				case 'M': return SEG_B|SEG_C|SEG_E|SEG_F|SEG_H|SEG_J;
 397  0111 ae0536        	ldw	x,#1334
 398  0114 bf02          	ldw	c_lreg+2,x
 399  0116 ae0000        	ldw	x,#0
 400  0119 bf00          	ldw	c_lreg,x
 403  011b 81            	ret
 404  011c               L36:
 405                     ; 37 				case 'N': return SEG_B|SEG_C|SEG_E|SEG_F|SEG_H|SEG_M;
 407  011c ae2136        	ldw	x,#8502
 408  011f bf02          	ldw	c_lreg+2,x
 409  0121 ae0000        	ldw	x,#0
 410  0124 bf00          	ldw	c_lreg,x
 413  0126 81            	ret
 414  0127               L56:
 415                     ; 38 				case 'O': return SEG_A|SEG_B|SEG_C|SEG_D|SEG_E|SEG_F;
 417  0127 ae003f        	ldw	x,#63
 418  012a bf02          	ldw	c_lreg+2,x
 419  012c ae0000        	ldw	x,#0
 420  012f bf00          	ldw	c_lreg,x
 423  0131 81            	ret
 424  0132               L76:
 425                     ; 39 				case 'P': return SEG_A|SEG_B|SEG_E|SEG_F|SEG_G1|SEG_G2;
 427  0132 ae00f3        	ldw	x,#243
 428  0135 bf02          	ldw	c_lreg+2,x
 429  0137 ae0000        	ldw	x,#0
 430  013a bf00          	ldw	c_lreg,x
 433  013c 81            	ret
 434  013d               L17:
 435                     ; 40 				case 'Q': return SEG_A|SEG_B|SEG_C|SEG_D|SEG_E|SEG_F|SEG_M;
 437  013d ae203f        	ldw	x,#8255
 438  0140 bf02          	ldw	c_lreg+2,x
 439  0142 ae0000        	ldw	x,#0
 440  0145 bf00          	ldw	c_lreg,x
 443  0147 81            	ret
 444  0148               L37:
 445                     ; 41 				case 'R': return SEG_A|SEG_B|SEG_E|SEG_F|SEG_G1|SEG_G2|SEG_M;
 447  0148 ae20f3        	ldw	x,#8435
 448  014b bf02          	ldw	c_lreg+2,x
 449  014d ae0000        	ldw	x,#0
 450  0150 bf00          	ldw	c_lreg,x
 453  0152 81            	ret
 454  0153               L57:
 455                     ; 42 				case 'S': return SEG_A|SEG_C|SEG_D|SEG_F|SEG_G1|SEG_G2;
 457  0153 ae00ed        	ldw	x,#237
 458  0156 bf02          	ldw	c_lreg+2,x
 459  0158 ae0000        	ldw	x,#0
 460  015b bf00          	ldw	c_lreg,x
 463  015d 81            	ret
 464  015e               L77:
 465                     ; 43 				case 'T': return SEG_A|SEG_I|SEG_L;
 467  015e ae1201        	ldw	x,#4609
 468  0161 bf02          	ldw	c_lreg+2,x
 469  0163 ae0000        	ldw	x,#0
 470  0166 bf00          	ldw	c_lreg,x
 473  0168 81            	ret
 474  0169               L101:
 475                     ; 44 				case 'U': return SEG_B|SEG_C|SEG_D|SEG_E|SEG_F;
 477  0169 ae003e        	ldw	x,#62
 478  016c bf02          	ldw	c_lreg+2,x
 479  016e ae0000        	ldw	x,#0
 480  0171 bf00          	ldw	c_lreg,x
 483  0173 81            	ret
 484  0174               L301:
 485                     ; 45 				case 'V': return SEG_E|SEG_F|SEG_J|SEG_K;
 487  0174 ae0c30        	ldw	x,#3120
 488  0177 bf02          	ldw	c_lreg+2,x
 489  0179 ae0000        	ldw	x,#0
 490  017c bf00          	ldw	c_lreg,x
 493  017e 81            	ret
 494  017f               L501:
 495                     ; 46 				case 'W': return SEG_B|SEG_C|SEG_E|SEG_F|SEG_K|SEG_M;
 497  017f ae2836        	ldw	x,#10294
 498  0182 bf02          	ldw	c_lreg+2,x
 499  0184 ae0000        	ldw	x,#0
 500  0187 bf00          	ldw	c_lreg,x
 503  0189 81            	ret
 504  018a               L701:
 505                     ; 47 				case 'X': return SEG_H|SEG_J|SEG_K|SEG_M;
 507  018a ae2d00        	ldw	x,#11520
 508  018d bf02          	ldw	c_lreg+2,x
 509  018f ae0000        	ldw	x,#0
 510  0192 bf00          	ldw	c_lreg,x
 513  0194 81            	ret
 514  0195               L111:
 515                     ; 48 				case 'Y': return SEG_B|SEG_C|SEG_D|SEG_F|SEG_G1|SEG_G2;
 517  0195 ae00ee        	ldw	x,#238
 518  0198 bf02          	ldw	c_lreg+2,x
 519  019a ae0000        	ldw	x,#0
 520  019d bf00          	ldw	c_lreg,x
 523  019f 81            	ret
 524  01a0               L311:
 525                     ; 49 				case 'Z': return SEG_A|SEG_D|SEG_J|SEG_K;
 527  01a0 ae0c09        	ldw	x,#3081
 528  01a3 bf02          	ldw	c_lreg+2,x
 529  01a5 ae0000        	ldw	x,#0
 530  01a8 bf00          	ldw	c_lreg,x
 533  01aa 81            	ret
 534  01ab               L511:
 535                     ; 52 				case 'a': return SEG_B|SEG_C|SEG_D|SEG_E|SEG_G1|SEG_G2;
 537  01ab ae00de        	ldw	x,#222
 538  01ae bf02          	ldw	c_lreg+2,x
 539  01b0 ae0000        	ldw	x,#0
 540  01b3 bf00          	ldw	c_lreg,x
 543  01b5 81            	ret
 544  01b6               L711:
 545                     ; 53 				case 'b': return SEG_C|SEG_D|SEG_E|SEG_F|SEG_G1|SEG_G2;
 547  01b6 ae00fc        	ldw	x,#252
 548  01b9 bf02          	ldw	c_lreg+2,x
 549  01bb ae0000        	ldw	x,#0
 550  01be bf00          	ldw	c_lreg,x
 553  01c0 81            	ret
 554  01c1               L121:
 555                     ; 54 				case 'c': return SEG_D|SEG_E|SEG_G1|SEG_G2;
 557  01c1 ae00d8        	ldw	x,#216
 558  01c4 bf02          	ldw	c_lreg+2,x
 559  01c6 ae0000        	ldw	x,#0
 560  01c9 bf00          	ldw	c_lreg,x
 563  01cb 81            	ret
 564  01cc               L321:
 565                     ; 55 				case 'd': return SEG_B|SEG_C|SEG_D|SEG_E|SEG_G1|SEG_G2;
 567  01cc ae00de        	ldw	x,#222
 568  01cf bf02          	ldw	c_lreg+2,x
 569  01d1 ae0000        	ldw	x,#0
 570  01d4 bf00          	ldw	c_lreg,x
 573  01d6 81            	ret
 574  01d7               L521:
 575                     ; 56 				case 'e': return SEG_A|SEG_B|SEG_D|SEG_E|SEG_G1|SEG_G2;
 577  01d7 ae00db        	ldw	x,#219
 578  01da bf02          	ldw	c_lreg+2,x
 579  01dc ae0000        	ldw	x,#0
 580  01df bf00          	ldw	c_lreg,x
 583  01e1 81            	ret
 584  01e2               L721:
 585                     ; 57 				case 'f': return SEG_A|SEG_E|SEG_F|SEG_G1|SEG_G2;
 587  01e2 ae00f1        	ldw	x,#241
 588  01e5 bf02          	ldw	c_lreg+2,x
 589  01e7 ae0000        	ldw	x,#0
 590  01ea bf00          	ldw	c_lreg,x
 593  01ec 81            	ret
 594  01ed               L131:
 595                     ; 58 				case 'g': return SEG_A|SEG_B|SEG_C|SEG_D|SEG_F|SEG_G1|SEG_G2;
 597  01ed ae00ef        	ldw	x,#239
 598  01f0 bf02          	ldw	c_lreg+2,x
 599  01f2 ae0000        	ldw	x,#0
 600  01f5 bf00          	ldw	c_lreg,x
 603  01f7 81            	ret
 604  01f8               L331:
 605                     ; 59 				case 'h': return SEG_C|SEG_E|SEG_F|SEG_G1|SEG_G2;
 607  01f8 ae00f4        	ldw	x,#244
 608  01fb bf02          	ldw	c_lreg+2,x
 609  01fd ae0000        	ldw	x,#0
 610  0200 bf00          	ldw	c_lreg,x
 613  0202 81            	ret
 614  0203               L531:
 615                     ; 60 				case 'i': return SEG_L;
 617  0203 ae1000        	ldw	x,#4096
 618  0206 bf02          	ldw	c_lreg+2,x
 619  0208 ae0000        	ldw	x,#0
 620  020b bf00          	ldw	c_lreg,x
 623  020d 81            	ret
 624  020e               L731:
 625                     ; 61 				case 'j': return SEG_C|SEG_D;
 627  020e ae000c        	ldw	x,#12
 628  0211 bf02          	ldw	c_lreg+2,x
 629  0213 ae0000        	ldw	x,#0
 630  0216 bf00          	ldw	c_lreg,x
 633  0218 81            	ret
 634  0219               L141:
 635                     ; 62 				case 'k': return SEG_E|SEG_F|SEG_G1|SEG_M;
 637  0219 ae2070        	ldw	x,#8304
 638  021c bf02          	ldw	c_lreg+2,x
 639  021e ae0000        	ldw	x,#0
 640  0221 bf00          	ldw	c_lreg,x
 643  0223 81            	ret
 644  0224               L341:
 645                     ; 63 				case 'l': return SEG_D|SEG_E|SEG_F;
 647  0224 ae0038        	ldw	x,#56
 648  0227 bf02          	ldw	c_lreg+2,x
 649  0229 ae0000        	ldw	x,#0
 650  022c bf00          	ldw	c_lreg,x
 653  022e 81            	ret
 654  022f               L541:
 655                     ; 64 				case 'm': return SEG_C|SEG_E|SEG_G1|SEG_G2|SEG_K|SEG_M;
 657  022f ae28d4        	ldw	x,#10452
 658  0232 bf02          	ldw	c_lreg+2,x
 659  0234 ae0000        	ldw	x,#0
 660  0237 bf00          	ldw	c_lreg,x
 663  0239 81            	ret
 664  023a               L741:
 665                     ; 65 				case 'n': return SEG_C|SEG_E|SEG_G1|SEG_G2;
 667  023a ae00d4        	ldw	x,#212
 668  023d bf02          	ldw	c_lreg+2,x
 669  023f ae0000        	ldw	x,#0
 670  0242 bf00          	ldw	c_lreg,x
 673  0244 81            	ret
 674  0245               L151:
 675                     ; 66 				case 'o': return SEG_C|SEG_D|SEG_E|SEG_G1|SEG_G2;
 677  0245 ae00dc        	ldw	x,#220
 678  0248 bf02          	ldw	c_lreg+2,x
 679  024a ae0000        	ldw	x,#0
 680  024d bf00          	ldw	c_lreg,x
 683  024f 81            	ret
 684  0250               L351:
 685                     ; 67 				case 'p': return SEG_A|SEG_B|SEG_E|SEG_F|SEG_G1|SEG_G2;
 687  0250 ae00f3        	ldw	x,#243
 688  0253 bf02          	ldw	c_lreg+2,x
 689  0255 ae0000        	ldw	x,#0
 690  0258 bf00          	ldw	c_lreg,x
 693  025a 81            	ret
 694  025b               L551:
 695                     ; 68 				case 'q': return SEG_A|SEG_B|SEG_C|SEG_F|SEG_G1|SEG_G2;
 697  025b ae00e7        	ldw	x,#231
 698  025e bf02          	ldw	c_lreg+2,x
 699  0260 ae0000        	ldw	x,#0
 700  0263 bf00          	ldw	c_lreg,x
 703  0265 81            	ret
 704  0266               L751:
 705                     ; 69 				case 'r': return SEG_E|SEG_G1|SEG_G2;
 707  0266 ae00d0        	ldw	x,#208
 708  0269 bf02          	ldw	c_lreg+2,x
 709  026b ae0000        	ldw	x,#0
 710  026e bf00          	ldw	c_lreg,x
 713  0270 81            	ret
 714  0271               L161:
 715                     ; 70 				case 's': return SEG_A|SEG_C|SEG_D|SEG_F|SEG_G1|SEG_G2;
 717  0271 ae00ed        	ldw	x,#237
 718  0274 bf02          	ldw	c_lreg+2,x
 719  0276 ae0000        	ldw	x,#0
 720  0279 bf00          	ldw	c_lreg,x
 723  027b 81            	ret
 724  027c               L361:
 725                     ; 71 				case 't': return SEG_D|SEG_E|SEG_F|SEG_G1|SEG_G2;
 727  027c ae00f8        	ldw	x,#248
 728  027f bf02          	ldw	c_lreg+2,x
 729  0281 ae0000        	ldw	x,#0
 730  0284 bf00          	ldw	c_lreg,x
 733  0286 81            	ret
 734  0287               L561:
 735                     ; 72 				case 'u': return SEG_C|SEG_D|SEG_E;
 737  0287 ae001c        	ldw	x,#28
 738  028a bf02          	ldw	c_lreg+2,x
 739  028c ae0000        	ldw	x,#0
 740  028f bf00          	ldw	c_lreg,x
 743  0291 81            	ret
 744  0292               L761:
 745                     ; 73 				case 'v': return SEG_E|SEG_K|SEG_M;
 747  0292 ae2810        	ldw	x,#10256
 748  0295 bf02          	ldw	c_lreg+2,x
 749  0297 ae0000        	ldw	x,#0
 750  029a bf00          	ldw	c_lreg,x
 753  029c 81            	ret
 754  029d               L171:
 755                     ; 74 				case 'w': return SEG_C|SEG_E|SEG_K|SEG_M;
 757  029d ae2814        	ldw	x,#10260
 758  02a0 bf02          	ldw	c_lreg+2,x
 759  02a2 ae0000        	ldw	x,#0
 760  02a5 bf00          	ldw	c_lreg,x
 763  02a7 81            	ret
 764  02a8               L371:
 765                     ; 75 				case 'x': return SEG_H|SEG_J|SEG_K|SEG_M;
 767  02a8 ae2d00        	ldw	x,#11520
 768  02ab bf02          	ldw	c_lreg+2,x
 769  02ad ae0000        	ldw	x,#0
 770  02b0 bf00          	ldw	c_lreg,x
 773  02b2 81            	ret
 774  02b3               L571:
 775                     ; 76 				case 'y': return SEG_B|SEG_C|SEG_D|SEG_F|SEG_G1|SEG_G2;
 777  02b3 ae00ee        	ldw	x,#238
 778  02b6 bf02          	ldw	c_lreg+2,x
 779  02b8 ae0000        	ldw	x,#0
 780  02bb bf00          	ldw	c_lreg,x
 783  02bd 81            	ret
 784  02be               L771:
 785                     ; 77 				case 'z': return SEG_A|SEG_D|SEG_J|SEG_K;
 787  02be ae0c09        	ldw	x,#3081
 788  02c1 bf02          	ldw	c_lreg+2,x
 789  02c3 ae0000        	ldw	x,#0
 790  02c6 bf00          	ldw	c_lreg,x
 793  02c8 81            	ret
 794  02c9               L102:
 795                     ; 79         case ' ': return 0;
 797  02c9 ae0000        	ldw	x,#0
 798  02cc bf02          	ldw	c_lreg+2,x
 799  02ce ae0000        	ldw	x,#0
 800  02d1 bf00          	ldw	c_lreg,x
 803  02d3 81            	ret
 804  02d4               L302:
 805                     ; 80         case '-': return SEG_G1 | SEG_G2;
 807  02d4 ae00c0        	ldw	x,#192
 808  02d7 bf02          	ldw	c_lreg+2,x
 809  02d9 ae0000        	ldw	x,#0
 810  02dc bf00          	ldw	c_lreg,x
 813  02de 81            	ret
 814  02df               L502:
 815                     ; 81         case '_': return SEG_D;
 817  02df ae0008        	ldw	x,#8
 818  02e2 bf02          	ldw	c_lreg+2,x
 819  02e4 ae0000        	ldw	x,#0
 820  02e7 bf00          	ldw	c_lreg,x
 823  02e9 81            	ret
 824  02ea               L702:
 825                     ; 82         case '"': return SEG_H | SEG_J;
 827  02ea ae0500        	ldw	x,#1280
 828  02ed bf02          	ldw	c_lreg+2,x
 829  02ef ae0000        	ldw	x,#0
 830  02f2 bf00          	ldw	c_lreg,x
 833  02f4 81            	ret
 834  02f5               L112:
 835                     ; 83         case '\'': return SEG_H | SEG_M;
 837  02f5 ae2100        	ldw	x,#8448
 838  02f8 bf02          	ldw	c_lreg+2,x
 839  02fa ae0000        	ldw	x,#0
 840  02fd bf00          	ldw	c_lreg,x
 843  02ff 81            	ret
 844  0300               L312:
 845                     ; 84         case '+': return SEG_G1 | SEG_G2 | SEG_I | SEG_L;
 847  0300 ae12c0        	ldw	x,#4800
 848  0303 bf02          	ldw	c_lreg+2,x
 849  0305 ae0000        	ldw	x,#0
 850  0308 bf00          	ldw	c_lreg,x
 853  030a 81            	ret
 854  030b               L512:
 855                     ; 85         case '*': return SEG_G1 | SEG_G2 | SEG_H | SEG_I | SEG_J | SEG_K | SEG_L | SEG_M;
 857  030b ae3fc0        	ldw	x,#16320
 858  030e bf02          	ldw	c_lreg+2,x
 859  0310 ae0000        	ldw	x,#0
 860  0313 bf00          	ldw	c_lreg,x
 863  0315 81            	ret
 864  0316               L712:
 865                     ; 86         case '/': return SEG_J | SEG_K;
 867  0316 ae0c00        	ldw	x,#3072
 868  0319 bf02          	ldw	c_lreg+2,x
 869  031b ae0000        	ldw	x,#0
 870  031e bf00          	ldw	c_lreg,x
 873  0320 81            	ret
 874  0321               L122:
 875                     ; 87 				case '.': return SEG_DP;//if avaiable
 877  0321 ae4000        	ldw	x,#16384
 878  0324 bf02          	ldw	c_lreg+2,x
 879  0326 ae0000        	ldw	x,#0
 880  0329 bf00          	ldw	c_lreg,x
 883  032b 81            	ret
 884  032c               L322:
 885                     ; 88         default: return 0;
 887  032c ae0000        	ldw	x,#0
 888  032f bf02          	ldw	c_lreg+2,x
 889  0331 ae0000        	ldw	x,#0
 890  0334 bf00          	ldw	c_lreg,x
 893  0336 81            	ret
 896                     	switch	.const
 897  00a8               L552_logical_to_physical:
 898  00a8 00            	dc.b	0
 899  00a9 04            	dc.b	4
 900  00aa 09            	dc.b	9
 901  00ab 0e            	dc.b	14
 902  00ac 0a            	dc.b	10
 903  00ad 05            	dc.b	5
 904  00ae 08            	dc.b	8
 905  00af 06            	dc.b	6
 906  00b0 03            	dc.b	3
 907  00b1 02            	dc.b	2
 908  00b2 01            	dc.b	1
 909  00b3 0d            	dc.b	13
 910  00b4 0c            	dc.b	12
 911  00b5 0b            	dc.b	11
 912  00b6 10            	dc.b	16
 913  00b7 00            	ds.b	1
 964                     ; 109 static uint32_t pt6311_remap(uint32_t logical) {
 965                     .text:	section	.text,new
 966  0000               L752_pt6311_remap:
 968  0000 5205          	subw	sp,#5
 969       00000005      OFST:	set	5
 972                     ; 110     uint32_t physical = 0;
 974  0002 ae0000        	ldw	x,#0
 975  0005 1f03          	ldw	(OFST-2,sp),x
 976  0007 ae0000        	ldw	x,#0
 977  000a 1f01          	ldw	(OFST-4,sp),x
 979                     ; 112     for (i = 0; i < 15; i++) {
 981  000c 0f05          	clr	(OFST+0,sp)
 983  000e               L703:
 984                     ; 113         if (logical & (1UL << i)) {
 986  000e ae0001        	ldw	x,#1
 987  0011 bf02          	ldw	c_lreg+2,x
 988  0013 ae0000        	ldw	x,#0
 989  0016 bf00          	ldw	c_lreg,x
 990  0018 7b05          	ld	a,(OFST+0,sp)
 991  001a cd0000        	call	c_llsh
 993  001d 96            	ldw	x,sp
 994  001e 1c0008        	addw	x,#OFST+3
 995  0021 cd0000        	call	c_land
 997  0024 cd0000        	call	c_lrzmp
 999  0027 271b          	jreq	L513
1000                     ; 114             physical |= (1UL << logical_to_physical[i]);
1002  0029 ae0001        	ldw	x,#1
1003  002c bf02          	ldw	c_lreg+2,x
1004  002e ae0000        	ldw	x,#0
1005  0031 bf00          	ldw	c_lreg,x
1006  0033 7b05          	ld	a,(OFST+0,sp)
1007  0035 5f            	clrw	x
1008  0036 97            	ld	xl,a
1009  0037 d600a8        	ld	a,(L552_logical_to_physical,x)
1010  003a cd0000        	call	c_llsh
1012  003d 96            	ldw	x,sp
1013  003e 1c0001        	addw	x,#OFST-4
1014  0041 cd0000        	call	c_lgor
1017  0044               L513:
1018                     ; 112     for (i = 0; i < 15; i++) {
1020  0044 0c05          	inc	(OFST+0,sp)
1024  0046 7b05          	ld	a,(OFST+0,sp)
1025  0048 a10f          	cp	a,#15
1026  004a 25c2          	jrult	L703
1027                     ; 117     return physical;
1029  004c 96            	ldw	x,sp
1030  004d 1c0001        	addw	x,#OFST-4
1031  0050 cd0000        	call	c_ltor
1035  0053 5b05          	addw	sp,#5
1036  0055 81            	ret
1059                     ; 120 void pt6311_setup_io(void)
1059                     ; 121 {
1060                     .text:	section	.text,new
1061  0000               _pt6311_setup_io:
1065                     ; 123 		PORT(PT6311_DIN_PORT, DDR) |= PT6311_DIN_PIN;
1067  0000 721a500c      	bset	20492,#5
1068                     ; 124 	  PORT(PT6311_DIN_PORT, CR1) |= PT6311_DIN_PIN;
1070  0004 721a500d      	bset	20493,#5
1071                     ; 125 		PORT(PT6311_DIN_PORT, CR2) |= PT6311_DIN_PIN;
1073  0008 721a500e      	bset	20494,#5
1074                     ; 127 		PORT(PT6311_CLK_PORT, DDR) |= PT6311_CLK_PIN;
1076  000c 721c500c      	bset	20492,#6
1077                     ; 128 		PORT(PT6311_CLK_PORT, CR1) |= PT6311_CLK_PIN;
1079  0010 721c500d      	bset	20493,#6
1080                     ; 129 	  PORT(PT6311_CLK_PORT, CR2) |= PT6311_CLK_PIN;
1082  0014 721c500e      	bset	20494,#6
1083                     ; 131 		PORT(PT6311_STB_PORT, DDR) |= PT6311_STB_PIN;
1085  0018 721e500c      	bset	20492,#7
1086                     ; 132 		PORT(PT6311_STB_PORT, CR1) |= PT6311_STB_PIN;
1088  001c 721e500d      	bset	20493,#7
1089                     ; 133 		PORT(PT6311_STB_PORT, CR2) |= PT6311_STB_PIN;
1091  0020 721e500e      	bset	20494,#7
1092                     ; 135     PT6311_DIN_HIGH();
1094  0024 721a500a      	bset	20490,#5
1095                     ; 136     PT6311_CLK_HIGH();
1098  0028 721c500a      	bset	20490,#6
1099                     ; 137     PT6311_STB_HIGH();
1102  002c 721e500a      	bset	20490,#7
1103                     ; 138 }
1107  0030 81            	ret
1131                     ; 140 static void pt6311_start(void)
1131                     ; 141 {
1132                     .text:	section	.text,new
1133  0000               L723_pt6311_start:
1137                     ; 142     PT6311_STB_LOW();
1139  0000 721f500a      	bres	20490,#7
1140                     ; 143     delay_us(10);        
1143  0004 ae000a        	ldw	x,#10
1144  0007 cd0000        	call	_delay_us
1146                     ; 144 }
1149  000a 81            	ret
1173                     ; 146 static void pt6311_stop(void)
1173                     ; 147 {
1174                     .text:	section	.text,new
1175  0000               L143_pt6311_stop:
1179                     ; 148     PT6311_STB_HIGH();
1181  0000 721e500a      	bset	20490,#7
1182                     ; 149     delay_us(10);
1185  0004 ae000a        	ldw	x,#10
1186  0007 cd0000        	call	_delay_us
1188                     ; 150 }
1191  000a 81            	ret
1235                     ; 152 static void pt6311_shift_out(uint8_t data)
1235                     ; 153 {
1236                     .text:	section	.text,new
1237  0000               L353_pt6311_shift_out:
1239  0000 88            	push	a
1240  0001 88            	push	a
1241       00000001      OFST:	set	1
1244                     ; 155     for (i = 0; i < 8; i++)
1246  0002 0f01          	clr	(OFST+0,sp)
1248  0004               L773:
1249                     ; 157         if (data & 0x01){
1251  0004 7b02          	ld	a,(OFST+1,sp)
1252  0006 a501          	bcp	a,#1
1253  0008 2706          	jreq	L504
1254                     ; 158             PT6311_DIN_HIGH();
1256  000a 721a500a      	bset	20490,#5
1259  000e 2004          	jra	L704
1260  0010               L504:
1261                     ; 161             PT6311_DIN_LOW();
1263  0010 721b500a      	bres	20490,#5
1264  0014               L704:
1265                     ; 163         PT6311_CLK_LOW();
1267  0014 721d500a      	bres	20490,#6
1268                     ; 164         delay_us(5);    
1271  0018 ae0005        	ldw	x,#5
1272  001b cd0000        	call	_delay_us
1274                     ; 165         PT6311_CLK_HIGH();
1276  001e 721c500a      	bset	20490,#6
1277                     ; 166         delay_us(5);
1280  0022 ae0005        	ldw	x,#5
1281  0025 cd0000        	call	_delay_us
1283                     ; 168         data >>= 1;
1285  0028 0402          	srl	(OFST+1,sp)
1286                     ; 155     for (i = 0; i < 8; i++)
1288  002a 0c01          	inc	(OFST+0,sp)
1292  002c 7b01          	ld	a,(OFST+0,sp)
1293  002e a108          	cp	a,#8
1294  0030 25d2          	jrult	L773
1295                     ; 170 }
1298  0032 85            	popw	x
1299  0033 81            	ret
1361                     ; 171 void pt6311_init(uint8_t num_digits)
1361                     ; 172 {
1362                     .text:	section	.text,new
1363  0000               _pt6311_init:
1365  0000 88            	push	a
1366  0001 88            	push	a
1367       00000001      OFST:	set	1
1370                     ; 174     if (num_digits < PT6311_MIN_DIGITS) num_digits = PT6311_MIN_DIGITS;
1372  0002 a104          	cp	a,#4
1373  0004 2404          	jruge	L164
1376  0006 a604          	ld	a,#4
1377  0008 6b02          	ld	(OFST+1,sp),a
1378  000a               L164:
1379                     ; 175     if (num_digits > PT6311_MAX_DIGITS) num_digits = PT6311_MAX_DIGITS;
1381  000a 7b02          	ld	a,(OFST+1,sp)
1382  000c a10d          	cp	a,#13
1383  000e 2504          	jrult	L364
1386  0010 a60c          	ld	a,#12
1387  0012 6b02          	ld	(OFST+1,sp),a
1388  0014               L364:
1389                     ; 176     pt6311_num_digits = num_digits;
1391  0014 7b02          	ld	a,(OFST+1,sp)
1392  0016 b700          	ld	_pt6311_num_digits,a
1393                     ; 177     pt6311_setup_io();
1395  0018 cd0000        	call	_pt6311_setup_io
1397                     ; 179     delay_ms(50);
1399  001b ae0032        	ldw	x,#50
1400  001e cd0000        	call	_delay_ms
1402                     ; 180     pt6311_start();
1404  0021 cd0000        	call	L723_pt6311_start
1406                     ; 181     pt6311_shift_out(PT6311_CMD2 | 0b00000000);
1408  0024 a640          	ld	a,#64
1409  0026 cd0000        	call	L353_pt6311_shift_out
1411                     ; 182     pt6311_stop();
1413  0029 cd0000        	call	L143_pt6311_stop
1415                     ; 184     pt6311_start();
1417  002c cd0000        	call	L723_pt6311_start
1419                     ; 185     pt6311_shift_out(PT6311_CMD3); 
1421  002f a6c0          	ld	a,#192
1422  0031 cd0000        	call	L353_pt6311_shift_out
1424                     ; 186     for (i = 0; i < (pt6311_num_digits * 3); i++) {
1426  0034 0f01          	clr	(OFST+0,sp)
1429  0036 2006          	jra	L174
1430  0038               L564:
1431                     ; 187     pt6311_shift_out(0x00);
1433  0038 4f            	clr	a
1434  0039 cd0000        	call	L353_pt6311_shift_out
1436                     ; 186     for (i = 0; i < (pt6311_num_digits * 3); i++) {
1438  003c 0c01          	inc	(OFST+0,sp)
1440  003e               L174:
1443  003e 9c            	rvf
1444  003f b600          	ld	a,_pt6311_num_digits
1445  0041 97            	ld	xl,a
1446  0042 a603          	ld	a,#3
1447  0044 42            	mul	x,a
1448  0045 7b01          	ld	a,(OFST+0,sp)
1449  0047 905f          	clrw	y
1450  0049 9097          	ld	yl,a
1451  004b 90bf00        	ldw	c_y,y
1452  004e b300          	cpw	x,c_y
1453  0050 2ce6          	jrsgt	L564
1454                     ; 189     pt6311_stop();
1456  0052 cd0000        	call	L143_pt6311_stop
1458                     ; 191     cmd1 = PT6311_CMD1;
1460  0055 0f01          	clr	(OFST+0,sp)
1462                     ; 205     switch(pt6311_num_digits) {
1464  0057 b600          	ld	a,_pt6311_num_digits
1466                     ; 214         default:  cmd1 |= PT6311_DIG4_SEG24;  break;
1467  0059 a005          	sub	a,#5
1468  005b 274f          	jreq	L724
1469  005d 4a            	dec	a
1470  005e 2744          	jreq	L524
1471  0060 4a            	dec	a
1472  0061 2739          	jreq	L324
1473  0063 4a            	dec	a
1474  0064 272e          	jreq	L124
1475  0066 4a            	dec	a
1476  0067 2723          	jreq	L714
1477  0069 4a            	dec	a
1478  006a 2718          	jreq	L514
1479  006c 4a            	dec	a
1480  006d 270d          	jreq	L314
1481  006f 4a            	dec	a
1482  0070 2702          	jreq	L114
1483  0072               L134:
1488  0072 203e          	jra	L774
1489  0074               L114:
1490                     ; 206         case 12:  cmd1 |= PT6311_DIG12_SEG16; break;
1492  0074 7b01          	ld	a,(OFST+0,sp)
1493  0076 aa08          	or	a,#8
1494  0078 6b01          	ld	(OFST+0,sp),a
1498  007a 2036          	jra	L774
1499  007c               L314:
1500                     ; 207         case 11:  cmd1 |= PT6311_DIG11_SEG17; break;
1502  007c 7b01          	ld	a,(OFST+0,sp)
1503  007e aa07          	or	a,#7
1504  0080 6b01          	ld	(OFST+0,sp),a
1508  0082 202e          	jra	L774
1509  0084               L514:
1510                     ; 208         case 10:  cmd1 |= PT6311_DIG10_SEG18; break;
1512  0084 7b01          	ld	a,(OFST+0,sp)
1513  0086 aa06          	or	a,#6
1514  0088 6b01          	ld	(OFST+0,sp),a
1518  008a 2026          	jra	L774
1519  008c               L714:
1520                     ; 209         case 9:   cmd1 |= PT6311_DIG9_SEG19;  break;
1522  008c 7b01          	ld	a,(OFST+0,sp)
1523  008e aa05          	or	a,#5
1524  0090 6b01          	ld	(OFST+0,sp),a
1528  0092 201e          	jra	L774
1529  0094               L124:
1530                     ; 210         case 8:   cmd1 |= PT6311_DIG8_SEG20;  break;
1532  0094 7b01          	ld	a,(OFST+0,sp)
1533  0096 aa04          	or	a,#4
1534  0098 6b01          	ld	(OFST+0,sp),a
1538  009a 2016          	jra	L774
1539  009c               L324:
1540                     ; 211         case 7:   cmd1 |= PT6311_DIG7_SEG21;  break;
1542  009c 7b01          	ld	a,(OFST+0,sp)
1543  009e aa03          	or	a,#3
1544  00a0 6b01          	ld	(OFST+0,sp),a
1548  00a2 200e          	jra	L774
1549  00a4               L524:
1550                     ; 212         case 6:   cmd1 |= PT6311_DIG6_SEG22;  break;
1552  00a4 7b01          	ld	a,(OFST+0,sp)
1553  00a6 aa02          	or	a,#2
1554  00a8 6b01          	ld	(OFST+0,sp),a
1558  00aa 2006          	jra	L774
1559  00ac               L724:
1560                     ; 213         case 5:   cmd1 |= PT6311_DIG5_SEG23;  break;
1562  00ac 7b01          	ld	a,(OFST+0,sp)
1563  00ae aa01          	or	a,#1
1564  00b0 6b01          	ld	(OFST+0,sp),a
1568  00b2               L774:
1569                     ; 217     pt6311_start();
1571  00b2 cd0000        	call	L723_pt6311_start
1573                     ; 218     pt6311_shift_out(cmd1);
1575  00b5 7b01          	ld	a,(OFST+0,sp)
1576  00b7 cd0000        	call	L353_pt6311_shift_out
1578                     ; 219     pt6311_stop();
1580  00ba cd0000        	call	L143_pt6311_stop
1582                     ; 221     pt6311_set_display_state(set_state);
1584  00bd b601          	ld	a,_set_state
1585  00bf cd0000        	call	_pt6311_set_display_state
1587                     ; 222     pt6311_set_brightness(set_brightness);
1589  00c2 b600          	ld	a,_set_brightness
1590  00c4 cd0000        	call	_pt6311_set_brightness
1592                     ; 223 }
1595  00c7 85            	popw	x
1596  00c8 81            	ret
1707                     ; 225 void pt6311_set_brightness(pt6311_brightness_t brightness)
1707                     ; 226 {
1708                     .text:	section	.text,new
1709  0000               _pt6311_set_brightness:
1713                     ; 227     set_brightness = brightness;
1715  0000 b700          	ld	_set_brightness,a
1716                     ; 229     pt6311_start();
1718  0002 cd0000        	call	L723_pt6311_start
1720                     ; 230     pt6311_shift_out(PT6311_CMD4 | set_state | set_brightness);
1722  0005 b601          	ld	a,_set_state
1723  0007 aa80          	or	a,#128
1724  0009 ba00          	or	a,_set_brightness
1725  000b cd0000        	call	L353_pt6311_shift_out
1727                     ; 231     pt6311_stop();
1729  000e cd0000        	call	L143_pt6311_stop
1731                     ; 232 }
1734  0011 81            	ret
1795                     ; 234 void pt6311_set_display_state(pt6311_display_state_t state)
1795                     ; 235 {
1796                     .text:	section	.text,new
1797  0000               _pt6311_set_display_state:
1801                     ; 236     set_state = state;
1803  0000 b701          	ld	_set_state,a
1804                     ; 238     pt6311_start();
1806  0002 cd0000        	call	L723_pt6311_start
1808                     ; 239     pt6311_shift_out(PT6311_CMD4 | set_state | set_brightness);
1810  0005 b601          	ld	a,_set_state
1811  0007 aa80          	or	a,#128
1812  0009 ba00          	or	a,_set_brightness
1813  000b cd0000        	call	L353_pt6311_shift_out
1815                     ; 240     pt6311_stop();
1817  000e cd0000        	call	L143_pt6311_stop
1819                     ; 241 }
1822  0011 81            	ret
1856                     ; 246 static uint32_t pt6311_overlay(uint8_t digit)
1856                     ; 247 {
1857                     .text:	section	.text,new
1858  0000               L175_pt6311_overlay:
1860  0000 88            	push	a
1861       00000000      OFST:	set	0
1864                     ; 248     if (digit == 5)
1866  0001 a105          	cp	a,#5
1867  0003 260c          	jrne	L116
1868                     ; 249         return AUDIO_TEXT_MASK;
1870  0005 ae0000        	ldw	x,#0
1871  0008 bf02          	ldw	c_lreg+2,x
1872  000a ae0001        	ldw	x,#1
1873  000d bf00          	ldw	c_lreg,x
1876  000f 84            	pop	a
1877  0010 81            	ret
1878  0011               L116:
1879                     ; 251     if (digit == 6)
1881  0011 7b01          	ld	a,(OFST+1,sp)
1882  0013 a106          	cp	a,#6
1883  0015 260c          	jrne	L316
1884                     ; 252         return VIDEO_TEXT_MASK;
1886  0017 ae0000        	ldw	x,#0
1887  001a bf02          	ldw	c_lreg+2,x
1888  001c ae0001        	ldw	x,#1
1889  001f bf00          	ldw	c_lreg,x
1892  0021 84            	pop	a
1893  0022 81            	ret
1894  0023               L316:
1895                     ; 254     return 0;
1897  0023 ae0000        	ldw	x,#0
1898  0026 bf02          	ldw	c_lreg+2,x
1899  0028 ae0000        	ldw	x,#0
1900  002b bf00          	ldw	c_lreg,x
1903  002d 84            	pop	a
1904  002e 81            	ret
1961                     ; 257 void pt6311_write_digit(uint8_t digit, uint32_t segments)
1961                     ; 258 {
1962                     .text:	section	.text,new
1963  0000               _pt6311_write_digit:
1965  0000 88            	push	a
1966  0001 88            	push	a
1967       00000001      OFST:	set	1
1970                     ; 261     segments |= pt6311_overlay(digit);
1972  0002 cd0000        	call	L175_pt6311_overlay
1974  0005 96            	ldw	x,sp
1975  0006 1c0005        	addw	x,#OFST+4
1976  0009 cd0000        	call	c_lgor
1978                     ; 263     physical_pos = pt6311_num_digits - 1 - digit;
1980  000c b600          	ld	a,_pt6311_num_digits
1981  000e 4a            	dec	a
1982  000f 1002          	sub	a,(OFST+1,sp)
1983  0011 6b01          	ld	(OFST+0,sp),a
1985                     ; 265     pt6311_start();
1987  0013 cd0000        	call	L723_pt6311_start
1989                     ; 266     pt6311_shift_out(PT6311_CMD3 | (physical_pos * 3u));
1991  0016 7b01          	ld	a,(OFST+0,sp)
1992  0018 97            	ld	xl,a
1993  0019 a603          	ld	a,#3
1994  001b 42            	mul	x,a
1995  001c 9f            	ld	a,xl
1996  001d aac0          	or	a,#192
1997  001f cd0000        	call	L353_pt6311_shift_out
1999                     ; 267     pt6311_shift_out((uint8_t)segments);
2001  0022 7b08          	ld	a,(OFST+7,sp)
2002  0024 cd0000        	call	L353_pt6311_shift_out
2004                     ; 268     pt6311_shift_out((uint8_t)(segments >> 8));
2006  0027 7b07          	ld	a,(OFST+6,sp)
2007  0029 cd0000        	call	L353_pt6311_shift_out
2009                     ; 269     pt6311_shift_out((uint8_t)(segments >> 16));
2011  002c 7b06          	ld	a,(OFST+5,sp)
2012  002e cd0000        	call	L353_pt6311_shift_out
2014                     ; 270     pt6311_stop();
2016  0031 cd0000        	call	L143_pt6311_stop
2018                     ; 271 }
2021  0034 85            	popw	x
2022  0035 81            	ret
2086                     ; 273 void pt6311_write_char(uint8_t digit_pos, char chr)
2086                     ; 274 {
2087                     .text:	section	.text,new
2088  0000               _pt6311_write_char:
2090  0000 89            	pushw	x
2091  0001 5204          	subw	sp,#4
2092       00000004      OFST:	set	4
2095                     ; 275     uint32_t logical = pt6311_font(chr);
2097  0003 9f            	ld	a,xl
2098  0004 cd0000        	call	L3_pt6311_font
2100  0007 96            	ldw	x,sp
2101  0008 1c0001        	addw	x,#OFST-3
2102  000b cd0000        	call	c_rtol
2105                     ; 276     uint32_t physical = pt6311_remap(logical);
2107  000e 1e03          	ldw	x,(OFST-1,sp)
2108  0010 89            	pushw	x
2109  0011 1e03          	ldw	x,(OFST-1,sp)
2110  0013 89            	pushw	x
2111  0014 cd0000        	call	L752_pt6311_remap
2113  0017 5b04          	addw	sp,#4
2114  0019 96            	ldw	x,sp
2115  001a 1c0001        	addw	x,#OFST-3
2116  001d cd0000        	call	c_rtol
2119                     ; 277     pt6311_write_digit(digit_pos, physical);
2121  0020 1e03          	ldw	x,(OFST-1,sp)
2122  0022 89            	pushw	x
2123  0023 1e03          	ldw	x,(OFST-1,sp)
2124  0025 89            	pushw	x
2125  0026 7b09          	ld	a,(OFST+5,sp)
2126  0028 cd0000        	call	_pt6311_write_digit
2128  002b 5b04          	addw	sp,#4
2129                     ; 278 }
2132  002d 5b06          	addw	sp,#6
2133  002f 81            	ret
2208                     ; 280 void pt6311_write_char_dot(uint8_t digit_pos, char chr, bool dot) {
2209                     .text:	section	.text,new
2210  0000               _pt6311_write_char_dot:
2212  0000 89            	pushw	x
2213  0001 5204          	subw	sp,#4
2214       00000004      OFST:	set	4
2217                     ; 282 		uint32_t logical = pt6311_font(chr);
2219  0003 9f            	ld	a,xl
2220  0004 cd0000        	call	L3_pt6311_font
2222  0007 96            	ldw	x,sp
2223  0008 1c0001        	addw	x,#OFST-3
2224  000b cd0000        	call	c_rtol
2227                     ; 283     if (dot) {
2229  000e 7b09          	ld	a,(OFST+5,sp)
2230  0010 a501          	bcp	a,#1
2231  0012 2706          	jreq	L337
2232                     ; 284         logical |= SEG_DP;
2234  0014 7b03          	ld	a,(OFST-1,sp)
2235  0016 aa40          	or	a,#64
2236  0018 6b03          	ld	(OFST-1,sp),a
2238  001a               L337:
2239                     ; 286     physical = pt6311_remap(logical);
2241  001a 1e03          	ldw	x,(OFST-1,sp)
2242  001c 89            	pushw	x
2243  001d 1e03          	ldw	x,(OFST-1,sp)
2244  001f 89            	pushw	x
2245  0020 cd0000        	call	L752_pt6311_remap
2247  0023 5b04          	addw	sp,#4
2248  0025 96            	ldw	x,sp
2249  0026 1c0001        	addw	x,#OFST-3
2250  0029 cd0000        	call	c_rtol
2253                     ; 287     pt6311_write_digit(digit_pos, physical);
2255  002c 1e03          	ldw	x,(OFST-1,sp)
2256  002e 89            	pushw	x
2257  002f 1e03          	ldw	x,(OFST-1,sp)
2258  0031 89            	pushw	x
2259  0032 7b09          	ld	a,(OFST+5,sp)
2260  0034 cd0000        	call	_pt6311_write_digit
2262  0037 5b04          	addw	sp,#4
2263                     ; 288 }
2266  0039 5b06          	addw	sp,#6
2267  003b 81            	ret
2314                     ; 290 void pt6311_write_string(uint8_t digit_pos,const char *str)
2314                     ; 291 {
2315                     .text:	section	.text,new
2316  0000               _pt6311_write_string:
2318  0000 88            	push	a
2319       00000000      OFST:	set	0
2322  0001 2013          	jra	L167
2323  0003               L757:
2324                     ; 294         pt6311_write_char(digit_pos, *str);
2326  0003 1e04          	ldw	x,(OFST+4,sp)
2327  0005 f6            	ld	a,(x)
2328  0006 97            	ld	xl,a
2329  0007 7b01          	ld	a,(OFST+1,sp)
2330  0009 95            	ld	xh,a
2331  000a cd0000        	call	_pt6311_write_char
2333                     ; 295         str++;
2335  000d 1e04          	ldw	x,(OFST+4,sp)
2336  000f 1c0001        	addw	x,#1
2337  0012 1f04          	ldw	(OFST+4,sp),x
2338                     ; 296         digit_pos++;
2340  0014 0c01          	inc	(OFST+1,sp)
2341  0016               L167:
2342                     ; 292     while (*str && digit_pos < pt6311_num_digits)
2344  0016 1e04          	ldw	x,(OFST+4,sp)
2345  0018 7d            	tnz	(x)
2346  0019 2706          	jreq	L567
2348  001b 7b01          	ld	a,(OFST+1,sp)
2349  001d b100          	cp	a,_pt6311_num_digits
2350  001f 25e2          	jrult	L757
2351  0021               L567:
2352                     ; 298 }
2355  0021 84            	pop	a
2356  0022 81            	ret
2411                     ; 300 void pt6311_clock_format(uint8_t digit_pos, uint8_t value,bool colon)
2411                     ; 301 {
2412                     .text:	section	.text,new
2413  0000               _pt6311_clock_format:
2415  0000 89            	pushw	x
2416       00000000      OFST:	set	0
2419                     ; 302     pt6311_write_char_dot(digit_pos,(value / 10) + '0',colon);		
2421  0001 7b05          	ld	a,(OFST+5,sp)
2422  0003 a401          	and	a,#1
2423  0005 88            	push	a
2424  0006 9f            	ld	a,xl
2425  0007 5f            	clrw	x
2426  0008 97            	ld	xl,a
2427  0009 a60a          	ld	a,#10
2428  000b 62            	div	x,a
2429  000c 9f            	ld	a,xl
2430  000d ab30          	add	a,#48
2431  000f 97            	ld	xl,a
2432  0010 7b02          	ld	a,(OFST+2,sp)
2433  0012 95            	ld	xh,a
2434  0013 cd0000        	call	_pt6311_write_char_dot
2436  0016 84            	pop	a
2437                     ; 303     pt6311_write_char_dot(digit_pos + 1,(value % 10) + '0',colon);
2439  0017 7b05          	ld	a,(OFST+5,sp)
2440  0019 a401          	and	a,#1
2441  001b 88            	push	a
2442  001c 7b03          	ld	a,(OFST+3,sp)
2443  001e 5f            	clrw	x
2444  001f 97            	ld	xl,a
2445  0020 a60a          	ld	a,#10
2446  0022 62            	div	x,a
2447  0023 5f            	clrw	x
2448  0024 97            	ld	xl,a
2449  0025 9f            	ld	a,xl
2450  0026 ab30          	add	a,#48
2451  0028 97            	ld	xl,a
2452  0029 7b02          	ld	a,(OFST+2,sp)
2453  002b 4c            	inc	a
2454  002c 95            	ld	xh,a
2455  002d cd0000        	call	_pt6311_write_char_dot
2457  0030 84            	pop	a
2458                     ; 304 }
2461  0031 85            	popw	x
2462  0032 81            	ret
2526                     ; 306 void pt6311_write_int(uint8_t digit_pos,int value)
2526                     ; 307 {
2527                     .text:	section	.text,new
2528  0000               _pt6311_write_int:
2530  0000 88            	push	a
2531  0001 520b          	subw	sp,#11
2532       0000000b      OFST:	set	11
2535                     ; 309     uint8_t i = 0;
2537  0003 0f0b          	clr	(OFST+0,sp)
2539                     ; 311     if (value < 0)
2541  0005 9c            	rvf
2542  0006 1e0f          	ldw	x,(OFST+4,sp)
2543  0008 2e3e          	jrsge	L3501
2544                     ; 313         pt6311_write_char(digit_pos, '-');
2546  000a ae002d        	ldw	x,#45
2547  000d 95            	ld	xh,a
2548  000e cd0000        	call	_pt6311_write_char
2550                     ; 314         value = -value;
2552  0011 1e0f          	ldw	x,(OFST+4,sp)
2553  0013 50            	negw	x
2554  0014 1f0f          	ldw	(OFST+4,sp),x
2555                     ; 315         digit_pos++;
2557  0016 0c0c          	inc	(OFST+1,sp)
2558  0018 202e          	jra	L3501
2559  001a               L1501:
2560                     ; 320         buf[i++] = (value % 10) + '0';
2562  001a 1e0f          	ldw	x,(OFST+4,sp)
2563  001c a60a          	ld	a,#10
2564  001e cd0000        	call	c_smodx
2566  0021 1c0030        	addw	x,#48
2567  0024 9096          	ldw	y,sp
2568  0026 72a90003      	addw	y,#OFST-8
2569  002a 1701          	ldw	(OFST-10,sp),y
2571  002c 7b0b          	ld	a,(OFST+0,sp)
2572  002e 9097          	ld	yl,a
2573  0030 0c0b          	inc	(OFST+0,sp)
2575  0032 909f          	ld	a,yl
2576  0034 905f          	clrw	y
2577  0036 9097          	ld	yl,a
2578  0038 72f901        	addw	y,(OFST-10,sp)
2579  003b 01            	rrwa	x,a
2580  003c 90f7          	ld	(y),a
2581  003e 02            	rlwa	x,a
2582                     ; 321         value /= 10;
2584  003f 1e0f          	ldw	x,(OFST+4,sp)
2585  0041 a60a          	ld	a,#10
2586  0043 cd0000        	call	c_sdivx
2588  0046 1f0f          	ldw	(OFST+4,sp),x
2589  0048               L3501:
2590                     ; 318     while (value > 0 && i < sizeof(buf))
2592  0048 9c            	rvf
2593  0049 1e0f          	ldw	x,(OFST+4,sp)
2594  004b 2d21          	jrsle	L3601
2596  004d 7b0b          	ld	a,(OFST+0,sp)
2597  004f a108          	cp	a,#8
2598  0051 25c7          	jrult	L1501
2599  0053 2019          	jra	L3601
2600  0055               L1601:
2601                     ; 326         pt6311_write_char(digit_pos++, buf[--i]);
2603  0055 96            	ldw	x,sp
2604  0056 1c0003        	addw	x,#OFST-8
2605  0059 1f01          	ldw	(OFST-10,sp),x
2607  005b 0a0b          	dec	(OFST+0,sp)
2609  005d 7b0b          	ld	a,(OFST+0,sp)
2610  005f 5f            	clrw	x
2611  0060 97            	ld	xl,a
2612  0061 72fb01        	addw	x,(OFST-10,sp)
2613  0064 f6            	ld	a,(x)
2614  0065 97            	ld	xl,a
2615  0066 7b0c          	ld	a,(OFST+1,sp)
2616  0068 0c0c          	inc	(OFST+1,sp)
2617  006a 95            	ld	xh,a
2618  006b cd0000        	call	_pt6311_write_char
2620  006e               L3601:
2621                     ; 324     while (i > 0 && digit_pos < pt6311_num_digits)
2623  006e 0d0b          	tnz	(OFST+0,sp)
2624  0070 2706          	jreq	L7601
2626  0072 7b0c          	ld	a,(OFST+1,sp)
2627  0074 b100          	cp	a,_pt6311_num_digits
2628  0076 25dd          	jrult	L1601
2629  0078               L7601:
2630                     ; 328 }
2633  0078 5b0c          	addw	sp,#12
2634  007a 81            	ret
2671                     ; 329 void pt6311_clear_display(void) {
2672                     .text:	section	.text,new
2673  0000               _pt6311_clear_display:
2675  0000 88            	push	a
2676       00000001      OFST:	set	1
2679                     ; 331     for (i = 0; i < pt6311_num_digits; i++) {
2681  0001 0f01          	clr	(OFST+0,sp)
2684  0003 2011          	jra	L3111
2685  0005               L7011:
2686                     ; 332         pt6311_write_digit(i, 0);
2688  0005 ae0000        	ldw	x,#0
2689  0008 89            	pushw	x
2690  0009 ae0000        	ldw	x,#0
2691  000c 89            	pushw	x
2692  000d 7b05          	ld	a,(OFST+4,sp)
2693  000f cd0000        	call	_pt6311_write_digit
2695  0012 5b04          	addw	sp,#4
2696                     ; 331     for (i = 0; i < pt6311_num_digits; i++) {
2698  0014 0c01          	inc	(OFST+0,sp)
2700  0016               L3111:
2703  0016 7b01          	ld	a,(OFST+0,sp)
2704  0018 b100          	cp	a,_pt6311_num_digits
2705  001a 25e9          	jrult	L7011
2706                     ; 334 }
2709  001c 84            	pop	a
2710  001d 81            	ret
2765                     ; 338 void pt6311_test_digit_positions(uint8_t num_digits, uint16_t delay_per_digit_ms)
2765                     ; 339 {
2766                     .text:	section	.text,new
2767  0000               _pt6311_test_digit_positions:
2769  0000 88            	push	a
2770  0001 88            	push	a
2771       00000001      OFST:	set	1
2774                     ; 342     for (pos = 1; pos < num_digits+1; pos++)
2776  0002 a601          	ld	a,#1
2777  0004 6b01          	ld	(OFST+0,sp),a
2780  0006 2025          	jra	L1511
2781  0008               L5411:
2782                     ; 344         pt6311_write_digit(pos, 0xFFFFFF); 
2784  0008 aeffff        	ldw	x,#65535
2785  000b 89            	pushw	x
2786  000c ae00ff        	ldw	x,#255
2787  000f 89            	pushw	x
2788  0010 7b05          	ld	a,(OFST+4,sp)
2789  0012 cd0000        	call	_pt6311_write_digit
2791  0015 5b04          	addw	sp,#4
2792                     ; 345         delay_ms(delay_per_digit_ms);
2794  0017 1e05          	ldw	x,(OFST+4,sp)
2795  0019 cd0000        	call	_delay_ms
2797                     ; 346         pt6311_write_digit(pos, 0x000000); 
2799  001c ae0000        	ldw	x,#0
2800  001f 89            	pushw	x
2801  0020 ae0000        	ldw	x,#0
2802  0023 89            	pushw	x
2803  0024 7b05          	ld	a,(OFST+4,sp)
2804  0026 cd0000        	call	_pt6311_write_digit
2806  0029 5b04          	addw	sp,#4
2807                     ; 342     for (pos = 1; pos < num_digits+1; pos++)
2809  002b 0c01          	inc	(OFST+0,sp)
2811  002d               L1511:
2814  002d 9c            	rvf
2815  002e 7b02          	ld	a,(OFST+1,sp)
2816  0030 5f            	clrw	x
2817  0031 97            	ld	xl,a
2818  0032 5c            	incw	x
2819  0033 7b01          	ld	a,(OFST+0,sp)
2820  0035 905f          	clrw	y
2821  0037 9097          	ld	yl,a
2822  0039 90bf00        	ldw	c_y,y
2823  003c b300          	cpw	x,c_y
2824  003e 2cc8          	jrsgt	L5411
2825                     ; 348 }
2828  0040 85            	popw	x
2829  0041 81            	ret
2885                     ; 351 void pt6311_test_segments(uint8_t digit_pos, uint16_t delay_per_segment_ms)
2885                     ; 352 {
2886                     .text:	section	.text,new
2887  0000               _pt6311_test_segments:
2889  0000 88            	push	a
2890  0001 88            	push	a
2891       00000001      OFST:	set	1
2894                     ; 355     for (bit = 0; bit < 24; bit++)
2896  0002 0f01          	clr	(OFST+0,sp)
2898  0004               L3021:
2899                     ; 357         pt6311_write_digit(digit_pos, (uint32_t)1 << bit);
2901  0004 ae0001        	ldw	x,#1
2902  0007 bf02          	ldw	c_lreg+2,x
2903  0009 ae0000        	ldw	x,#0
2904  000c bf00          	ldw	c_lreg,x
2905  000e 7b01          	ld	a,(OFST+0,sp)
2906  0010 cd0000        	call	c_llsh
2908  0013 be02          	ldw	x,c_lreg+2
2909  0015 89            	pushw	x
2910  0016 be00          	ldw	x,c_lreg
2911  0018 89            	pushw	x
2912  0019 7b06          	ld	a,(OFST+5,sp)
2913  001b cd0000        	call	_pt6311_write_digit
2915  001e 5b04          	addw	sp,#4
2916                     ; 358 				pt6311_write_digit(digit_pos+2, 0x005000);//blink random other for counting
2918  0020 ae5000        	ldw	x,#20480
2919  0023 89            	pushw	x
2920  0024 ae0000        	ldw	x,#0
2921  0027 89            	pushw	x
2922  0028 7b06          	ld	a,(OFST+5,sp)
2923  002a ab02          	add	a,#2
2924  002c cd0000        	call	_pt6311_write_digit
2926  002f 5b04          	addw	sp,#4
2927                     ; 359 				delay_ms(delay_per_segment_ms);
2929  0031 1e05          	ldw	x,(OFST+4,sp)
2930  0033 cd0000        	call	_delay_ms
2932                     ; 360         pt6311_write_digit(digit_pos, 0x000000);
2934  0036 ae0000        	ldw	x,#0
2935  0039 89            	pushw	x
2936  003a ae0000        	ldw	x,#0
2937  003d 89            	pushw	x
2938  003e 7b06          	ld	a,(OFST+5,sp)
2939  0040 cd0000        	call	_pt6311_write_digit
2941  0043 5b04          	addw	sp,#4
2942                     ; 361 				pt6311_write_digit(digit_pos+2, 0x000000);
2944  0045 ae0000        	ldw	x,#0
2945  0048 89            	pushw	x
2946  0049 ae0000        	ldw	x,#0
2947  004c 89            	pushw	x
2948  004d 7b06          	ld	a,(OFST+5,sp)
2949  004f ab02          	add	a,#2
2950  0051 cd0000        	call	_pt6311_write_digit
2952  0054 5b04          	addw	sp,#4
2953                     ; 362         delay_ms(150); 
2955  0056 ae0096        	ldw	x,#150
2956  0059 cd0000        	call	_delay_ms
2958                     ; 355     for (bit = 0; bit < 24; bit++)
2960  005c 0c01          	inc	(OFST+0,sp)
2964  005e 7b01          	ld	a,(OFST+0,sp)
2965  0060 a118          	cp	a,#24
2966  0062 25a0          	jrult	L3021
2967                     ; 364 }
2970  0064 85            	popw	x
2971  0065 81            	ret
3026                     	xdef	_set_state
3027                     	xdef	_set_brightness
3028                     	switch	.ubsct
3029  0000               _pt6311_num_digits:
3030  0000 00            	ds.b	1
3031                     	xdef	_pt6311_num_digits
3032                     	xdef	_pt6311_setup_io
3033                     	xdef	_pt6311_write_digit
3034                     	xdef	_pt6311_test_segments
3035                     	xdef	_pt6311_test_digit_positions
3036                     	xdef	_pt6311_clear_display
3037                     	xdef	_pt6311_write_int
3038                     	xdef	_pt6311_write_string
3039                     	xdef	_pt6311_clock_format
3040                     	xdef	_pt6311_write_char_dot
3041                     	xdef	_pt6311_write_char
3042                     	xdef	_pt6311_set_display_state
3043                     	xdef	_pt6311_set_brightness
3044                     	xdef	_pt6311_init
3045                     	xref	_delay_ms
3046                     	xref	_delay_us
3047                     	xref.b	c_lreg
3048                     	xref.b	c_x
3049                     	xref.b	c_y
3069                     	xref	c_sdivx
3070                     	xref	c_smodx
3071                     	xref	c_rtol
3072                     	xref	c_ltor
3073                     	xref	c_lgor
3074                     	xref	c_lrzmp
3075                     	xref	c_land
3076                     	xref	c_llsh
3077                     	end
