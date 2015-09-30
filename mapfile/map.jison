/* lexical grammar */
%lex
%%

\s+                    /* skip whitespace */
\n|\r\n                 /* skip whitespace */
"MAP"                   return "MAP"
"LAYER"                 return "LAYER"
"END"                   return "END"
"*"                   return "MULTIPLE"
"/"                   return "DIVIDE"
"("                   return "LP"
")"                   return "RP"
[0-9]+("."[0-9]+)?    return 'NUMBER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

%start expressions

%% /* language grammar */

expressions
    : decls EOF
        {
        typeof console !== 'undefined' ? console.log($1) : print($1);
        return $1;
        }
    ;

decls:
  LAYER END
  {$$ = {layer: null}}
  ;
