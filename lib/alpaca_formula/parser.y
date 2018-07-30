class AlpacaFormula::Parser

options no_result_var

token IF DELIMITER COMPARISON_OPERATOR ITEM DIGIT PLUS_OPERATOR MINUS_OPERATOR DEVISION_OPERATOR MULTIPLICATION_OPERATOR LPAREN RPAREN

prechigh
  left MULTIPLICATION_OPERATOR DEVISION_OPERATOR
  left PLUS_OPERATOR MINUS_OPERATOR
preclow

rule
  expression:
    | terminal
    | group
    | calculation
    | if_statement
  group:
    | LPAREN expression RPAREN             { Nodes::Group.new(val[1]) }
  if_statement:
    | IF LPAREN condition DELIMITER expression DELIMITER expression RPAREN { Nodes::If.new(val[2], val[4], val[6]) }
  condition:
    | expression compensation_operator expression { Nodes::Condition.new(val[1], val[0], val[2]) }
  compensation_operator: # 四則演算みたく、分割すべき？
    | COMPARISON_OPERATOR                { Nodes::ComparisonOperator.new(val.first) }
  calculation:
    | expression PLUS_OPERATOR expression      { Nodes::PlusOperation.new(val[0], val[2]) }
    | expression MINUS_OPERATOR expression      { Nodes::MinusOperation.new(val[0], val[2]) }
    | expression DEVISION_OPERATOR expression      { Nodes::DevisionOperation.new(val[0], val[2]) }
    | expression MULTIPLICATION_OPERATOR expression      { Nodes::MultiplicationOperation.new(val[0], val[2]) }
  terminal:
    | item
    | digit
  item:
    | ITEM                                  { Nodes::Item.new(val.first) }
  digit:
    | DIGIT                                 { Nodes::Digit.new(val.first) }
    | PLUS_OPERATOR DIGIT                   { Nodes::Digit.new(val.last) }
    | MINUS_OPERATOR DIGIT                  { Nodes::Digit.new("-#{val.last}") }
end

---- header

require 'alpaca_formula/parser_extras'
