DEFINITION MODULE Block;

(*
 *  Schnelle L�sch- und Kopierfunktionen f�r gro�e Datenbereiche (>50 Bytes).
 *
 *  Selbstverst�ndlich sind die Funktionen auch f. kleinere Bereiche (auch
 *  Null Bytes) geeignet, jedoch sind sie f�r gr��ere Bereiche optimiert.
 *  Auch sind ungerade Adressen und L�ngen erlaubt.
 *
 *  --------------------------------------------------------------------------
 *  Autoren: Wolfgang Keller   (W.K)
 *           Dieter   Hametner (D.H)
 *
 *  Erstellt: 23.08.89                  System: MEGAMAX Modula-2 V1.1
 *)

FROM SYSTEM IMPORT ADDRESS;

PROCEDURE Copy (from: ADDRESS; n: LONGCARD; to: ADDRESS);
        (*
         *  Kopiert von 'from' ab 'n' Bytes nach 'to'.
         *  Auf �berlappungen wird R�cksicht genommen.
         *)

PROCEDURE Clear (from: ADDRESS; n: LONGCARD);
        (*
         *  L�scht ab 'from' 'n' Bytes.
         *)

END Block.
