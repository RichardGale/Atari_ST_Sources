IMPLEMENTATION MODULE NumberIO; (* V#026 *)
(*$Y+,L-,F-*)

(*
  18.7.87:  Read... �berlesen terminierendes Zeichen - kein UndoRead mehr.
  3.4.88:   Read... korrgiert (rdPrp hat f nur als Word statt Long geladen).
  17.9.88:  ReadNum/LNum korrigiert (las nix ein)
  28.9.88:  chrGet pr�ft EOF
  20.7.90:  ReadLReal neu
  26.9.90:  $L+ bei ReadReal
*)

FROM SYSTEM IMPORT ASSEMBLER, WORD, LONGWORD, ADDRESS;

FROM Files IMPORT File, EOF;

FROM Text IMPORT Read, WriteString;

FROM Convert IMPORT GetInfo;

IMPORT Convert;


PROCEDURE chrGet (VAR info: GetInfo);
  BEGIN
    ASSEMBLER
        ; Read ( File(info.userPtr), info.ch )
        MOVE.L  -(A3),A1
        MOVE.L  GetInfo.userPtr(A1),(A3)+
        LEA     GetInfo.ch(A1),A2
        JSR     EOF             ; A1/A2 werden nicht ver�ndert
        TST     -(A3)
        BNE     iseof
        MOVE.L  A0,(A3)+
        MOVE.L  A2,(A3)+
        JMP     Read
      iseof
        CLR.B   GetInfo.ch(A1)  ; Nullzeichen liefern bei EOF
    END
  END chrGet;


PROCEDURE rdPrp;
  BEGIN
    ASSEMBLER
        MOVE.L  (A7)+,A1
        LINK    A5,#-6
        MOVE.L  -12(A3),GetInfo.userPtr(A7)
        MOVE.L  -(A3),D0
        MOVE.L  #chrGet,(A3)+
        CLR.L   (A3)+
        MOVE.L  A7,(A3)+
        MOVE.L  D0,(A3)+
        JMP     (A1)
    END
  END rdPrp;

PROCEDURE rdPrpN;
  BEGIN
    ASSEMBLER
        MOVE.L  (A7)+,A1
        LINK    A5,#-6
        MOVE.L  -14(A3),GetInfo.userPtr(A7)
        MOVE.L  -(A3),D0
        MOVE.W  -(A3),D1
        MOVE.L  #chrGet,(A3)+
        CLR.L   (A3)+
        MOVE.L  A7,(A3)+
        MOVE.W  D1,(A3)+
        MOVE.L  D0,(A3)+
        JMP     (A1)
    END
  END rdPrpN;

PROCEDURE eWord;
  BEGIN
    ASSEMBLER
        MOVE.W  -(A3),D0
        MOVE.L  -(A3),A0
        MOVE.W  D0,(A0)
        SUBQ.L  #4,A3
        UNLK    A5
    END
  END eWord;

PROCEDURE eLong;
  BEGIN
    ASSEMBLER
        MOVE.L  -(A3),D0
        MOVE.L  -(A3),A0
        MOVE.L  D0,(A0)
        SUBQ.L  #4,A3
        UNLK    A5
    END
  END eLong;

PROCEDURE ReadCard (f: File; VAR card: CARDINAL; VAR success: BOOLEAN);
  BEGIN
    ASSEMBLER
        JSR     rdPrp
        JSR     Convert.ConvToCard
        JMP     eWord
    END
  END ReadCard;

PROCEDURE ReadInt (f: File; VAR int: INTEGER; VAR success: BOOLEAN);
  BEGIN
    ASSEMBLER
        JSR     rdPrp
        JSR     Convert.ConvToInt
        JMP     eWord
    END
  END ReadInt;

PROCEDURE ReadLCard (f: File; VAR card: LONGCARD; VAR success: BOOLEAN);
  BEGIN
    ASSEMBLER
        JSR     rdPrp
        JSR     Convert.ConvToLCard
        JMP     eLong
    END
  END ReadLCard;

PROCEDURE ReadLInt (f: File; VAR int: LONGINT; VAR success: BOOLEAN);
  BEGIN
    ASSEMBLER
        JSR     rdPrp
        JSR     Convert.ConvToLInt
        JMP     eLong
    END
  END ReadLInt;

PROCEDURE ReadNum (    f      : File;
                   VAR num    : WORD;
                       base   : CARDINAL; (* [2..36] *)
                   VAR success: BOOLEAN);
  BEGIN
    ASSEMBLER
        JSR     rdPrpN
        JSR     Convert.ConvToNum
        JMP     eWord
    END
  END ReadNum;

PROCEDURE ReadLNum (    f      : File;
                    VAR num    : LONGWORD;
                        base   : CARDINAL; (* [2..36] *)
                    VAR success: BOOLEAN);
  BEGIN
    ASSEMBLER
        JSR     rdPrpN
        JSR     Convert.ConvToLNum
        JMP     eLong
    END
  END ReadLNum;

PROCEDURE ReadLReal (f: File; VAR r: LONGREAL; VAR success: BOOLEAN);
  BEGIN
    ASSEMBLER
        JSR     rdPrp
        JSR     Convert.ConvToReal
        MOVE.L  -(A3),D1
        MOVE.L  -(A3),D0
        MOVE.L  -(A3),A0
        MOVE.L  D0,(A0)+
        MOVE.L  D1,(A0)
        SUBQ.L  #4,A3
        UNLK    A5
    END
  END ReadLReal;

PROCEDURE ReadReal (f: File; VAR r: REAL; VAR success: BOOLEAN);
  (*$L+*)
  VAR r2: LONGREAL;
  BEGIN
    r:= REAL (0);
    ReadLReal (f, r2, success);
    IF success THEN
      IF ABS (r2) > MAX (REAL) THEN
        success:= FALSE;
      ELSE
        r:= r2
      END
    END
  END ReadReal;
  (*$L=*)

PROCEDURE wrPrp;
  BEGIN
    ASSEMBLER
        MOVE.L  (A7)+,A1
        LINK    A5,#-80
        MOVE.L  A7,(A3)+
        MOVE.W  #79,(A3)+
        JMP     (A1)
    END
  END wrPrp;

PROCEDURE wrOut;
  BEGIN
    ASSEMBLER
        MOVE.L  A7,(A3)+
        MOVE.W  #79,(A3)+
        JSR     WriteString
        UNLK    A5
    END
  END wrOut;

PROCEDURE WriteCard (    f      : File;
                         card   : LONGCARD;
                         width  : CARDINAL);
  BEGIN
    ASSEMBLER
        JSR     wrPrp
        JSR     Convert.ConvCard
        JMP     wrOut
    END
  END WriteCard;

PROCEDURE WriteInt   (f: File; int : LONGINT;  width: CARDINAL);
  BEGIN
    ASSEMBLER
        JSR     wrPrp
        JSR     Convert.ConvInt
        JMP     wrOut
    END
  END WriteInt;
  
PROCEDURE WriteHex   (f: File; int : WORD;  width: CARDINAL);
  BEGIN
    ASSEMBLER
        JSR     wrPrp
        JSR     Convert.ConvHex
        JMP     wrOut
    END
  END WriteHex;
  
PROCEDURE WriteLHex  (f: File; int : LONGWORD;  width: CARDINAL);
  BEGIN
    ASSEMBLER
        JSR     wrPrp
        JSR     Convert.ConvLHex
        JMP     wrOut
    END
  END WriteLHex;

PROCEDURE WriteNum (f      : File;
                    num    : WORD;
                    base   : CARDINAL;  (* [2..26] *)
                    width  : CARDINAL;
                    filler : CHAR);
  BEGIN
    ASSEMBLER
        JSR     wrPrp
        JSR     Convert.ConvNum
        JMP     wrOut
    END
  END WriteNum;
  
PROCEDURE WriteLNum (f      : File;
                     num    : LONGWORD;
                     base   : CARDINAL; (* [2..36] *)
                     width  : CARDINAL;
                     filler : CHAR);
  BEGIN
    ASSEMBLER
        JSR     wrPrp
        JSR     Convert.ConvLNum
        JMP     wrOut
    END
  END WriteLNum;

PROCEDURE WriteFix   (f        : File;
                      real     : LONGREAL;
                      width    : CARDINAL;
                      decPlaces: CARDINAL);
  BEGIN
    ASSEMBLER
        JSR     wrPrp
        JSR     Convert.ConvFix
        JMP     wrOut
    END
  END WriteFix;

PROCEDURE WriteFloat (f        : File;
                      real     : LONGREAL;
                      width    : CARDINAL;
                      decPlaces: CARDINAL);
  BEGIN
    ASSEMBLER
        JSR     wrPrp
        JSR     Convert.ConvFloat
        JMP     wrOut
    END
  END WriteFloat;

PROCEDURE WriteEng   (f        : File;
                      real     : LONGREAL;
                      width    : CARDINAL;
                      decPlaces: CARDINAL);
  BEGIN
    ASSEMBLER
        JSR     wrPrp
        JSR     Convert.ConvEng
        JMP     wrOut
    END
  END WriteEng;

PROCEDURE WriteReal  (f        : File;
                      real     : LONGREAL;
                      width    : CARDINAL;
                      decPlaces: CARDINAL);
  BEGIN
    ASSEMBLER
        JSR     wrPrp
        JSR     Convert.ConvReal
        JMP     wrOut
    END
  END WriteReal;

END NumberIO.
 
(* $0000061B$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$00000C55$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$00000FCB$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA$FFFD5CDA�$000004E3T.......T.......T.......T.......T.......T.......T.......T.......T.......T.......$00000220$00000038$0000040D$0000062A$000004E3$000004EB$000004E3$00000651$00000FCB$00000F9F$0000108F$0000014A$0000015C$00000166$FFED427A$00000164���*)
