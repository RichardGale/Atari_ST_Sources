IMPLEMENTATION MODULE AESObjects;
(*$L-, N+, Y+*)


(*  MEGAMAX MODULA 2 GEM-Library :  Die AES Objektfunktionen
 *
 *  Autor: Manuel Chakravarty           Erstellt :  05.11.87
 *
 *  Version   2.2     V#0020
 *)
 
(*  05.11.87    | �bernahme von 'GEMBase' und 'GEMExt'
 *  15.02.90    | Anpassung auf Compilerversion 4.0
 *  02.04.90    | Anpassung auf public arrays
 *  05.10.90    | Keine verdrehten SETs mehr
 *)


FROM    SYSTEM          IMPORT ASSEMBLER;

FROM    GrafBase        IMPORT Point, Rectangle;

FROM    GEMGlobals      IMPORT PtrObjTree, OStateSet, GemChar;
 
IMPORT  GEMShare;

(*$I GEMOPS.ICL *)
 
 
PROCEDURE DrawObject(tree:PtrObjTree;start,depth:CARDINAL;frame:Rectangle);

BEGIN
  ASSEMBLER
    MOVE.L      pubs,A0
    LEA         pubArrays.aINTIN+12(A0),A1
    MOVE.L      -(A3),-(A1)
    MOVE.L      -(A3),-(A1)
    MOVE.L      -(A3),-(A1)
    MOVE.L      -(A3),pubArrays.ADDRIN(A0)
    MOVE.W      #OBJC_DRAW,(A3)+
    JSR         aes_if
    JSR         testINTOUT0
  END;
END DrawObject;
        
PROCEDURE ChangeObjState (tree    : PtrObjTree;
                          index   : CARDINAL;
                          frame   : Rectangle;
                          newState: OStateSet;
                          redraw  : BOOLEAN);
                         
  BEGIN
    ASSEMBLER
        MOVE.L  pubs,A0
        LEA     pubArrays.aINTIN+16(A0),A1
        MOVE.W  -(A3),-(A1)
        MOVE.W  -(A3), -(A1)
        MOVE.L  -(A3),-(A1)
        MOVE.L  -(A3),-(A1)
        MOVE.W  -(A3),pubArrays.aINTIN(A0)
        MOVE.L  -(A3),pubArrays.ADDRIN(A0)
        MOVE.W  #OBJC_CHANGE,(A3)+
        JSR     aes_if
        JSR     testINTOUT0
    END;
  END ChangeObjState;

PROCEDURE FindObject(tree:PtrObjTree;start,depth:CARDINAL;spot:Point):CARDINAL;

BEGIN
  ASSEMBLER
    MOVE.L      pubs,A0
    MOVE.L      -(A3),pubArrays.aINTIN+4(A0)
    MOVE.L      -(A3),pubArrays.aINTIN(A0)
    MOVE.L      -(A3),pubArrays.ADDRIN(A0)
    MOVE.W      #OBJC_FIND,(A3)+
    JSR         aes_if
    MOVE.L      pubs,A0
    MOVE.W      pubArrays.aINTOUT(A0),(A3)+
  END;
END FindObject;

PROCEDURE ObjectOffset(tree:PtrObjTree;index:CARDINAL):Point;

BEGIN
  ASSEMBLER
    MOVE.L      pubs,A0
    MOVE.W      -(A3),pubArrays.aINTIN(A0)
    MOVE.L      -(A3),pubArrays.ADDRIN(A0)
    MOVE.W      #OBJC_OFFSET,(A3)+
    JSR         aes_if
    MOVE.L      pubs,A0
    MOVE.L      pubArrays.aINTOUT+2(A0),(A3)+
    JSR         testINTOUT0
  END;
END ObjectOffset;
        
PROCEDURE AddObject(tree:PtrObjTree;parent,child:CARDINAL);

BEGIN
  ASSEMBLER
    MOVE.L      pubs,A0
    MOVE.L      -(A3),pubArrays.aINTIN(A0)
    MOVE.L      -(A3),pubArrays.ADDRIN(A0)
    MOVE.W      #OBJC_ADD,(A3)+
    JSR         aes_if
    JSR         testINTOUT0
  END;
END AddObject;
        
PROCEDURE DeleteObject(tree:PtrObjTree;index:CARDINAL);

BEGIN
  ASSEMBLER
    MOVE.L      pubs,A0
    MOVE.W      -(A3),pubArrays.aINTIN(A0)
    MOVE.L      -(A3),pubArrays.ADDRIN(A0)
    MOVE.W      #OBJC_DELETE,(A3)+
    JSR         aes_if
    JSR         testINTOUT0
  END;
END DeleteObject;

PROCEDURE ObjectOrder(tree:PtrObjTree;index:CARDINAL;newPos:INTEGER);

BEGIN
  ASSEMBLER
    MOVE.L      pubs,A0
    MOVE.L      -(A3),pubArrays.aINTIN(A0)
    MOVE.L      -(A3),pubArrays.ADDRIN(A0)
    MOVE.W      #OBJC_ORDER,(A3)+
    JSR         aes_if
    JSR         testINTOUT0
  END;
END ObjectOrder;

PROCEDURE EditObjText(tree:PtrObjTree;index:CARDINAL;ch:GemChar;
                      VAR charPos:CARDINAL;edKind:EditObjMode);
BEGIN
  ASSEMBLER
    MOVE.L      pubs,A0
    LEA         pubArrays.aINTIN+8(A0),A1
    MOVE.W      -(A3),-(A1)
    MOVE.L      -(A3),A2
    MOVE.L      A2,-(A7)                ; Save VAR-Ptr
    MOVE.W      (A2),-(A1)
    MOVE.W      -(A3),-(A1)
    MOVE.W      -(A3),-(A1)
    MOVE.L      -(A3),pubArrays.ADDRIN(A0)
    MOVE.W      #OBJC_EDIT,(A3)+
    JSR         aes_if
    JSR         testINTOUT0
    MOVE.L      (A7)+,A2                ; Restrore VAR-Ptr
    TST.W       error
    BNE         cont
    MOVE.L      pubs,A0
    MOVE.W      pubArrays.aINTOUT+2(A0),(A2)    ; return new text index
cont
  END;
END EditObjText;
        
END AESObjects.  
(* $FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$00000868$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E$FFF8B65E�$000005C6T.......T.......T.......T.......T.......T.......T.......T.......T.......T.......$000001AA$FFEDD2D6$000005BD$000005C6$FFEDD2D6$00000030$000005B7$000005C6$00000F72$FFEC5560$00001052$00001071$000005B7$000005C6$0000017F$FFED8E07���*)
