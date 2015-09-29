/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)+    return 'PRICE'
[0-9]+                return 'COUNT'
"imported"            return 'IMPORTED'
"at"                  return 'AT'
"of"                  return 'OF'
[a-zA-Z]+             return 'WORD'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

%start expressions

%% /* language grammar */

expressions
    : simple EOF
        { typeof console !== 'undefined' ? console.log($1) : print($1);
          return $1; }
    ;

simple: COUNT WORD AT PRICE
  {$$ = {count: $1, product: $2, price: $4}}
  ;
