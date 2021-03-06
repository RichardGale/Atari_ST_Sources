IMPLEMENTATION MODULE MOSConfig;
(*$Y+,R-,M-*)

(*
 * Enth�lt globale Konfigurationswerte f�r die MOS-Moduln
 *
 * Hier keine Moduln importieren, f�r die die Konfigurationsdaten vorgesehen
 * sind! (z.B. 'Loader', 'Excepts', 'ErrBase', 'HdlError', 'GEMError')
 *)

FROM SysTypes IMPORT ExcSet, CHARSET, TRAP6, CHKExc, TRAPVExc, IllInstr,
                     BusError, AddrError, PrivViol;

BEGIN
  (* Die globalen Variablen sind anfangs alle gel�scht *)
  
  (* Default-Suffix f�r 'Load/CallModule' *)
  DftSfx:= 'MOD';
  (* Import-Suffix f�r 'Load/CallModule' *)
  ImpSfx:= 'IMP';
  
  (* max. Anzahl der gleichzeitig startbaren Module bei 'CallModule' *)
  MaxModExec:= 100;
  
  (* Abzufangende Exceptions: *)
  CaughtExceptions:= ExcSet{TRAP6,CHKExc,TRAPVExc,BusError,AddrError,IllInstr};
  (*    Die folgende Anweisung darf bei einer 68020 (z.B. Atari TT) nicht
        verwendet werden. Bei einem normalen 68000-Atari kann sie dagegen
        benutzt werden.
    INCL (CaughtExceptions,PrivViol);
  *)
  
  (* Zeichen zur Trennung der Vor- und Nachkommastellen bei REAL-Zahlen: *)
  RadixChar:='.';
  
  (* Schrankenwerte f�r Wahl der Fest- oder Flie�- *)
  (* kommadarstellung bei 'WriteReal', etc.:       *)
  FixToFloatMin:=1.0E-5;
  FixToFloatMax:=1.0E+6;
  
  (* Erwartungsform des Datums bei 'TimeConvert.TextToDate': *)
  StdDateExp:= 1;  (* 1: t-m-j, 2: m-t-j, 3: j-m-t, 4: j-t-m *)

  (* Ausgabeform des Datums bei 'TimeConvert.DateToText': *)
  StdDateMask:= 'DD.MM.YYYY';
  StdTimeMask:= 'HH:MM:SS';
  
  Separators:= CHARSET {0C..' '};
  
  MaxBlSize:= 0;  (* So ermittelt Storage selbst den optimalen Wert *)
  ExtendedMemoryAccess:= TRUE;
  
  CoroutineTrapNo:= 4; (* TRAP-Nr, die f�r Coroutinen belegt wird *)
END MOSConfig.
