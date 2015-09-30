/* lexical grammar */

%lex
%%

\s+                     /* skip whitespace */
\n|\r\n                 /* skip whitespace */
"NAME"                  return "NAME"
"DATA"                  return "DATA"
"STATUS"                return "STATUS"
"TYPE"                  return "TYPE"
"TRANSPARENCY"          return "TRANSPARENCY"
"CLASS"                 return "CLASS"
"STYLE"                 return "STYLE"
"COLOR"                 return "COLOR"
"OUTLINECOLOR"          return "OUTLINECOLOR"
"LAYER"                 return "LAYER"
"END"                   return "END"
'"'("\\"["]|[^"])*'"'	  return 'STRING'
[a-zA-Z]+               return 'WORD'
[0-9]+("."[0-9]+)?      return 'NUMBER'
<<EOF>>                 return 'EOF'
.                       return 'INVALID'

/lex

%{
  function colorString(r, g, b) {
      return "rgb(" +r+ "," +g+ "," +b+ ")";
  }

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
        console.log($1);
        return $1;
        }
    ;

decls:
  LAYER pairs END {$$ = {layer: $2}}
  ;

pairs:
  pair {$$ = $1}
  |
  pairs pair {$$ = merge($1, $2)}
  ;

pair:
  NAME STRING
  {$$ = {name: $2.substring(1, $2.length - 1)}}
  | DATA STRING
  {$$ = {data: $2.substring(1, $2.length - 1)}}
  | STATUS STRING
  {$$ = {status: $2.substring(1, $2.length - 1)}}
  | TYPE STRING
  {$$ = {type: $2.substring(1, $2.length - 1)}}
  | COLOR NUMBER NUMBER NUMBER
  {$$ = {color: colorString($2, $3, $4)}}
  | OUTLINECOLOR NUMBER NUMBER NUMBER
  {$$ = {outlineColor: colorString($2, $3, $4)}}
  | TRANSPARENCY NUMBER
  {$$ = {type: parseInt($2)}}
  | styles
  {$$ = $1}
  | classes
  {$$ = $1};

styles:
  STYLE pairs END
  {$$ = {style: $2}}
  ;

classes:
  CLASS pairs END
  {$$ = {class: $2}}
  ;
