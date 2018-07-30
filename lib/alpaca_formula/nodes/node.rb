# frozen_string_literal: true

module AlpacaFormula
  module Nodes
    ##
    # Abstract classes
    ##
    class Node
      include Enumerable

      attr_reader :left

      def initialize(left)
        @left = left
      end

      def type
        raise NotImplementedError
      end
    end

    class Terminal < Node
    end

    class Branch < Node
      attr_reader :condition, :right

      def initialize(condition, left, right)
        super(left)
        @condition = condition
        @right = right
      end
    end

    class Binary < Node
      attr_reader :right

      def initialize(left, right)
        super(left)
        @right = right
      end

      def children
        [left, right]
      end
    end

    class ConditionOperator < Node
      attr_reader :operator, :right

      def initialize(operator, left, right)
        super(left)
        @operator = operator
        @right = right
      end

      def children
        [left, right]
      end
    end

    class Unary < Node
      def children
        [left]
      end
    end

    ##
    # Terminal classes
    ##
    class Literal < Terminal
      def type
        :LITERAL
      end
    end

    class Digit < Terminal
      def type
        :DIGIT
      end
    end

    class Item < Terminal
      attr_reader :item_name

      # 基本給とか、そういうのを入れる
      BUILD_IN_NAMES = %w[].freeze

      def initialize(left)
        super
        @item_name = left
      end

      def build_in?
        BUILD_IN_NAMES.include?(item_name)
      end

      def user_defined?
        !build_in?
      end

      def type
        :ITEM
      end
    end

    # FIXME: ComparisonOperator毎に別クラスに切るべき？そもそもこれ、Terminalなの？
    class ComparisonOperator < Terminal
      def type
        :COMPARISON_OPERATOR
      end
    end

    ##
    # Binary classes
    ##
    class MultiplicationOperation < Binary
      def type
        :MULTIPLICATION_OPERATION
      end
    end

    class DevisionOperation < Binary
      def type
        :DEVISION_OPERATION
      end
    end

    class MinusOperation < Binary
      def type
        :MINUS_OPERATION
      end
    end

    class PlusOperation < Binary
      def type
        :PLUS_OPERATION
      end
    end

    class Condition < ConditionOperator
      def type
        :CONDITION
      end
    end

    class If < Branch
      def type
        :IF
      end
    end

    ##
    # Unary classes
    ##
    class Group < Unary
      def type
        :GROUP
      end
    end
  end
end
