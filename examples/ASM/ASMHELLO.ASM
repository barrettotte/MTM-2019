//ASMHELLO   JOB 1 
//           EXEC ASMACL 
//C.SYSIN    DD   DATA,DLM=QQ 
HELLO    TITLE 'Hello World' 
HELLO    CSECT 
*--------------------------------------------------------------------*
*        Take control and remember how to return control             *
*--------------------------------------------------------------------*
         BAKR  14,0                SAVE CALLERS ENVIRONMENT 
         LR    12,15               LOAD OUR ADDRESS IN REGISTER 12 
         USING HELLO,12            BASE REGISTER IS 12 
*--------------------------------------------------------------------*
*        program body                                                *
*--------------------------------------------------------------------*
         OPEN  (RECDD,OUTPUT) 
         MVC   REC,HELLOMSG                                           
         PUT   RECDD,REC 
         MVC   REC,NEWMSG 
         PUT   RECDD,REC 
         MVC   REC,MSG11 
         PUT   RECDD,REC 
         CLOSE (RECDD) 
*--------------------------------------------------------------------*
*        return control to system - this program is done             *
*--------------------------------------------------------------------*
EXIT     DS    0H                  HALFWORD BOUNDRY ALIGNMENT 
         PR                        RETURN TO CALLER 
         EJECT 
*--------------------------------------------------------------------*
*        program references                                          *
*--------------------------------------------------------------------*
HELLOMSG DC    CL80'   Assembler Hello World!   ' 
NEWMSG   DC    CL80'IBM Z is a complex instruction set' 
MSG11    DC    CL80'High level languages hide complexity of assembler'
REC      DS    CL80 
RECDD    DCB   DSORG=PS,MACRF=PM,DDNAME=RECDD,RECFM=FB,LRECL=80 
         END   HELLO 
QQ 
//L.SYSLMOD  DD DSN=&SYSUID..LOAD(ASMHELLO),DISP=SHR 