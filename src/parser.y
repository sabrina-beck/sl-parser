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
program                     : function END_OF_FILE {return 0;}
                            ;

function                    : function_header block
                            ;


function_header             : function_return_type identifier formal_parameters
                            ;
function_return_type        : VOID
                            | identifier
                            ;
formal_parameters           : OPEN_PAREN CLOSE_PAREN
                            | OPEN_PAREN formal_parameter_list CLOSE_PAREN
                            ;
formal_parameter_list       : formal_parameter
                            | formal_parameter COMMA formal_parameter_list
                            ;
formal_parameter            : expression_parameter
                            | function_parameter
                            ;
expression_parameter        : VAR identifier_list COLON identifier
                            | identifier_list COLON identifier
                            ;
function_parameter          : function_header
                            ;


block                       : labels_section types_section variables_section functions_section body
                            ;

labels_section              :
                            | labels
                            ;
labels                      : LABELS identifier_list SEMI_COLON
                            ;

types_section               :
                            | types
                            ;
types                       : TYPES type_declaration_list
                            ;
type_declaration_list       : type_declaration
                            | type_declaration type_declaration_list
                            ;
type_declaration            : identifier ASSIGN type SEMI_COLON
                            ;

variables_section           :
                            | variables
                            ;
variables                   : VARS variables_declaration_list
                            ;
variables_declaration_list  : variable_declaration SEMI_COLON
                            | variable_declaration SEMI_COLON variables_declaration_list
                            ;
variable_declaration        : identifier_list COLON type
                            ;

functions_section           :
                            | functions
                            ;
functions                   : FUNCTIONS functions_list
                            ;
functions_list              : function
                            | function functions_list
                            ;


identifier_list             : identifier
                            | identifier COMMA identifier_list
                            ;
identifier                  : IDENTIFIER
                            ;


type                        : identifier array_size_declaration_list
                            ;
array_size_declaration_list :
                            | array_size_declaration array_size_declaration_list
                            ;
array_size_declaration      : OPEN_BRACKET integer CLOSE_BRACKET
                            ;


body                        : OPEN_BRACE statement_list CLOSE_BRACE
                            ;
statement_list              :
                            | statement statement_list
                            ;
statement                   : label unlabeled_statement
                            | unlabeled_statement
                            ;
label                       : identifier COLON
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

assignment                  : value ASSIGN expression SEMI_COLON
                            ;
value                       : identifier array_index_list
                            ;
array_index_list            :
                            | array_index array_index_list
                            ;
array_index                 : OPEN_BRACKET expression CLOSE_BRACKET
                            ;

function_call_statement     : function_call SEMI_COLON
                            ;
function_call               : identifier OPEN_PAREN arguments_list CLOSE_PAREN
arguments_list              :
                            | expression
                            | expression COMMA arguments_list
                            ;

goto                        : GOTO identifier SEMI_COLON
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

expression                  : binaryop_expression
                            | binaryop_expression relational_operator binaryop_expression
                            | unop_expression
                            | unop_expression relational_operator binaryop_expression
                            ;
binaryop_expression         : term additive_operation
                            ;
unop_expression             : unary_operator term additive_operation
                            ;
additive_operation          :
                            | additive_operator term additive_operation
                            ;

term                        : factor multiplicative_operation
                            ;
multiplicative_operation    :
                            | multiplicative_operator factor multiplicative_operation
                            ;

factor                      : value
                            | integer
                            | function_call
                            | OPEN_PAREN expression CLOSE_PAREN
                            ;


integer                     : INTEGER
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
