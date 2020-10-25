%{

/* FLEX functions */
extern int yylex (void);
void yyerror(char *);

%}

%{ /* Comparison operators */ %}
%token EQUAL
%token DIFFERENT
%token LESS
%token LESS_OR_EQUAL
%token GREATER
%token GREATER_OR_EQUAL

%{ /* Integer Operations */ %}
%token PLUS
%token MINUS
%token MULTIPLY
%token DIV

%{ /* Boolean Operations */ %}
%token OR
%token AND
%token NOT

%{ /* Ponctuation */ %}
%token OPEN_BRACE
%token CLOSE_BRACE
%token OPEN_BRACKET
%token CLOSE_BRACKET
%token OPEN_PAREN
%token CLOSE_PAREN
%token COLON
%token COMMA
%token SEMI_COLON

%{ /* Assignment */ %}
%token ASSIGN

%{ /* Reserved words */ %}
%token ELSE
%token FUNCTIONS
%token GOTO
%token IF
%token LABELS
%token RETURN
%token TYPES
%token VAR
%token VARS
%token VOID
%token WHILE

%{ /* End of file */ %}
%token END_OF_FILE

%{ /* Integers */ %}
%token INTEGER

%{ /* Identifiers */ %}
%token IDENTIFIER

%{ /* Lexical error */ %}
%token LEXICAL_ERROR

%%
expression  : expression PLUS term
            | term
            ;
term        : term MULTIPLY factor
            | factor
            ;
factor      : OPEN_PAREN expression CLOSE_PAREN
            | INTEGER
            ;
%%
