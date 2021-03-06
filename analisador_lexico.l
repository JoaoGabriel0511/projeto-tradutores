%{
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <string.h>
#include "analisadorSintatico.tab.h"

int ERRORS_COUNT = 0;
int MAX_ERRORS = 500;
int error_cnt = 0;
int current_line = 1;
int tableSize = 0;
int tem_erro = 0;

struct Error {
    char error_symbol;
    int line;
};

struct Error error_array[500];

void yyerror(const char* msg) {
    tem_erro = 1;
    if(strstr(msg, "syntax") == NULL) {
        fprintf(stderr, "Erro encontrado: %s\n", msg);
    } else {
        fprintf(stderr, "\n\n\n------ERRO SINTATICO:--------\nErro encontrado na linha %d: %s\n", current_line, msg);
    }
}

void printError(){
    if(error_cnt > 0) {
        printf("\n\n\n------ERROS LEXICOS: %d--------\n", error_cnt);
        for(int i = 0; i < error_cnt; i++) {
            char* msg =  (char *)malloc(100 * sizeof(char));
            sprintf(msg, "Symbol not recognized: %c. line: %d\n", error_array[i].error_symbol, error_array[i].line);
            yyerror(msg);
        }
    }
}

%}
%option noinput nounput
EOL \n
SEP [,.;:]
OPEN_PARENTESES [(]
CLOSE_PARENTESES [)]
OPEN_CURLY [{]
CLOSE_CURLY [}]
OPEN_BRACKETS [\[]
CLOSE_BRACKETS [\]]
DIGIT [0-9]
VECTOR <(" ")*{INT}(" ")*(,(" ")*{INT}(" ")*)*>|<(" ")*{FLOAT}(" ")*(,(" ")*{FLOAT}(" ")*)*>
INT [-]?{DIGIT}+
FLOAT [-]?{DIGIT}+"."{DIGIT}*
BOOLEAN "true"|"false"
LETTER [a-zA-Z]
TYPE "int"|"float"|"char"|"vector"|"bool"|"void"
IF "if"
ELSE "else"
WHILE "while"
RETURN "return"
READ "read"
WRITE "write"
DISTANCE "distance"
NORMALIZE "normalize"
ADD "+"
SUB "-"
TIMES "*"
DIV "/"
ASSING "="
OR "||"
AND "&&"
QUOTES ["]
COMPARABLES "<="|"=="|">="|">"|"<"|"!="
ID  {LETTER}({LETTER}|{DIGIT})*

%%

{TYPE} {
    //printf("TYPE (%s) SIZE %d\n", yytext, yyleng);
    yylval.string = (char *) strdup(yytext);
    return TYPE;
}

{INT} {
    //printf("INT (%s) SIZE %d\n", yytext, yyleng );
    yylval.string = (char *) strdup(yytext);
    return INT;
}

{FLOAT} {
    //printf("FLOAT (%s) SIZE %d\n", yytext, yyleng );
    yylval.string = (char *) strdup(yytext);
    return FLOAT;
}

{VECTOR} {
    //printf("VECTOR (%s) SIZE %d\n", yytext, yyleng );
    yylval.string = (char *) strdup(yytext);
    return VECTOR;
}

{BOOLEAN} {
    //printf("BOOLEAN (%s) SIZE %d\n", yytext, yyleng );
    yylval.string = (char *) strdup(yytext);
    return BOOLEAN;
}

{IF} {
    //printf("IF (%s) SIZE %d\n", yytext, yyleng );
    yylval.string = (char *) strdup(yytext);
    return IF;
}

{ELSE} {
    //printf("ELSE (%s) SIZE %d\n", yytext, yyleng );
    yylval.string = (char *) strdup(yytext);
    return ELSE;
}

{WHILE} {
    //printf("WHILE (%s) SIZE %d\n", yytext, yyleng );
    yylval.string = (char *) strdup(yytext);
    return WHILE;
}

{RETURN} {
    //printf("RETURN (%s) SIZE %d\n", yytext, yyleng );
    yylval.string = (char *) strdup(yytext);
    return RETURN;
}

{DISTANCE} {
    //printf("DISTANCE (%s) SIZE %d\n", yytext, yyleng );
    yylval.string = (char *) strdup(yytext);
    return DISTANCE;
}

{NORMALIZE} {
    //printf("NORMALIZE (%s) SIZE %d\n", yytext, yyleng );
    yylval.string = (char *) strdup(yytext);
    return NORMALIZE;
}

{WRITE} {
    //printf("WRITE (%s) SIZE %d\n", yytext, yyleng );
    yylval.string = (char *) strdup(yytext);
    return WRITE;
}

{READ} {
    //printf("READ (%s) SIZE %d\n", yytext, yyleng );
    yylval.string = (char *) strdup(yytext);
    return READ;
}

{QUOTES} {
    //printf("QUOTES (%s)\n", yytext);
    BEGIN(STRING);
    return QUOTES;
}

{ID} {
    //printf("ID (%s), SIZE %d, symbol table address %d \n", yytext, yyleng, address );
    yylval.string = (char *) strdup(yytext);
    return ID;
}

{ADD} {
    //printf("ADD (%s) SIZE %d\n", yytext, yyleng );
    yylval.string = (char *) strdup(yytext);
    return ADD;
}

{SUB} {
    //printf("SUB (%s) SIZE %d\n", yytext, yyleng );
    yylval.string = (char *) strdup(yytext);
    return SUB;
}

{TIMES} {
    //printf("TIMES (%s) SIZE %d\n", yytext, yyleng );
    yylval.string = (char *) strdup(yytext);
    return TIMES;
}

{DIV} {
    //printf("DIV (%s) SIZE %d\n", yytext, yyleng );
    yylval.string = (char *) strdup(yytext);
    return DIV;
}

{ASSING} {
    //printf("ASSING (%s) SIZE %d\n", yytext, yyleng );
    yylval.string = (char *) strdup(yytext);
    return ASSING;
}

{OR} {
    //printf("OR (%s) SIZE %d\n", yytext, yyleng );
    yylval.string = (char *) strdup(yytext);
    return OR;
}

{AND} {
    //printf("AND (%s) SIZE %d\n", yytext, yyleng );
    yylval.string = (char *) strdup(yytext);
    return AND;
}

{COMPARABLES} {
    //printf("COMPARABLES (%s) SIZE %d\n", yytext, yyleng );
    yylval.string = (char *) strdup(yytext);
    return COMPARABLES;
}

{OPEN_PARENTESES} {
    //printf("OPEN_PARENTESES (%s) SIZE %d\n", yytext, yyleng);
    yylval.string = (char *) strdup(yytext);
    return OPEN_PARENTESES;
}

{CLOSE_PARENTESES} {
    //printf("CLOSE_PARENTESES (%s) SIZE %d\n", yytext, yyleng);
    yylval.string = (char *) strdup(yytext);
    return CLOSE_PARENTESES;
}

{OPEN_BRACKETS} {
    //printf("OPEN_BRACKETS (%s) SIZE %d\n", yytext, yyleng);
    yylval.string = (char *) strdup(yytext);
    return OPEN_BRACKETS;
}

{CLOSE_BRACKETS} {
    //printf("CLOSE_BRACKETS (%s) SIZE %d\n", yytext, yyleng);
    yylval.string = (char *) strdup(yytext);
    return CLOSE_BRACKETS;
}

{OPEN_CURLY} {
    //printf("OPEN_CURLY (%s) SIZE %d\n", yytext, yyleng);
    yylval.string = (char *) strdup(yytext);
    return OPEN_CURLY;
}

{CLOSE_CURLY} {
    //printf("CLOSE_CURLY (%s) SIZE %d\n", yytext, yyleng);
    yylval.string = (char *) strdup(yytext);
    return CLOSE_CURLY;
}

{EOL} {
    current_line++;
}

\t* {
}

" "* {
}

";" {
    return yytext[0];
}

"," {
    return yytext[0];
}

":" {
    return yytext[0];
}

"." {
    return yytext[0];
}

. {
    error_array[error_cnt].line = current_line;
    error_array[error_cnt].error_symbol = yytext[0];
    error_cnt++;
}

%%