%{
#include <stdio.h>
#include <cstdlib>
#include <string.h>

extern FILE* yyin; 
extern int yylex();
void yyerror(const char *s);

%}

%union {
    int number;
    char* name;
}

%token FILE_NAME NUMERIC_PARAMS BODY_TEXT COMMA

%type <number> NUMERIC_PARAMS
%type <name> FILE_NAME

%%

file: sections;

sections: section | sections section;

section: parameters BODY_TEXT {
    printf("Found section with parameters\n");
};

parameters: FILE_NAME COMMA NUMERIC_PARAMS COMMA NUMERIC_PARAMS {
    if ($3 <= 0 || $5 <= 0) {
        yyerror("Numeric parameters must be greater than 0");
    }
    printf("Processed parameters: %s, %d, %d\n", $1, $3, $5);
    free($1);  
};

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
    exit(1);
}