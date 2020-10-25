/*
   Test of the parser for SL.
   
   Prints only correctness or error messages.

   Returns code execution 0 even in case of errors so as not to
   confuse SuSy.
*/

/* Last update: "test_parser.c: 2020-10-06 (Tue)  18:25:40 -03 (tk)" */

#include <stdio.h>
#include <stdlib.h>
#include "test_parser.h"

extern char *yytext;
#ifdef YYDEBUG
   extern int yydebug; /* debug */
#endif

extern int line_num;
extern int lexerror;

int yyerror(char *s) {
  
  if (lexerror)
    printf("Lexical error detected on line %d.\n",line_num);
  else
    printf("Syntax error detected on line %d.\n",line_num);
  printf("Last token read: '%s'\n\n",yytext);
  return 0;
  
}

int main(int argc, char ** argv){

  int error;
#ifdef YYDEBUG
  yydebug = 1; /* debug */
#endif  

  if (!lexerror) { /* otherwise lexical error */
    error = yyparse();
        
    if (error==0)
      printf("Program syntactically correct\n\n");
        
  }
  
  return 0;
        
}

