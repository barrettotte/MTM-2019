/* REXX */ 
/**********************************************************************/
/*                                                                    */
/* Barrett Otte                                                       */
/* Master the Mainframe 2019                                          */
/*                                                                    */
/* Template menu provided by MTM                                      */
/*                                                                    */
/**********************************************************************/
                                                                        
clrscn 
say '   System Information Utility    ' 
say ' ' 
say '   Information requested:' 
say '   1. Report specific job identifier found in SYSLOG' 
say '   2. Report DB2 table column information' 
say ' ' 
say '   Enter report number' 
                                                                        
pull answer 
answer = strip(answer) 
                                                                        
select 
 when answer = 1 then 'exec ch15(jobid)' 
 when answer = 2 then 'exec ch15(db2)' 
 otherwise say 'Invalid report selection' 
end 
exit 0 
                                                                        