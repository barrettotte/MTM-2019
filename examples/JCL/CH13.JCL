//*---------------------------------------------------------
//DELETE  EXEC PGM=IDCAMS 
//SYSPRINT DD SYSOUT=* 
//SYSIN    DD *,SYMBOLS=CNVTSYS 
  DELETE &SYSUID..CH13.VSAM 
  DELETE &SYSUID..CH13.SEQ 
  DELETE &SYSUID..CH13.PDS 
  DELETE &SYSUID..CH13.PDSE 
  SET MAXCC=0 
//*---------------------------------------------------------
//DEFVSAM EXEC PGM=IDCAMS 
//SYSPRINT DD SYSOUT=* 
//SYSIN    DD *,SYMBOLS=CNVTSYS 
  DEFINE CLUSTER ( NAME (&SYSUID..CH13.VSAM ) - 
        VOLUME(VPWRKB) TRACKS(1) RECORDSIZE(80,80) - 
        INDEXED KEY(1 0) - 
        CONTROLINTERVALSIZE(80) ) 
//*---------------------------------------------------------
//ALLOCATE EXEC PGM=IEFBR14 
//*---------------------------------------------------------
//SEQ      DD DISP=(NEW,CATLG,DELETE), 
// SPACE=(TRK,1),UNIT=SYSDA, 
// DCB=(LRECL=80,DSORG=PS), 
// DSN=&SYSUID..CH13.SEQ 
//*---------------------------------------------------------
//PDS      DD DISP=(NEW,CATLG,DELETE), 
// SPACE=(TRK,(1,,5)),UNIT=SYSDA, 
// DCB=(LRECL=80,DSORG=PO), 
// DSN=&SYSUID..CH13.PDS 
//*---------------------------------------------------------
//PDSE     DD DISP=(NEW,CATLG,DELETE), 
// SPACE=(TRK,1),UNIT=SYSDA, 
// DCB=(LRECL=80,DSORG=PO),DSNTYPE=LIBRARY, 
// DSN=&SYSUID..CH13.PDSE 
//*---------------------------------------------------------
//C1      EXEC PGM=IEBGENER 
//SYSPRINT DD SYSOUT=* 
//SYSUT2   DD DSN=&SYSUID..CH13.SEQ,DISP=SHR 
//SYSUT1   DD * 
ABCDEFGHIJKLMNOPQRSTUVWXYZ 
//SYSIN    DD DUMMY 
//*---------------------------------------------------------
//C2      EXEC PGM=IEBGENER 
//SYSPRINT DD SYSOUT=* 
//SYSUT2   DD DSN=&SYSUID..CH13.PDS(CH13),DISP=SHR 
//SYSUT1   DD DSN=&SYSUID..CH13.SEQ,DISP=SHR 
//SYSIN    DD DUMMY 
//*---------------------------------------------------------
//C3      EXEC PGM=IEBGENER 
//SYSPRINT DD SYSOUT=* 
//SYSUT2   DD PATH='/z/z52815/ch13', 
// PATHOPTS=(OWRONLY,OCREAT,OTRUNC), 
// PATHMODE=SIRWXU 
//SYSUT1   DD DSN=&SYSUID..CH13.SEQ,DISP=SHR 
//SYSIN    DD DUMMY 
//*---------------------------------------------------------
//C4      EXEC PGM=IEBCOPY 
//SYSPRINT DD SYSOUT=* 
//PDS      DD DSN=&SYSUID..CH13.PDS,DISP=SHR 
//PDSE     DD DSN=&SYSUID..CH13.PDSE,DISP=SHR 
//SYSIN    DD * 
COPYOPER  COPY OUTDD=PDSE,INDD=PDS 
  SELECT MEMBER=CH13 
//*---------------------------------------------------------
//C5      EXEC PGM=IDCAMS 
//SYSPRINT DD SYSOUT=* 
//VSAM     DD DSN=&SYSUID..CH13.VSAM,DISP=SHR 
//INREC    DD DSN=&SYSUID..CH13.SEQ,DISP=SHR 
//SYSIN    DD *,SYMBOLS=CNVTSYS 
  REPRO INFILE(INREC) OUTFILE(VSAM) 
//*--------------------------------------------------------- 
//  IF (C1.RC=0 & C2.RC=0 & C3.RC=0 & C4.RC=0 & C5.RC=0) THEN 
//LISTC   EXEC PGM=IKJEFT01 
//SYSPRINT DD SYSOUT=* 
//SYSTSPRT DD DSN=&SYSUID..P2.OUTPUT(#13),DISP=SHR 
//SYSTSIN  DD *,SYMBOLS=CNVTSYS 
  LISTC LEVEL(&SYSUID) 
//  ENDIF 
//*--------------------------------------------------------- 
//D1      EXEC PGM=IDCAMS 
//SYSPRINT DD SYSOUT=* 
//SYSIN    DD *,SYMBOLS=CNVTSYS 
  DELETE &SYSUID..CH13.VSAM 
  DELETE &SYSUID..CH13.SEQ 
  DELETE &SYSUID..CH13.PDS 
  DELETE &SYSUID..CH13.PDSE 
  SET MAXCC=0 
//*--------------------------------------------------------- 
//D2       EXEC PGM=BPXBATCH 
//STDOUT   DD SYSOUT=* 
//STDERR   DD SYSOUT=* 
//STDPARM  DD * 
sh ls -al  ; 
rm -r * ; 