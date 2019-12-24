//UNIXSH   JOB 1,NOTIFY=&SYSUID 
//* -------------------------- 
//SHELL    EXEC PGM=BPXBATCH 
//STDOUT   DD DSN=&SYSUID..P2.OUTPUT(#10),DISP=SHR,DCB=LRECL=80
//STDERR   DD SYSOUT=* 
//STDPARM  DD * 
sh uname -mrsvI;                                         ; 
echo '+----------------------------------------+'        ; 
echo '| df command output for your filesystem  |'        ; 
echo '+----------------------------------------+'        ; 
rm -r *;                                                 ; 
echo '+---------------------------------------------+'   ; 
echo '| Unix list files in your file directory      |'   ; 
echo '+---------------------------------------------+'   ; 
ls -al ;                                                 ; 