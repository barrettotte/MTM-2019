//C       EXEC CBCXCB,MBR=ZC 
//*------------------------------------------------------------- 
// IF RC = 0 THEN 
//*------------------------------------------------------------- 
//CRUN    EXEC PGM=ZC 
//STEPLIB DD   DSN=&SYSUID..LOAD,DISP=SHR 
//RECIN   DD   DSN=ZOS.MTM2019.PUBLIC.SHARED.DATA(MSG1),DISP=SHR 
//RECOUT  DD   DSN=&SYSUID..P3.OUTPUT(#04),DISP=SHR 
//CEEDUMP DD   DUMMY 
//*------------------------------------------------------------- 
// ENDIF 
//*------------------------------------------------------------- 
//COBOL   EXEC IGYWCL,MBR=ZCOBOL 
//*------------------------------------------------------------- 
// IF RC = 0 THEN 
//*------------------------------------------------------------- 
//CBLRUN  EXEC PGM=ZCOBOL 
//STEPLIB DD   DSN=&SYSUID..LOAD,DISP=SHR 
//RECIN   DD   DSN=ZOS.MTM2019.PUBLIC.SHARED.DATA(MSG2),DISP=SHR 
//        DD   DSN=&SYSUID..P3.OUTPUT(#04),DISP=SHR 
//RECOUT  DD   DSN=&SYSUID..P3.OUTPUT(#04),DISP=SHR 
//CEEDUMP DD   DUMMY 
//*------------------------------------------------------------- 
// ENDIF 