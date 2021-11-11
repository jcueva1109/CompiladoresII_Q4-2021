%code requires{
    #include "ast.h"
}

%{

    #include <cstdio>
    using namespace std;
    int yylex();
    extern int yylineno;
    void yyerror(const char * s){
        fprintf(stderr, "¡Error! Line: %d, error: %s\n", yylineno, s);
    }

    #define YYERROR_VERBOSE 1
%}

%union{
  
    float float_t;
    char* ident_t;

    Expr* expr_t;
    ExprList* expr_list;

    Statement* stmt_t;
    StatementList* stmt_list_t;

}

%token THEN 
%token ENDIF 
%token ELSE
%token IF
%token <float_t>Number
%token ADD
%token ASSIGN
%token SUB
%token MUL
%token DIV
%token LParenthesis
%token RParenthesis
%token Comma
%token Semicolon
%token Greater
%token Less
%token LET
%token WHILE
%token DO
%token DONE
%token<ident_t> Identifier
%token EOL

%type<stmt_list_t> start stmt
%type<stmt_t> stmt_list Assign_ block
%type<expr_t> expr term relational_expr factor
%type<ident_t> id

%%

input: start {

    list<Statement*>::iterator i = $1->begin();
    while(i != $1->end()){
        printf("Output: %f\n", (*i)->evalSemantic());
        i++;
    }

};

start: stmt_list EOL_List { $$ = new StmtList; $$->push_back($1); }
;

stmt_list: stmt_list EOL_List stmt { $$ = $1; $$->push_back($1); }
    | stmt { }
;

EOL_List: EOL_List EOL {  }
    | EOL {  }
;

Assign_: Identifier ASSIGN expr { $$ = $3; }
;

stmt: LET Assign_
    | func_call { } 
    | LET Identifier LParenthesis PARAMS_List RParenthesis ASSIGN block { }
    | expr { }
;

block: WHILE LParenthesis expr RParenthesis DO stuff
    | expr
;

stuff: Assign_ Semicolon Assign_ DONE EOL_List func_call
    | Assign_ Semicolon
    | expr  Semicolon expr DONE EOL_List func_call
;

func_call: Identifier LParenthesis PARAMS_List RParenthesis
;

PARAMS_List: Identifier Comma PARAMS_List
    | expr Comma PARAMS_List { }
    | Identifier 
    | Number
;

expr: expr ADD term { $$ = new AddExpr($1,$3); }
    | expr SUB term { $$ = new SubExpr($1, $3); }
    | term { $$ = $1; }
;

term: term MUL factor { $$ = new MulExpr($1,$3); }
    | term DIV factor { $$ = new DivExpr($1,$3); }
    | relational_expr { $$ = $1; }
;

relational_expr: relational_expr Greater factor { $$ = $1 > $3; }
    | relational_expr Less factor { $$ = $1 < $3; }
    | factor { $$ = $1; }
;

factor: Number { $$ = new NumExpr($1); }
    | id
    | LParenthesis expr RParenthesis { $$ = $2; }
;

id: Identifier { $$ = $1; } 
;

%%
