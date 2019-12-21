/* REXX */ 
rc=isfcalls('ON') 
cmd1 = 'D TS,'||userid() 
  mycmd.0=2 
  mycmd.1="D T" 
  mycmd.2=cmd1 
Address SDSF ISFSLASH "("mycmd.") (WAIT)"
rc=isfcalls('OFF') 