/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
\n                    return 'NEWLINE'
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
    : statements EOF
        { typeof console !== 'undefined' ? console.log($1) : print($1);
          return $1; }
    ;

statements:
  statement
  {$$ = $1}
  | statements statement
  {
    if($1 instanceof Array) {
      $1.push($2);
      $$ = $1;
    } else {
      var result = [];
      result.push($1);
      result.push($2);
      $$ = result;
    }
  }
  ;

statement: COUNT words AT PRICE
  {$$ = {count: parseInt($1), product: $2, price: parseFloat($4)}}
  ;

words:
  WORD
  {$$ = $1;}
  | words WORD
  {$$ = $1 + $2;}
  ;
