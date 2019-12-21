/* REXX */ 
rc=isfcalls('ON') 
     /* Access the ST panel */ 
Address SDSF "ISFEXEC LNK" 
if rc<>0 then 
  Exit rc 
     /* Get fixed field name from first word */ 
     /* of isfcols special variable          */ 
fixedField = word(isfcols,1) 
Say "Number of rows returned:" isfrows 
       /* Process all rows */ 
do ix=1 to isfrows 
  Say "Now processing job:" value(fixedField"."ix) 
          /* List all columns for row */ 
  do jx=1 to words(isfcols) 
    col = word(isfcols,jx) 
    Say "  Column" col"."ix "has the value:" value(col"."ix) 
  end 
end 
rc=isfcalls('OFF') 