class AlpacaFormula::Parser

options no_result_var

token IF DELIMITER COMPARISON_OPERATOR ITEM DIGIT OPERATOR LITERAL LPAREN RPAREN

prechigh
  left '*' '/'
  left '+' '-'
preclow

rule
  expression
    : terminal
    | group
    | calculation
    | condition
    ;
  group
    : LPAREN expression RPAREN             { Nodes::Group.new(val[1]) }
    ;
  condition
    : IF LPAREN condition DELIMITER expression DELIMITER expression RPAREN { Nodes::If.new(val[2], val[4], val[6]) }
  condition
    : expression compensation_operator expression { Nodes::Condition.new(val[0], val[1], val[2]) }
    ;
  compensation_operator
    : COMPARISON_OPERATOR                { Nodes::ComparisonOperator.new(val.first) }
    ;
  calculation
    : expression operator expression      { Nodes::Cat.new(val[0], val[1], val[2]) }
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

require 'alpaca_formula/parser_extras'
