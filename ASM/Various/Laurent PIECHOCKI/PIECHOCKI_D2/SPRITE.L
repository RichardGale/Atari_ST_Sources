
               TEXT

               INCLUDE       "LINEQU.L"
               INCLUDE       "INIT_TOS.L"
               INCLUDE       "MACROS.L"

               SETBLOCK

               DC.W          $A000
               movea.l       a0,a5

               move.l        #CONTROL,ticontrol(a0)
               move.l        #INTIN,tiintin(a0)
               move.l        #PTSIN,tiptsin(a0)
               move.l        #INTOUT,tiintout(a0)
               move.l        #PTSOUT,tiptsout(a0)

               PRINTLINE     PIX
               WAIT
               DC.W          $A00A
               CCONOUT       #27
               CCONOUT       #'E'


               move          #0,_wrt_mode(a5)

               move.l        #BLOC,a0
               move.l        #SAUVE,a2

               move          #10,x

BBB            add           #1,x
               move          x,d0
               move          #100,d1
               move.l        #BLOC,a0
               cmpi          #620,d0
               beq           DEUX
               move.l        #SAUVE,a2
               DC.W          $A00C
               move.l        #BLOC,a0
               move.l        #SAUVE,a2
               DC.W          $A00D
               VSYNC
               jmp           BBB


DEUX           sub           #1,x
               move          x,d0
               move          #100,d1
               move.l        #BLOC,a0
               cmpi          #10,d0
               beq           FIN
               move.l        #SAUVE,a2
               DC.W          $A00C
               move.l        #BLOC,a0
               move.l        #SAUVE,a2
               DC.W          $A00D
               VSYNC
               jmp           DEUX



FIN            WAIT
               TERM


               DATA

BLOC           DC.W          0
               DC.W          0
               DC.W          0
               DC.W          0
               DC.W          1

               DC.W          0
               DC.W          %0000000000000000
               DC.W          0
               DC.W          %0000110110110000
               DC.W          0
               DC.W          %0000110110110000
               DC.W          0
               DC.W          %0000110110110000
               DC.W          0
               DC.W          %0001100110011000
               DC.W          0
               DC.W          %0011000110001100
               DC.W          0
               DC.W          %0011000110001100
               DC.W          0
               DC.W          %0110000110000110
               DC.W          0
               DC.W          %0110000110000110
               DC.W          0
               DC.W          %0000000000000000
               DC.W          0
               DC.W          %0011000001111100
               DC.W          0
               DC.W          %0011000001101100
               DC.W          0
               DC.W          %0011000001111000
               DC.W          0
               DC.W          %0011000001100000
               DC.W          0
               DC.W          %0011111001100000
               DC.W          0
               DC.W          %0000000000000000


PIX            DC.B          27,'E','Je vais faire bouger un SPRITE avec '
               DC.B          '$A00D',0

               BSS

X              DS.W          1

SAUVE          DS.B          128

               INCLUDE       "TABLEAU.L"

               END


 