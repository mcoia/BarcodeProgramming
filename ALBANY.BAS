REM This program is for the TSC TTP-247 printer.
REM It will take a scanned input barcode that is 9 characters or shorter
REM and print out a 14 digit codabar barcode including a prefix (3), a sitecode
REM (a unique 4 digit code for that library) and enough 0's to bring the
REM barcode up to 14 digits.

REM Good settings for the Trucode labels from vernlib.com
SIZE 2.12,0.75
GAP 0.125,0
DENSITY 10
SPEED 5


SET CUTTER OFF
SET PEEL OFF
DIRECTION 1
REFERENCE 0,0

:START
CLS

REM Setting up some initial variables. PREFIX$ is 3 to indicate an item barcode
REM SITECODE$ is the last 4 digits of their phone number, but just needs to be
REM unique to each library.
LENGTH=14
LIBRARYNAME$="Carnegie Public Library - Albany"
PREFIX$="3"
SITECODE$="5615"
SCANNED$=""
CODE$=""
PAD$=""

INPUT "ENTER BAR CODE:",SCANNED$

REM Calculate the padding required
ORIGLEN=LEN(SCANNED$)
PADLEN=LENGTH-ORIGLEN-5

REM Add enough zeros to bring the barcode up to LENGTH
FOR I=1 TO PADLEN
  PAD$=PAD$+"0"
NEXT

CODE$=PREFIX$+SITECODE$+PAD$+SCANNED$

REM Make sure we haven't scanned in something too long
IF LEN(CODE$)>LENGTH THEN
  TEXT 90,80,"2",0,1,1,"BARCODE TOO LONG"
  PRINT 1
  GOTO START
ENDIF

REM Just for the nice formatting
CODEPART1$=MID$(CODE$,6,5)
CODEPART2$=MID$(CODE$,11,4)

TEXT 60,20,"1",0,1,1,LIBRARYNAME$
REM Remember that codabar needs start and end letters (a,b)
BARCODE 60,50,"CODA",64,0,0,2,4,"A"+CODE$+"B"
REM This line prints the numbers below the barcode and formats it nicely
TEXT 95,120,"2",0,1,1,PREFIX$+" "+SITECODE$+" "+CODEPART1$+" "+CODEPART2$
PRINT 1,1
GOTO START
EOP
