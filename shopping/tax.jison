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
'"'("\\"["]|[^"])*'"'	return 'STRING'
[a-zA-Z]+             return 'WORD'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

%start expressions

%% /* language grammar */

expressions
    : statements EOF
        { return $1; }
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

statement: simple
  | with_quantity
  | with_imported
  | with_imported2
  ;

simple: COUNT words AT PRICE
  {
    $$ = {
      count: parseInt($1),
      product: $2,
      price: parseFloat($4)
    }
  };

with_quantity: COUNT words OF words AT PRICE
  {
    $$ = {
      count: parseInt($1),
      quantity: $2,
      product: $4,
      price: parseFloat($6)
    }
  };

with_imported: COUNT IMPORTED words OF words AT PRICE
  {
    $$ = {
      count: parseInt($1),
      type: "imported",
      quantity: $3,
      product: $5,
      price: parseFloat($7)
    }
  };

with_imported2: COUNT words OF IMPORTED words AT PRICE
  {
    $$ = {
      count: parseInt($1),
      type: "imported",
      quantity: $2,
      product: $5,
      price: parseFloat($7)
    }
  };

words:
  STRING
  {$$ = $1.substring(1, $1.length - 1);}
  | WORD
  {$$ = $1;}
  ;
