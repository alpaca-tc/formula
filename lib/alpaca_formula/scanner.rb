# frozen_string_literal: true

# rubocop:disable all
module AlpacaFormula
  class Scanner
    def scan_setup(str)
      @string_scanner = StringScanner.new(str)
    end

    def eos?
      @string_scanner.eos?
    end

    def next_token
      return if @string_scanner.eos?
      until token = scan || @string_scanner.eos?
        # Do nothing
      end

      token
    end

    private

    def scan
      if @string_scanner.scan(/(?:\p{Hiragana}|\p{Katakana}|[一-龠々]|[（）])+/)
        [:ITEM, @string_scanner.matched]
      elsif @string_scanner.scan(/(?<!\\)IF/)
        [:IF, @string_scanner.matched]
      elsif @string_scanner.scan(/(?<!\\),/)
        [:DELIMITER, @string_scanner.matched]
      elsif @string_scanner.scan(/(?<!\\)\(/)
        [:LPAREN, @string_scanner.matched]
      elsif @string_scanner.scan(/(?<!\\)\)/)
        [:RPAREN, @string_scanner.matched]
      elsif @string_scanner.scan(/(?:(?:[+\-])(?!\d)|[*\/])/)
        [:OPERATOR, @string_scanner.matched]
      elsif @string_scanner.scan(/(==|!=|>|<|>=|<=)/)
        [:COMPARISON_OPERATOR, @string_scanner.matched]
      elsif @string_scanner.scan(/(?:[+\-])?\d+(?:\.\d*)?/)
        [:DIGIT, @string_scanner.matched]
      elsif @string_scanner.scan(/\s+/)
        [:SPACE, @string_scanner.matched]
      elsif @string_scanner.scan(/./)
        [:LITERAL, @string_scanner.matched]
      end
    end
  end
end
# rubocop:enable all
