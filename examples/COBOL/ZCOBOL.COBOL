      *----------------------- 
       IDENTIFICATION DIVISION. 
      *----------------------- 
       PROGRAM-ID.    ZCOBOL 
       AUTHOR.        Otto B. Fun. 
      *-------------------- 
       ENVIRONMENT DIVISION. 
      *-------------------- 
       INPUT-OUTPUT SECTION. 
      * 
       FILE-CONTROL. 
           SELECT REC-OUT    ASSIGN TO RECOUT. 
           SELECT REC-IN     ASSIGN TO RECIN 
                  ORGANIZATION IS SEQUENTIAL. 
      *------------- 
       DATA DIVISION. 
      *------------- 
       FILE SECTION. 
       FD  REC-IN     RECORDING MODE F. 
       01  REC-IN-MSG         PIC X(80). 
      * 
       FD  REC-OUT    RECORDING MODE F. 
       01  REC-OUT-MSG        PIC X(80). 
      * 
       WORKING-STORAGE SECTION. 
       01 FLAGS. 
         05 LASTREC           PIC X VALUE SPACE.
             88 LAST-REC            VALUE "N". 
      *------------------ 
       PROCEDURE DIVISION. 
      *------------------ 
       OPEN-FILES. 
           OPEN INPUT  REC-IN. 
           OPEN OUTPUT REC-OUT. 
      * 
       READ-NEXT-RECORD. 