; -----------------------------------
; Routine d'affichage de points v 1.0
;------------------------------------
;
 move.l 4(sp),d0                      ; d0=Offset
 move.l 8(sp),a0                      ; a0=Ecran d'affichage
 lea coorx(pc),a1                     ; a1=adresse abscisses (x)
 lea coory(pc),a2                     ; a2=adresse ordonnees (y)
 lea motif(pc),a3                     ; a3=motifs des points
 move.l #37,d1                        ; d1=Nbre de points-1
loop:
 clr.l d2
 clr.l d3
 move.l a0,a4                         ; Sauvegarde de a0
 move.w (a1,d0),d2                    ; d2=abscisse du point (x)
 move.w (a2,d0),d3                    ; d3=ordonnee du point (y)
;---------------------------
; Affiche le point a l'ecran
;---------------------------
;
 move.l d2,d4                         ; x dans d4
 and.w #15,d4                         ; d4=decalage (modulo 16)
 lsl.w  #1,d4                         ; decalage*2
 lsr.w #1,d2                          ; x=(x/2)
 andi #$f8,d2                         ; and -8
 add.w d2,d3
 adda.l d3,a4                         ; a4=adresse affichage point
 move.w (a3,d4),d5                    ; motif du point
 or d5,(a4)                           ; motif or fond (couleur 1
                                      ; codee sur un seul plan)
;-----------------------
; Afficher point suivant
;-----------------------
;
 addq.w #2,d0
 dbra d1,loop
 rts
;----
 data
;----
motif:
 dc.w $8000,$4000,$2000,$1000,$0800,$0400,$0200,$0100
 dc.w $0080,$0040,$0020,$0010,$0008,$0004,$0002,$0001
coorx:
 ibytes "COORX.TAB"
coory:
 ibytes "COORY.TAB"
 end
 