# frozen_string_literal: true

module MfFormula
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

      # rubocop:disable Lint/AssignmentInCondition
      until token = scan || @string_scanner.eos?
        # Do nothing
      end
      # rubocop:enable Lint/AssignmentInCondition

      token
    end

    private

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/PerceivedComplexity
    def scan
      if @string_scanner.scan(%r{/})
        [:SLASH, @string_scanner.matched]
      elsif @string_scanner.scan(/\*\w+/)
        [:STAR, @string_scanner.matched]
      elsif @string_scanner.scan(/(?<!\\)\(/)
        [:LPAREN, @string_scanner.matched]
      elsif @string_scanner.scan(/(?<!\\)\)/)
        [:RPAREN, @string_scanner.matched]
      elsif @string_scanner.scan(/\|/)
        [:OR, @string_scanner.matched]
      elsif @string_scanner.scan(/\./)
        [:DOT, @string_scanner.matched]
      elsif @string_scanner.scan(/(?<!\\):\w+/)
        [:SYMBOL, @string_scanner.matched]
      elsif @string_scanner.scan(/(?:[\w%\-~!$&'*+,;=@]|\\:|\\\(|\\\))+/)
        [:LITERAL, @string_scanner.matched.tr('\\', '')]
        # any char
      elsif @string_scanner.scan(/./)
        [:LITERAL, @string_scanner.matched]
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/PerceivedComplexity
  end
end
