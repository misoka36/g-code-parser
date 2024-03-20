%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern int yylineno;
extern int yycolumn;
void yyerror(const char *s);

// yywrap関数を定義
int yywrap() {
    return 1;
}
%}

%token POS_INTEGER NEG_INTEGER
%token POS_DOUBLE NEG_DOUBLE

%%

program : block_list

block_list : block
           | block_list block

block : 'N' POS_INTEGER statement_list
      | statement_list

statement_list : statement
               | statement_list statement

statement : 'G' pos_number
          | 'M' pos_number
          | 'X' number
          | 'Y' number
          | 'Z' number
          | 'F' number
          | 'S' number
          | 'T' pos_number
          | 'I' number
          | 'J' number
          | 'O' POS_INTEGER
          | 'D' pos_number

number : integer
       | double

pos_number : POS_INTEGER
           | POS_DOUBLE

integer : POS_INTEGER
        | NEG_INTEGER

double : POS_DOUBLE
        | NEG_DOUBLE

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s at line %d, column %d\n", s, yylineno, yycolumn - 1);
}

int main() {
    yyparse();
    return 0;
}