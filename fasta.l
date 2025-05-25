%option outfile="fastaLexer.cpp"
%option noyywrap

%{
#include <stdio.h>
#include "fastaParser.hpp"
%}

%%

^>.* { 
  return HEADER;
}

^[^>\n;]*  { 
  return SEQ_LINE; 
}

.|\n {}

%%
