/* rexx */ 
say 'Hello ' userid() 
say 'System Date is ' date() 
say 'System Time is ' time() 
/* ---------------- */ 
"allocate dataset(p3.output(#13)) file(msgout) shr reuse" 
"execio 0 diskw msgout (stem msg. open" 
/* ---------------- */ 
/* msg.1 = userid() */ 
/* msg.2 = date()   */ 
/* msg.3 = time()   */ 
/* ---------------- */ 
u = userid() 
d = date() 
t = time() 
msg.1 = u d t 
/* ---------------- */ 
"execio * diskw msgout (stem msg. " 
rc=isfcalls('ON') 
/* ---------------------*/ 
/* Access the SYS panel */ 
/* ---------------------*/ 
Address SDSF "ISFEXEC SYS" 
if rc<>0 then 
  Exit rc 
/* Get fixed field name from first word */ 
/* of isfcols special variable          */ 
fixedField = word(isfcols,1) 
/* Say "Number of rows returned:" isfrows */ 
/* Process all rows */ 
do ix=1 to isfrows 
/*  Say "Now processing job:" value(fixedField"."ix) */ 
/* List all columns for row */ 
  do jx=1 to words(isfcols) 
    col = word(isfcols,jx) 
 /* Say "  Column" col"."ix "has the value:" value(col"."ix) */
    Select 
     When col = SYSNAME   then nop 
     When col = TOKEN     then nop 
     When col = SYSLEVEL  then call write_syslevel
     When col = CPUPR     then call write_cpupr 
     When col = SIO       then nop 
     When col = AUXPCT    then nop 
     When col = CSAPCT    then nop 
     When col = SQAPCT    then nop 
     When col = ECSAPCT   then nop 
     When col = ESQAPCT   then nop 
     When col = UIC       then call write_uic 
     When col = SPOOLPCT  then nop 
     When col = CADSPCT   then nop 
     When col = PAGERATE  then nop 
     When col = REAL      then nop 
     When col = REALAFC   then call write_real_afc
     When col = REALAFCB  then nop 
     When col = FIXPCT    then nop 
     When col = FIXBPCT   then nop 
     When col = MAXASID   then nop 
     When col = FREEASID  then nop 
     When col = BADASID   then nop 
     When col = STCNUM    then call write_stc 
     When col = TSUNUM    then call write_tsu 
     When col = JOBNUM    then call write_job 
     When col = WTORNUM   then nop 
     When col = SYSPLEX   then nop 
     When col = LPAR      then nop 
     When col = VMUSER    then nop 
     When col = JESNAME   then nop 
     When col = JESNODE   then nop 
     When col = SMF       then nop 
     When col = IPLVOL    then nop 
     When col = IPLUNIT   then nop 
     When col = IPLDATE   then nop 
     When col = IPLTYPE   then nop 
     When col = IPLDAYS   then nop 
     When col = LOADPARM  then nop 
     When col = CVTVERID  then nop 
     When col = LOADDSN   then nop 
     When col = LOADUNIT  then nop 
     When col = IEASYS    then nop 
     When col = IEASYM    then nop 
     When col = GRS       then nop 
     When col = HWNAME    then nop 
     When col = CPC       then call write_cpc
     When col = MSU       then nop 
     When col = SYSMSU    then nop 
     When col = AVGMSU    then nop 
     When col = CPUNUM    then nop 
     When col = ZAAPNUM   then nop 
     When col = ZIIPNUM   then nop 
     When col = OSCONFIG  then nop 
     When col = EDT       then nop 
     When col = NUCLST    then nop 
     When col = IEANUC    then nop 
     When col = IODFDSN   then nop 
     When col = IODFDATE  then nop 
     When col = CATDSN    then nop 
     When col = CATVOL    then nop 
     When col = MLA       then nop 
     When col = CATTYPE   then nop 
     When col = NETID     then nop 
     When col = SSCP      then nop 
     When col = STATDATE  then nop 
     When col = IPLCUNIT  then nop 
     When col = IODFUNIT  then nop 
     When col = IODFCUNIT then nop 
     Otherwise                 nop 
  end 
end 
"free file(msgout)" 
exit 0 
write_cpc: 
/* say "IBM Z Mainframe type is " value(col"."ix) */ 
   msg.1 = 'IBM Z Mainframe type is ' value(col"."ix) 
   "execio 1 diskw msgout (stem msg.      " 
return 
/*----------------------------------------------------*/ 
write_syslevel: 
/* say "Operating System Level is " value(col"."ix)     */ 
   msg.1 = 'Operating System Level is ' value(col"."ix) 
   "execio 1 diskw msgout (stem msg.      " 
/*----------------------------------------------------*/ 
return 
/*----------------------------------------------------*/ 
write_cpupr: 
   msg.1 = 'CPU Percentage: ' value(col"."ix) 
   "execio 1 diskw msgout (stem msg.       " 
return 
/*----------------------------------------------------*/ 
write_uic: 
   msg.1 = 'High unref. interval count is: ' value(col"."ix)
   "execio 1 diskw msgout (stem msg.       " 
return 
/*----------------------------------------------------*/ 
write_real_afc: 
   msg.1 = 'Real storage av. frame count: ' value(col"."ix)
   "execio 1 diskw msgout (stem msg.       " 
return 
/*----------------------------------------------------*/ 
write_stc: 
   msg.1 = 'Active started tasks: ' value(col"."ix) 
   "execio 1 diskw msgout (stem msg.       " 
return 
/*----------------------------------------------------*/ 
write_tsu: 
   msg.1 = 'Active TSO users: ' value(col"."ix) 
   "execio 1 diskw msgout (stem msg.       " 
return 
/*----------------------------------------------------*/ 
write_job: 
   msg.1 = 'Active batch jobs: ' value(col"."ix) 
   "execio 1 diskw msgout (stem msg.       " 
return 
/*----------------------------------------------------*/ 