/* REXX */ 
/*********************************************************************/
/*                                                                   */
/* Barrett Otte                                                      */
/* Master the Mainframe 2019                                         */
/*                                                                   */
/* Create report of SYSLOG messages with specific                    */
/*   job identifier.                                                 */
/*                                                                   */
/* Simple edit of sample report provided.                            */
/*                                                                   */
/*********************************************************************/
                                                                       
say 'Enter job identifier' 
parse pull jobid 
jobid = translate(strip(jobid)) 
joblen = length(jobid) 
                                                                       
"allocate dataset(ch15.output(jobid)) file(msgout) shr reuse" 
"execio 0 diskw msgout (stem msg. open" 
"execio 0 diskw msgout (stem title. open" 
                                                                       
rc = isfcalls('ON') 
isfdate = "mmddyyyy /" 
currday = date("C") 
currday = currday - 2    /* yesterday */ 
isflogstartdate = date("U", currday, "C")  /* yesterday as mm/dd/yy */ 
isflogstarttime = time("N") 
isflogstopdate  = date("U") 
isflogstoptime  = time("N") 
                                                                       
div = '=========================================================' 
title.1 = div 
title.2 = '                  JOB IDENTIFIER REPORT                  ' 
title.3 = div 
say title.1 
say title.2 
say title.3 
"execio 3 diskw msgout (stem title. " 
                                                                       
do until isfnextlinetoken='' 
  Address SDSF "ISFLOG READ TYPE(SYSLOG)" 
  do ix=1 to isfline.0 
    call LogRecFields 
    if substr(JobIdentifier, 1, joblen) = jobid then 
      do 
        msg.1= JobIdentifier date("U", JulianDate, "C") TimeStamp 
        msg.2= clean(MessageLine) 
        msg.4= div 
        ix = ix + 1 
                                                                       
        do until substr(isfline.ix, 1, 1) /= 'D' 
          msg.3 = clean(substr(isfline.ix, 59, 60)) 
          say msg.1 
          say msg.2 
          say msg.3 
          say msg.4 
          "execio 4 diskw msgout (stem msg. " 
          ix = ix + 1 
        end 
      end 
  end 
  isfstartlinetoken = isfnextlinetoken 
end 
                                                                  
rc = isfcalls("off") 
"execio 0 diskw msgout (finis"
"free file(msgout)" 
exit 
                                                                  
/* Clean up string for outputting in report */ 
clean: 
PARSE ARG s 
return space(s) 
                                                                  
/* Parse SYSLOG message */ 
LogRecFields: 
RecordType    = substr(isfline.ix,  1,  1) 
CommandType   = substr(isfline.ix,  2,  1)      
RouteCode     = substr(isfline.ix,  3,  8)
SysName       = substr(isfline.ix, 11,  4)
JulianDate    = substr(isfline.ix, 20,  5)
TimeStamp     = substr(isfline.ix, 26, 11)
JobIdentifier = substr(isfline.ix, 38,  8)
MessageFlags  = substr(isfline.ix, 47,  8)
MessageArea   = substr(isfline.ix, 57, 64)
MessageLine   = substr(isfline.ix, 65, 56)
return 
                                          