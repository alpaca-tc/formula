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

      def terminal?
        false
      end
    end

    class Terminal < Node
      def terminal?
        true
      end
    end

    class Binary < Node
      attr_reader :right, :expression

      def initialize(left, expression, right)
        super(left)
        @expression = expression
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

    # FIXME: Operator毎に別クラスに切るべき？そもそもこれ、Terminalなの？
    class Operator < Terminal
      def type
        :OPERATOR
      end
    end

    ##
    # Binary classes
    ##
    class Cat < Binary
      def type
        :CAT
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
