;
;
;
	include	macros.s
;
datlen	equ	16		aantal regels achtergrond data
linelen	equ	160
ll	equ	linelen
;
;
;
bgline	macro
	move.w	d0,(a0)
	move.w	d1,8(a0)
	move.w	d0,16(a0)
	move.w	d1,24(a0)
	move.w	d0,32(a0)
;
	move.w	d1,40(a0)
	move.w	d0,48(a0)
	move.w	d1,56(a0)
	move.w	d0,64(a0)
	move.w	d1,72(a0)
;
	move.w	d0,80(a0)
	move.w	d1,88(a0)
	move.w	d0,96(a0)
	move.w	d1,104(a0)
	move.w	d0,112(a0)
;
	move.w	d1,120(a0)
	move.w	d0,128(a0)
	move.w	d1,136(a0)
	move.w	d0,144(a0)
	move.w	d1,152(a0)
;
	endm
;
;
YEAH	macro
	not.w	col0
	endm
;
; ***************
;
; ***************
;	
	startup
	super	ssp
	move.l	#mystack,sp
	getphys
	move.l	d0,phys1	bewaar physbase
	getrez			haal rez
	move.w	d0,oldrez	sla rez op
	getpal	oldpal		haal en sla pallette op
	setrez	#0		resolutie = LORES
;
;	*****
bigloop
	YEAH
	move.l	curdist,a2		haal pointer in tabel met verschillende shift tabel pointers (distortion tabel)
	move.l	(a2)+,a1		haal pointer naar shift tabel
	cmp.l	#0,a1			vergelijk met 0
	bne.s	noredis			als <>0 niet opnieuw beginnen in tabel

	lea	distab,a2		haal BEGIN distortion tabel
	move.l	(a2)+,a1		haal EERSTE pointer naar shift tabel
noredis	move.l	a2,curdist		zet pointer in distortion tabel terug

	move.l	curhi,a4		haal pointer in tabel met pointers naar BG data
	move.l	(a4)+,a3		haal pointer naar BG data
	cmp.l	#0,a3			is dit het einde van de tabel
	bne.s	norehi			als niet -> begin NIET opnieuw

	move.l	#hitab,a4		haal BEGIN hi tabel
	move.l	(a4)+,a3		haal EERSTE pointer naar BG data
norehi	move.l	a4,curhi
	
	move.l	phys1,a0		haal Logbase
	move.l	#ll,a4
	moveq	#160/datlen-1,d7	aantal keer

patloop	moveq	#datlen-1,d6	zoveel regels
	move.l	a3,a2		beginadres achtergrond patroon
bgloop	move.l	(a2)+,d0	haal achtergrond
	move.w	(a1)+,d4	haal shift	
	ror.l	d4,d0		shift deel #1
	move.w	d0,d1		tweede helft naar d1
	swap	d0		eerste helft onderin
	bgline			zet lijn op beeld
	add.l	a4,a0		naar volgende regel
	dbra	d6,bgloop	nog een regel
	dbra	d7,patloop	volgende patroon
;
; ************
;
endput
	YEAH
	key			kijk of er een toets gedrukt wordt
	tst.w	d0
	bne.s	einde		zo ja -> einde scroll
	
	vsyncm			wacht op VBL
***	waitkey			***
	bra	bigloop
;
;
einde	setrez	oldrez
	setpal	oldpal

	user	ssp
	
	term
;
	section	DATA

curhi	dc.l	hitab

hitab
	dc.l	bgdata+0
*	dc.l	0
	dc.l	bgdata+8,bgdata+16,bgdata+24,bgdata+32,bgdata+36,bgdata+40,bgdata+44
	dc.l	bgdata+48,bgdata+52,bgdata+56,bgdata+56,bgdata+52,bgdata+48
	dc.l	bgdata+44,bgdata+40,bgdata+36,bgdata+32,bgdata+24,bgdata+16,bgdata+8,bgdata+0
	dc.l	0

bgdata
*	incbin	YO.MON
*	incbin	YO.MON
	incbin	CLOSEYO.MON
	incbin	CLOSEYO.MON
;
;
;
curdist	dc.l	distab

distab	dc.l	shiftab,shiftab+2,shiftab+4,shiftab+6,shiftab+8
	dc.l	shiftab+10,shiftab+12,shiftab+14,shiftab+16,shiftab+18
	dc.l	shiftab+20,shiftab+22,shiftab+24,shiftab+26,shiftab+28
	dc.l	shiftab+30,shiftab+32,shiftab+34,shiftab+36,shiftab+38
	dc.l	0

shiftab
	dc.w	4,5,6,7,8,8,8,7,6,5,4,3,2,1,0,0,0,1,2,3
	dc.w	4,5,6,7,8,8,8,7,6,5,4,3,2,1,0,0,0,1,2,3
	dc.w	4,5,6,7,8,8,8,7,6,5,4,3,2,1,0,0,0,1,2,3
	dc.w	4,5,6,7,8,8,8,7,6,5,4,3,2,1,0,0,0,1,2,3
	dc.w	4,5,6,7,8,8,8,7,6,5,4,3,2,1,0,0,0,1,2,3
	dc.w	4,5,6,7,8,8,8,7,6,5,4,3,2,1,0,0,0,1,2,3
	dc.w	4,5,6,7,8,8,8,7,6,5,4,3,2,1,0,0,0,1,2,3
	dc.w	4,5,6,7,8,8,8,7,6,5,4,3,2,1,0,0,0,1,2,3
	dc.w	4,5,6,7,8,8,8,7,6,5,4,3,2,1,0,0,0,1,2,3
	dc.w	4,5,6,7,8,8,8,7,6,5,4,3,2,1,0,0,0,1,2,3
;
;
	section	BSS

phys1	ds.l	1

oldrez	ds.w	1
oldpal	ds.w	16
ssp	ds.l	1

	ds.b	4096
mystack	ds.b	32
;
;
	end