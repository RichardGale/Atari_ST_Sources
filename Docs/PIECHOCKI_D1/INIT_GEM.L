
        TEXT


VDI      MACRO                      
         move.l   #vdipb,d1        
         move     #$73,d0          
         trap     #2               
         ENDM                       

AES      MACRO                      
         move.l    #aespb,d1        
         move      #$C8,D0          
         trap      #2                  
         ENDM                       

;        APPL_INIT 


         move.l    #0,ap1resv
         move.l    #0,ap2resv
         move.l    #0,ap3resv
         move.l    #0,ap4resv
         move.w    #10,opcode
         move.w    #0,sptsin
         move.w    #1,sptsout
         move.w    #0,sintin
         move.w    #0,sintout
         AES                       ;-->AES
  
;         GRAF_HANDLE 

          move.w    #77,opcode
          move.w    #0,sptsin
          move.w    #5,sptsout
          move.w    #0,sintin
          move.w    #0,sintout
          AES                      ;-->AES

          move.w    intout,grhandle     ;On sauvgarde le HANDLE


;         OPEN VIRTUAL SCREEN WORKSTATION 

          move.w    #100,opcode         
          move.w    #0,sptsin
          move.w    #11,sintin
          move.w    grhandle,handle     
          move.w    #1,intin            
          move.w    #1,intin+2
          move.w    #1,intin+4
          move.w    #1,intin+6
          move.w    #1,intin+8
          move.w    #1,intin+10
          move.w    #1,intin+12
          move.w    #1,intin+14
          move.w    #1,intin+16
          move.w    #1,intin+18
          move.w    #2,intin+20
          VDI                           ;-->VDI

          END


 