/* REXX */ 
/*----------------------------------------------*/ 
clrscn 
say '   System Information Utility    ' 
say ' ' 
say '   Information requested:' 
say '   1. Report specific message identifier found in SYSLOG' 
say '   2. Report from System Information, SYS' 
say '   3. Report string found in SYSLOG' 
say '   4. Report TSO logons' 
say '   5. Report specific ID successful TSO logon' 
say '   6. Report display command executions' 
say '   7. Report ............................' 
say ' ' 
say '   Enter report number' 
pull answer 
answer = strip(answer) 
Select 
 When answer = 1 then 'exec ch15(msgid)' 
 When answer = 2 then 'exec ch15(sys)' 
 When answer = 3 then 'exec ch15(strng)' 
 When answer = 4 then 'exec ch15(.....)' 
 When answer = 5 then 'exec ch15(.....)' 
 When answer = 6 then 'exec ch15(.....)' 
 When answer = 7 then 'exec ch15(.....)' 
 Otherwise say 'Invalid report selection' 
End 
Exit 0 