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

    def visit_CAT(node)
      case node.expression.left
      when '/'
        visit(node.left) / visit(node.right)
      when '*'
        visit(node.left) * visit(node.right)
      when '+'
        visit(node.left) + visit(node.right)
      when '-'
        visit(node.left) - visit(node.right)
      else
        raise NotImplementedError, "unknown expression given (#{node.expression.left})"
      end
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
  end
end
