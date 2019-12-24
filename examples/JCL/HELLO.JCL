//COBOL   EXEC IGYWCL,MBR=CBLHELLO 
//*----------------------------------- 
//RUN     EXEC PGM=CBLHELLO 
//STEPLIB DD   DSN=&SYSUID..LOAD,DISP=SHR 
//*----------------------------------- 
//C       EXEC CBCXCB,MBR=CHELLO 
//*----------------------------------- 
//RUN     EXEC PGM=CHELLO 
//STEPLIB DD   DSN=&SYSUID..LOAD,DISP=SHR 