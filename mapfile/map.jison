/* lexical grammar */
%lex
%%

\s+                     /* skip whitespace */
\n|\r\n                 /* skip whitespace */
"NAME"                  return "NAME"
"LAYER"                 return "LAYER"
"END"                   return "END"
'"'("\\"["]|[^"])*'"'	  return 'STRING'
[a-zA-Z]+               return 'WORD'
[0-9]+("."[0-9]+)?      return 'NUMBER'
<<EOF>>                 return 'EOF'
.                       return 'INVALID'

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
  LAYER decl END
  {$$ = {layer: $2}}
  ;

decl:
  NAME STRING
  {$$ = $2.substring(1, $2.length - 1)};
