# frozen_string_literal: true

require 'bigdecimal'

module AlpacaFormula
  class Visitor
    def initialize(context)
      @context = context
    end

    def accept(node)
      visit(node)
    end

    private

    attr_reader :context

    def visit(node)
      send("visit_#{node.type}", node)
    end

    def visit_PLUS_OPERATION(node)
      visit(node.left) + visit(node.right)
    end

    def visit_MINUS_OPERATION(node)
      visit(node.left) - visit(node.right)
    end

    def visit_DEVISION_OPERATION(node)
      visit(node.left) / visit(node.right)
    end

    def visit_MULTIPLICATION_OPERATION(node)
      visit(node.left) * visit(node.right)
    end

    def visit_GROUP(node)
      visit(node.left)
    end

    def visit_ITEM(node)
      context.item_value(node)
    end

    def visit_DIGIT(node)
      BigDecimal(node.left)
    end

    def visit_IF(node)
      if visit(node.condition)
        visit(node.left)
      else
        visit(node.right)
      end
    end

    def visit_CONDITION(node)
      left = visit(node.left)
      right = visit(node.right)

      case node.operator.left
      when '<'
        left < right
      when '>'
        left > right
      when '<='
        left <= right
      when '>='
        left >= right
      when '=='
        left == right
      when '!='
        left != right
      else
        raise NotImplementedError, "unknown expression given (#{node.operator.left})"
      end
    end
  end
end
