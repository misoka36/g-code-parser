%option yylineno
%{
#include "nc_parser.tab.h"
int yycolumn = 1;
%}

%option noyywrap

%%

\(.*\)         { yycolumn += yyleng; /* コメントを無視 */ }
[0-9]+         { yycolumn += yyleng; yylval = atoi(yytext); return POS_INTEGER; }
-[0-9]+        { yycolumn += yyleng; yylval = atoi(yytext); return NEG_INTEGER; }
[0-9]+\.[0-9]* { yycolumn += yyleng; yylval = atof(yytext); return POS_DOUBLE; }
-[0-9]+\.[0-9]* { yycolumn += yyleng; yylval = atof(yytext); return NEG_DOUBLE; }
\.[0-9]+       { yycolumn += yyleng; yylval = atof(yytext); return POS_DOUBLE; }
-\.[0-9]+      { yycolumn += yyleng; yylval = atof(yytext); return NEG_DOUBLE; }
[\n]           { yycolumn = 1; }
[\t ]          { yycolumn += yyleng; }
.              { yycolumn += yyleng; return yytext[0]; }

%%