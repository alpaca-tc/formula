# frozen_string_literal: true

module AlpacaFormula
  class Scanner
    def scan_setup(str)
      @string_scanner = StringScanner.new(str)
    end

    def eos?
      @string_scanner.eos?
    end

    def pos
      @string_scanner.pos
    end

    def pre_match
      @string_scanner.pre_match
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
      elsif @string_scanner.scan(/(?<!\\)\(/)
        [:LPAREN, @string_scanner.matched]
      elsif @string_scanner.scan(/(?<!\\)\)/)
        [:RPAREN, @string_scanner.matched]
      elsif @string_scanner.scan(/(?:[+*\/\-])(?!\d)/)
        [:OPERATOR, @string_scanner.matched]
      elsif @string_scanner.scan(/(?:[+\-])?\d+(?:\.\d*)?/)
        [:DIGIT, @string_scanner.matched]
      elsif @string_scanner.scan(/(?:[\w%\-~!$&'*+,;=@]|\\:|\\\(|\\\))+/)
        [:LITERAL, @string_scanner.matched.tr('\\', '')]
      elsif @string_scanner.scan(/./)
        # any char
        [:LITERAL, @string_scanner.matched]
      end
    end
  end
end
