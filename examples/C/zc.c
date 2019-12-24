/* fgets, fputs, and string function examples */ 
#include <stdio.h> 
#include <string.h> 
int main () 
{ 
   FILE *iFile, *oFile; 
   char recLine  [80]; 
   char * chLine; 
   oFile = fopen ("DD:RECOUT","w"); 
   iFile = fopen ("DD:RECIN","r"); 
     if (iFile==NULL) perror ("Error opening file");
     else 
     { 
       do { 
           fgets (recLine,80,iFile); 
           chLine = strstr (recLine,"###"); 
           strncpy (chLine,"x86",3); 
           fputs (recLine,oFile); 
          } while (recLine == NULL); 
       fclose (iFile); 
       fclose (oFile); 
     } 
   return 0; 
} 