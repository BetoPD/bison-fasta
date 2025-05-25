%option outfile="preEncryptLexer.cpp"
%option noyywrap
%x PARAMS

%{
#include <stdio.h>
#include "preEncryptParser.hpp"
%}

%%

^"#" {
    BEGIN(PARAMS);
}


<PARAMS>[a-zA-Z]+[0-9]*".fasta" {
    return FILE_NAME;
}

<PARAMS>"," {
    return COMMA;
}

<PARAMS>[0-9]+ {
    return NUMERIC_PARAMS;
}

<PARAMS>\n {
    BEGIN(INITIAL);
}

([^#]|\n)+ {
    return BODY_TEXT;
}

%%