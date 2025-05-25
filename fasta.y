%{
#include <stdio.h>

extern FILE* yyin; 
extern int yylex();
void yyerror(const char *s);

%}

%token HEADER SEQ_LINE

%%

fasta: entries { printf("Parsed complete FASTA file\n"); }
;

entries: entry { printf("Parsed single entry\n"); }
      | entries entry { printf("Parsed additional entry\n"); }
;

entry: header sequence { printf("Parsed complete entry\n"); }
;

header: HEADER { printf("Parsed header\n"); }
;

sequence: seq_line { printf("Parsed single sequence line\n"); }
       | sequence seq_line { printf("Parsed additional sequence line\n"); }
;

seq_line: SEQ_LINE { printf("Parsed sequence line\n"); }
;

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
        printf("Valid FASTA file\n");
    } else {
        printf("Invalid FASTA file\n");
    }
    fclose(file);

    return 0;
}

void yyerror(const char *s) 
{
    fprintf(stderr, "Error: %s\n", s);
}