%option noyywrap
%option yylineno

%{

    #include "tokens.h"
    // extern int yylval;

%}

%%

[0-9]+ { yylval = atoi(yytext);return Number; }
"+" { return OpAdd; }
"-" { return OpSub; }
"*" { return OpMul; }
"/" { return OpDiv; }
">=" { return GreaterEqual; }
"<=" { return LessEqual; }
"==" { return Equal; }
"true" { return TrueKw; }
"false" { return FalseKw; }
[\n] { return EOL; }
[ \t] { }
. { printf("Error: Caracter no valido! %c\n", yytext[0]); }

%%
