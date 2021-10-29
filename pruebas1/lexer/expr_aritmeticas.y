
%{

    #include <iostream>
    #include <stdexcept>
    #include <unordered_map>
    #include <string>
    using namespace std;

    int yylex();
    extern int yylineno;
    void yyerror(const char * s){
        fprintf(stderr, "Line: %d, error: %s\n", yylineno, s);
    }

%}

%union{

    int int_t;
    bool boolean_t;

}

//Declaracion de Tokens
%token<int_t> Number
%token OpAdd
%token OpSub
%token OpMul
%token OpDiv
%token EOL
%token Error
%token GreaterEqual
%token LessEqual
%token Equal
%token TrueKw
%token FalseKw

%type<int_t>expr term factor

//Gramatica
%%

expr: expr OpAdd term { $$ = $1 + $3; }
        | expr OpSub term { $$ = $1 - $3; }
        | expr OpAdd TrueKw { throw runtime_error("Error: No se puede sumar un entero con un booleano!\n"); }
        | expr OpSub TrueKw { throw runtime_error("Error: No se puede restar un entero con un booleano!\n"); }
        | expr OpAdd FalseKw { throw runtime_error("Error: No se puede sumar un entero con un booleano!\n"); }
        | expr OpSub FalseKw { throw runtime_error("Error: No se puede restar un entero con un booleano!\n"); }
        | term { $$ = $1; }
    ;

    term: term OpMul factor { $$ = $1 * $3; }
        | term OpDiv factor { 

            if($3 == 0){
                throw runtime_error("Error: No se puede dividir entre 0!\n");
            }else{
                $$ = $1 / $3;
            }

        }
        | term OpMul TrueKw { throw runtime_error("Error: No se puede multiplicar un entero con un booleano!\n"); }
        | term OpMul FalseKw { throw runtime_error("Error: No se puede multiplicar un entero con un booleano!\n"); }
        | term OpDiv TrueKw { throw runtime_error("Error: No se puede dividir un entero con un booleano!\n"); }
        | term OpDiv FalseKw { throw runtime_error("Error: No se puede dividir un entero con un booleano!\n"); }
        | factor { $$ = $1; }
    ;

    factor: Number { $$ = $1; }
    ;

%%