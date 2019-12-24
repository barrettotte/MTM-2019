/* REXX */ 
/**********************************************************************/
/*                                                                    */
/* Barrett Otte                                                       */
/* Master the Mainframe 2019                                          */
/*                                                                    */
/*                                                                    */
/* Create report displaying information about this system's           */
/*   DB2 instance.                                                    */
/*                                                                    */
/*                                                                    */
/* I'm curious on how DB2 for z/OS compares to DB2 for IBM i          */
/*                                                                    */
/**********************************************************************/
                                                                        
                                                                        
/* get table name from user */ 
say 'Enter table name' 
parse pull intable 
intable = translate(strip(intable)) 
                                                                        
"allocate dataset(ch15.output(db2)) file(db2out) shr reuse" 
"execio 0 diskw db2out (stem output. open" 
"execio 0 diskw db2out (stem header. open" 
                                                                        
db2ssid = "DBCG" 
div = '--------------------------------------------------------------' 
ch = 'Col#    Column Name              Type       Len   Size   Null?' 
                                                                        
header.1  = div 
header.2  = '                    DB2 Table Description' 
header.3  = div 
header.4  = ' ' 
header.5  = 'DB SSID:    ' || db2ssid 
header.6  = 'Table Name: ' || intable 
header.7  = ' ' 
header.8  = div 
header.9  = ch 
header.10 = div 
                                                                        
do i = 1 to 10; say header.i; end 
"execio 10 diskw db2out (stem header. " 
                                                                        
/* create REXX/DB2 command interface */ 
address MVS "SUBCOM DSNREXX" 
if RC then S_RC = RXSUBCOM('ADD', 'DSNREXX', 'DSNREXX') 
                                                                        
/* connect to DB2 subsystem */ 
DB2_SSID = "DBCG" 
address DSNREXX "CONNECT" db2ssid 
if SQLCODE /= "0" then do 
  errmsg = "Connection failed " 
  erradd = db2ssid 
  call SqlErrorExit 
end 
                                                                        
address DSNREXX "EXECSQL SET CURRENT PACKAGESET='DSNREXCS'" 
if SQLCODE /= "0" then do 
  errmsg = "Set packageset failed " 
  erradd = "NONE" 
  call SqlErrorExit 
end 
                                                                        
/* build SQL statement */ 
SQLSTMT = "" 
SQLSTMT.0 = 3 
SQLSTMT.1 = "SELECT COLNO,NAME,COLTYPE,LENGTH,SCALE,NULLS          " 
SQLSTMT.2 = "FROM SYSIBM.SYSCOLUMNS                                " 
SQLSTMT.3 = "  WHERE TBNAME = ?                                    " 
SQLSTMT.4 = "ORDER BY COLNO                                        " 
                                                                        
do i = 1 to SQLSTMT.0; SQLSTMT = SQLSTMT || SQLSTMT.i || " "; end 
                                                                        
address DSNREXX "EXECSQL DECLARE C1 CURSOR FOR S1" 
if SQLCODE /= "0" then do 
  errmsg = "Declare cursor failed" 
  erradd = "NONE" 
  call SqlErrorExit 
end 
                                                                        
address DSNREXX "EXECSQL PREPARE S1 FROM :SQLSTMT" 
if SQLCODE /= "0" then do 
  errmsg = "Prepare cursor failed " 
  erradd  = "NONE" 
  call SqlErrorExit 
end 
                                                                        
address DSNREXX "EXECSQL OPEN C1 USING :intable" 
if SQLCODE /= "0" then do 
  errmsg = "Open cursor failed " 
  erradd = "NONE" 
  call SqlErrorExit 
end 
                                                                        
z = 0 
                                                                        
/* loop cursor and build output contents */ 
do forever 
  z = z + 1 
  address DSNREXX "EXECSQL FETCH C1 INTO :CNO,:CNA,:CTY,:CLN,:CSC,:CNL" 
  select 
    when SQLCODE = 100 then leave 
    when SQLCODE =   0 then do 
      output.z = right(CNO, 4, '0') ||"    "|| left(CNA, 25, ' ') || , 
        left(CTY, 12) || left(CLN, 8) || left(CSC, 8) || left(CNL, 2) 
      say output.z 
    end 
    otherwise do 
      errmsg = "Fetch failed" 
      erradd = "NONE" 
      call SqlErrorExit 
    end 
  end 
end 
                                                                        
output.0 = z 
z = z + 1 
say div 
output.z = div 
output.0 = z 
                                                                        
"execio * diskw db2out (stem output. " 
                                                                        
address DSNREXX 
"EXECSQL CLOSE C1" 
"EXECSQL COMMIT"; 
                                                                        
call CleanExit 
                                                                        
                                                                        
/************************* SUBPROCEDURES ****************************/ 
                                                                        
CleanExit: 
"execio 0 diskw db2out (finis" 
"free file(db2out)" 
                                                                        
address DSNREXX 
"EXECSQL CLOSE C1" 
"DISCONNECT"; 
S_RC = RXSUBCOM('DELETE', 'DSNREXX', 'DSNREXX') 
exit 
return 
                                                                        
                                                                        
SqlErrorExit: 
say "---------------------------------------------------" 
say "         SQL statement resulted in error           " 
say "                                                   " 
do i = 1 to SQLSTMT.0; say SQLSTMT.i; end 
say "                                                   " 
say "---------------------------------------------------" 
say "            Application Diagnostics                " 
say "                                                   " 
say errmsg 
say erradd 
say "                                                   " 
say "---------------------------------------------------" 
say "                 DB2 Diagnostics                   " 
say "                                                   " 
say 'SQLCODE  = 'SQLCODE   /* Dump SQLCA (Communication Area) */ 
say 'SQLERRM  = 'SQLERRMC 
say 'SQLERRML = 'SQLERRML 
say 'SQLERRP  = 'SQLERRP 
say 'SQLERRD  = 'SQLERRD.1',' || SQLERRD.2',' || SQLERRD.3',' , 
              || SQLERRD.4',' || SQLERRD.5',' || SQLERRD.6 
say 'SQLWARN  = 'SQLWARN.0',' || SQLWARN.1',' || SQLWARN.2',' , 
              || SQLWARN.3',' || SQLWARN.4',' || SQLWARN.5',' , 
              || SQLWARN.6',' || SQLWARN.7',' || SQLWARN.8',' , 
              || SQLWARN.9',' || SQLWARN.10 
say 'SQLSTATE = 'SQLSTATE 
say "                                                   " 
say "---------------------------------------------------" 
call CleanExit 
return 
                                                                        