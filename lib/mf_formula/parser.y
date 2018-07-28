class MfFormula::Parser

options no_result_var

token ITEM DIGIT OPERATOR LITERAL LPAREN RPAREN

prechigh
  left '*' '/'
  left '+' '-'
preclow

rule
  expressions
    : expression expressions                { Nodes::Cat.new(val.first, val.last) }
    | expression                            { val.first }
    ;
  expression
    : terminal
    | group
    | calculation
    ;
  group
    : LPAREN expressions RPAREN             { Nodes::Group.new(val[1]) }
    ;
  calculation
    : expressions operator expressions      { Nodes::Cat.new(val[0], val[1], val[2]) }
    |
  operator
    : OPERATOR                              { Nodes::Operator.new(val.first) }
    ;
  terminal
    : literal
    | item
    | digit
    ;
  item
    : ITEM                                  { Nodes::Item.new(val.first) }
    ;
  digit
    : DIGIT                                 { Nodes::Digit.new(val.first) }
    ;
  literal
    : LITERAL                               { Nodes::Literal.new(val.first) }
    ;
end

---- header

require 'mf_formula/parser_extras'
