%option noyywrap

    #include "test_parser.h"
    #include "parser.h"

    int line_num = 1, lexerror = 0;

DIGIT   [0-9]
LETTER  [a-z]

%%
    /* Comments */
"//".*
" "*

    /* Line count */
\n          line_num++;

    /* Comparison operators */
"=="          return(EQUAL);
"!="          return(DIFFERENT);
"<"           return(LESS);
"<="          return(LESS_OR_EQUAL);
">"           return(GREATER);
">="          return(GREATER_OR_EQUAL);

    /* Integer Operations */
"+"           return(PLUS);
"-"           return(MINUS);
"*"           return(MULTIPLY);
"/"           return(DIV);

    /* Boolean Operations */
"||"          return(OR);
"&&"          return(AND);
"!"           return(NOT);

    /* Ponctuation */
"{"           return(OPEN_BRACE);
"}"           return(CLOSE_BRACE);
"["           return(OPEN_BRACKET);
"]"           return(CLOSE_BRACKET);
"("           return(OPEN_PAREN);
")"           return(CLOSE_PAREN);
":"           return(COLON);
","           return(COMMA);
";"           return(SEMI_COLON);

    /* Assignment */
"="           return(ASSIGN);

    /* Reserved words */
else        return(ELSE);
functions   return(FUNCTIONS);
goto        return(GOTO);
if          return(IF);
labels      return(LABELS);
return      return(RETURN);
types       return(TYPES);
var         return(VAR);
vars        return(VARS);
void        return(VOID);
while       return(WHILE);

    /* End of file */
<<EOF>>     return(END_OF_FILE);

    /* Integers */
{DIGIT}+    return(INTEGER);

    /* Identifiers */
{LETTER}({LETTER}|{DIGIT})*     return(IDENTIFIER);

    /* Lexical error if didn't match any of the above patterns */
.          yyerror();return(LEXICAL_ERROR);
%%