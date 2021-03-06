DEFINITION MODULE AESMenus;


(*  Megamax-Modula 2 GEM-Library :  Die AES Men�funktionen
 *
 *  Autor: Manuel Chakravarty           Erstellt :  05.11.87
 *
 *  Version   2.2     V#0007
 *)
 
 
(*      Dieses Modul stellt die Routinen zur Verf�gung, die zum
 *      Arbeiten mit Menuzeilen n�tig sind. Darunter auch eine,
 *      die es einem Programm erlaubt, sich als Accessory anzumelden.
 *)
 
 
FROM GEMGlobals IMPORT PtrObjTree, PtrMaxStr;
 
 
                (*  Menu Manager  *)
                (*  ============  *)

PROCEDURE MenuBar (tree: PtrObjTree; show: BOOLEAN);

        
        (*  Diese Prozedur meldet eine Men�zeile an oder ab.
         *
         *  Eingabeparameter
         *  ----------------
         *
         *  'show'      -- 'TRUE': das Men� wird angemeldet. Das bedeutet
         *                 da� die Zeile am oberen Rand des Bildschirms
         *                 dargestellt wird und da� bei einem folgende
         *                 Aufruf einer Eventprozedur (siehe AESEvents)
         *                 vom AES darauf geachtet wird, ob der Mauszei-
         *                 ger die Men�zeile betritt.
         *                 'FALSE': das Men� wird zwar nicht vom Bild-
         *                 schirm gel�scht, aber es kann vom Anwender
         *                 nicht mehr benutzt werden.
         * 'tree'       -- mu� einen Zeiger auf die Definition der Men�-
         *                 zeile in Form eines Objektbaumes beinhalten.
         *)
        
PROCEDURE CheckItem (tree: PtrObjTree; item: CARDINAL; check: BOOLEAN);

        (*  Diese Prozedur setzt oder l�scht den Haken links neben
         *  dem Men�eintrag.
         *
         *  Eingabeparameter
         *  ----------------
         *
         *  'tree'      -- die Men�zeile in der der Eintrag steht.
         *  'item'      -- der Eintrag
         *  'check'     -- 'TRUE' : der Haken wird gesetzt.
         *                 'FALSE': der Haken wird gel�scht.
         *)
        
PROCEDURE EnableItem (tree: PtrObjTree; item: CARDINAL; enable: BOOLEAN);

        (*  Der Eintrag einer Men�zeile wird aktiviert oder deakti-
         *  viert. Der Schriftzug eines deativierten Eintrages wird
         *  aufgehellt dargestellt und kann vom Anwender nicht mehr
         *  angew�hlt werden.
         *
         *  Eingabeparameter
         *  ----------------
         *
         *  'item'      -- der Eintrag
         *  'tree'      -- die Men�zeile, in der der Eintrag steht.
         *  'enable'    -- 'TRUE' : Eintrag wird aktiviert
         *                 'FALSE': Eintrag wird deaktiviert
         *)
        
PROCEDURE NormalTitle (tree  : PtrObjTree;
                       title : CARDINAL;
                       normal: BOOLEAN);

        (*  Der Titel in einer Men�zeile wird normal oder invers
         *  dargestellt. Die inverse Darstellung bedeutet, da� der
         *  Title angw�hlt wurde.
         *
         *  Eingabeparameter
         *  ----------------
         *
         *  'title'     -- Der Titel, der normal oder invers darge-
         *                 stellt werden soll.
         *  'tree'      -- Die Men�zeile, in der der Titel steht
         *  'normal'    -- 'TRUE' : Titel normal darstellen
         *                 'FALSE': Titel invers darstellen
         *
         *)

PROCEDURE MenuText (tree: PtrObjTree; item: CARDINAL; REF text: ARRAY OF CHAR);

        (*  Diese Routine erlaubt es, einem Men�eintrag einen neuen
         *  Text zuzuweisen.
         *
         *  Eingabeparameter
         *  ----------------
         *
         *  'item'      -- Der Men�eintrag
         *  'text'      -- Der neue Text
         *
         *  Es ist darauf zu achten, da� die neue Zeichenkette nicht
         *  l�nger als die Alte ist. Der Text sollte durch zwei Leer-
         *  zeichen eingeleitet werden und am Ende mit Leerzeichen
         *  aufgef�llt werden. Am Ende sollte mindestens ein Leerzei-
         *  chen stehen.
         *)

PROCEDURE RegisterAcc (    title  : PtrMaxStr;
                       VAR id     : CARDINAL;
                       VAR success: BOOLEAN);
        
        (*  Diese Prozedur darf nur von Accessories verwendet werden.
         *  Sie tr�gt ein Accesory im Men� ein.
         *
         *  Eingabeparameter
         *  ----------------
         *
         *  'title'     --'title^' ist die Zeichenkette des Accesory's
         *                das in das Men� eingetragen werden soll.
         *
         *  Ausgabeparameter
         *  ----------------
         *
         *  'success'   --'TRUE' : die Anmeldung war erfolgreich
         *                'FALSE': Anmeldung war nicht erfolgreich
         *  'id'        -- enth�lt, falls die Anmeldung erfolgreich war
         *                 die Identifikationsnummer des Accesorry's
         *                 die bei jeder 'accOpen' und 'accClose' Nach-
         *                 richt angegeben wird. (Siehe AESEvents)
         *
         *  Es ist darauf zu achten, da� title^ eine globale Variable
         *  ist!
         *)
        

END AESMenus.