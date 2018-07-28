# frozen_string_literal: true

#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.14
# from Racc grammer file "".
#

require 'racc/parser.rb'

require 'alpaca_formula/parser_extras'
module AlpacaFormula
  class Parser < Racc::Parser
    ##### State transition tables begin ###

    racc_action_table = [
      7, 14, 27, 11, 12, 16, 13, 6, 18, 7,
      20, 21, 11,    12,     7, 13, 6, 11, 12, 7,
      13,     6,    11,    12,     7,    13,     6,    11,    12, 7,
      13,     6,    11,    12,     7,    13,     6,    11,    12, 16,
      13,     6,    18,    16, nil, 31, 18, 29, 16, 24,
      16, 18, 16, 18, 16, 18, nil, 18
    ]

    racc_action_check = [
      0, 1, 25, 0, 0, 1, 0, 0, 1, 6,
      7, 14, 6, 6, 15,     6,     6, 15, 15, 17,
      15,    15,    17,    17,    20,    17,    17,    20,    20,    27,
      20,    20,    27,    27,    29,    27,    27,    29,    29,    30,
      29,    29,    30,    19, nil,    30, 19, 28, 28, 19,
      26,    28,    23,    26, 22, 23, nil, 22
    ]

    racc_action_pointer = [
      -2, 1, nil, nil, nil, nil, 7, 1, nil, nil,
      nil, nil, nil,   nil, 11, 12, nil, 17, nil, 39,
      22,   nil, 50, 48, nil, -1, 46, 27, 44, 32,
      35,   nil
    ]

    racc_action_default = [
      -10, -18, -1, -2, -3, -4, -10, -18, -12, -13,
      -14, -15, -16, -17, -18, -10, -8, -10, -11, -18,
      -10,    32, -7, -9, -5, -4, -18, -10, -18, -10,
      -18,    -6
    ]

    racc_goto_table = [
      1, 25, nil,   nil, nil, nil, 19, nil, nil, nil,
      nil, nil, nil, nil, nil, 22, nil, 23, nil, nil,
      26, nil, nil, nil, nil, nil, nil, 28, nil, 30
    ]

    racc_goto_check = [
      1, 5, nil, nil, nil, nil, 1, nil, nil, nil,
      nil, nil, nil, nil, nil, 1, nil, 1, nil, nil,
      1, nil, nil, nil, nil,   nil, nil, 1, nil, 1
    ]

    racc_goto_pointer = [
      nil, 0, nil, nil, nil, -19, nil, nil, nil, nil,
      nil
    ]

    racc_goto_default = [
      nil, nil, 2, 3, 4, 5, 15, 17, 8, 9,
      10
    ]

    racc_reduce_table = [
      0, 0, :racc_error,
      1, 16, :_reduce_none,
      1, 16, :_reduce_none,
      1, 16, :_reduce_none,
      1, 16, :_reduce_none,
      3, 18, :_reduce_5,
      8, 20, :_reduce_6,
      3, 20, :_reduce_7,
      1, 21, :_reduce_8,
      3, 19, :_reduce_9,
      0, 19, :_reduce_none,
      1, 22, :_reduce_11,
      1, 17, :_reduce_none,
      1, 17, :_reduce_none,
      1, 17, :_reduce_none,
      1, 24, :_reduce_15,
      1, 25, :_reduce_16,
      1, 23, :_reduce_17
    ]

    racc_reduce_n = 18

    racc_shift_n = 32

    racc_token_table = {
      false => 0,
      :error => 1,
      :IF => 2,
      :DELIMITER => 3,
      :COMPARISON_OPERATOR => 4,
      :ITEM => 5,
      :DIGIT => 6,
      :OPERATOR => 7,
      :LITERAL => 8,
      :LPAREN => 9,
      :RPAREN => 10,
      '*' => 11,
      '/' => 12,
      '+' => 13,
      '-' => 14
    }

    racc_nt_base = 15

    racc_use_result_var = false

    Racc_arg = [
      racc_action_table,
      racc_action_check,
      racc_action_default,
      racc_action_pointer,
      racc_goto_table,
      racc_goto_check,
      racc_goto_default,
      racc_goto_pointer,
      racc_nt_base,
      racc_reduce_table,
      racc_token_table,
      racc_shift_n,
      racc_reduce_n,
      racc_use_result_var
    ].freeze

    Racc_token_to_s_table = [
      '$end',
      'error',
      'IF',
      'DELIMITER',
      'COMPARISON_OPERATOR',
      'ITEM',
      'DIGIT',
      'OPERATOR',
      'LITERAL',
      'LPAREN',
      'RPAREN',
      '"*"',
      '"/"',
      '"+"',
      '"-"',
      '$start',
      'expression',
      'terminal',
      'group',
      'calculation',
      'condition',
      'compensation_operator',
      'operator',
      'literal',
      'item',
      'digit'
    ].freeze

    Racc_debug_parser = false

    ##### State transition tables end #####

    # reduce 0 omitted

    # reduce 1 omitted

    # reduce 2 omitted

    # reduce 3 omitted

    # reduce 4 omitted

    def _reduce_5(val, _values)
      Nodes::Group.new(val[1])
    end

    def _reduce_6(val, _values)
      Nodes::If.new(val[2], val[4], val[6])
    end

    def _reduce_7(val, _values)
      Nodes::Condition.new(val[0], val[1], val[2])
    end

    def _reduce_8(val, _values)
      Nodes::ComparisonOperator.new(val.first)
    end

    def _reduce_9(val, _values)
      Nodes::Cat.new(val[0], val[1], val[2])
    end

    # reduce 10 omitted

    def _reduce_11(val, _values)
      Nodes::Operator.new(val.first)
    end

    # reduce 12 omitted

    # reduce 13 omitted

    # reduce 14 omitted

    def _reduce_15(val, _values)
      Nodes::Item.new(val.first)
    end

    def _reduce_16(val, _values)
      Nodes::Digit.new(val.first)
    end

    def _reduce_17(val, _values)
      Nodes::Literal.new(val.first)
    end

    def _reduce_none(val, _values)
      val[0]
    end
  end   # class Parser
  end   # module AlpacaFormula
