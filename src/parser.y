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
program                     : function
                            ;

function                    : function_header block
                            ;
function_header             : IDENTIFIER IDENTIFIER formal_parameters
                            | VOID IDENTIFIER formal_parameters
                            ;

block                       : labels_section variables_section functions_section body
labels_section              :
                            | labels
                            ;
variables_section           :
                            | variables
                            ;
functions_section           :
                            | functions
                            ;

labels                      : LABELS identifier_list SEMI_COLON
                            ;

variables                   : VARS declarations_list SEMI_COLON
                            ;
declarations_list           : declaration
                            | declaration declarations_list
                            ;
declaration                 : identifier_list COLON type
                            ;

functions                   : FUNCTIONS functions_list
                            ;

functions_list              : function
                            | function functions_list
                            ;

body                        : OPEN_BRACE statement_list CLOSE_BRACE
                            ;
statement_list              :
                            | statement statement_list
                            ;

type                        : IDENTIFIER
                            ;

formal_parameters           : OPEN_PAREN CLOSE_PAREN
                            | OPEN_PAREN formal_parameter_list CLOSE_PAREN
                            ;
formal_parameter_list       : formal_parameter
                            | formal_parameter COMMA formal_parameter_list
                            ;
formal_parameter            : expression_parameter
                            ;
expression_parameter        : VAR identifier_list COLON IDENTIFIER
                            | identifier_list COLON IDENTIFIER
                            ;

statement                   : IDENTIFIER COLON unlabeled_statement
                            | unlabeled_statement
                            ;
unlabeled_statement         : assignment
                            | function_call_statement
                            | goto
                            | return
                            | conditional
                            | repetitive
                            | compound
                            | empty_statement
                            ;

assignment                  : variable ASSIGN expression
                            ;
variable                    : IDENTIFIER
                            ;

function_call_statement     : function_call
                            ;
function_call               : IDENTIFIER OPEN_PAREN expression_list CLOSE_PAREN

goto                        : GOTO IDENTIFIER
                            ;

return                      : RETURN SEMI_COLON
                            | RETURN expression SEMI_COLON
                            ;

conditional                 : IF OPEN_PAREN expression CLOSE_PAREN compound
                            | IF OPEN_PAREN expression CLOSE_PAREN compound ELSE compound
                            ;
repetitive                  : WHILE OPEN_PAREN expression CLOSE_PAREN compound
                            ;

compound                    : OPEN_BRACE unlabeled_statement_list CLOSE_BRACE
                            ;
unlabeled_statement_list    :
                            | unlabeled_statement unlabeled_statement_list
                            ;

empty_statement             : SEMI_COLON

expression                  : simple_expression
                            | simple_expression relational_operator simple_expression
                            | unop_expression
                            | unop_expression relational_operator simple_expression
                            ;
simple_expression           : term addition_list
                            ;
unop_expression             : unary_operator term addition_list
addition_list               :
                            | additive_operator term addition_list
                            ;
term                        : factor multiplicative_list
                            ;
multiplicative_list         :
                            | multiplicative_operator factor multiplicative_list
                            ;
factor                      : variable
                            | INTEGER
                            | function_call
                            | OPEN_PAREN expression CLOSE_PAREN
                            ;

identifier_list             : IDENTIFIER
                            | IDENTIFIER COMMA identifier_list
                            ;

expression_list             : expression
                            | expression COMMA expression_list
                            ;

relational_operator         : LESS_OR_EQUAL
                            | LESS
                            | EQUAL
                            | DIFFERENT
                            | GREATER_OR_EQUAL
                            | GREATER
                            ;
additive_operator           : PLUS
                            | MINUS
                            | OR
                            ;
unary_operator              : PLUS
                            | MINUS
                            | NOT
                            ;
multiplicative_operator     : MULTIPLY
                            | DIV
                            | AND
                            ;
%%
