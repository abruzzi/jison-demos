/* lexical grammar */

%lex
%%

\s+                     /* skip whitespace */
\n|\r\n                 /* skip whitespace */
"NAME"                  return "NAME"
"DATA"                  return "DATA"
"LAYER"                 return "LAYER"
"END"                   return "END"
'"'("\\"["]|[^"])*'"'	  return 'STRING'
[a-zA-Z]+               return 'WORD'
[0-9]+("."[0-9]+)?      return 'NUMBER'
<<EOF>>                 return 'EOF'
.                       return 'INVALID'

/lex

%{
  function merge(o1, o2) {
    var obj = {};

    for(var k in o1) {
      obj[k] = o1[k];
    }
    for(var v in o2) {
      obj[v] = o2[v];
    }

    return obj;
  }
%}

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
  LAYER pairs END
  {$$ = {layer: $2}}
  ;

pairs:
  pair
  {$$ = $1}
  |
  pairs pair
  {$$ = merge($1, $2)}
  ;

pair:
  NAME STRING
  {$$ = {name: $2.substring(1, $2.length - 1)}}
  | DATA STRING
  {$$ = {data: $2.substring(1, $2.length - 1)}};
