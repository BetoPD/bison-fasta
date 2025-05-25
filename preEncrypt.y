%{
#include <stdio.h>

extern FILE* yyin; 
extern int yylex();
void yyerror(const char *s);

%}

%token FILE_NAME NUMERIC_PARAMS BODY_TEXT COMMA

%%

file: sections;

sections: section | sections section;

section: parameters BODY_TEXT;

parameters: FILE_NAME COMMA NUMERIC_PARAMS COMMA NUMERIC_PARAMS;

%%

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <fasta_file>\n", argv[0]);
        return 1;
    }
    FILE *file = fopen(argv[1], "r");
    if (!file) {
        fprintf(stderr, "Error: Could not open file %s\n", argv[1]);
        return 1;
    }
    yyin = file;
    if (yyparse() == 0) {
        printf("Valid file\n");
    } else {
        printf("Invalid file\n");
    }
    fclose(file);

    return 0;
}

void yyerror(const char *s) 
{
    fprintf(stderr, "Error: %s\n", s);
}