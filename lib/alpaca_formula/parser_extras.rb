# frozen_string_literal: true

module AlpacaFormula
  class Parser < Racc::Parser
    def self.parse(string)
      new.parse(string)
    end

    def initialize
      @scanner = Scanner.new
    end

    def parse(string)
      @scanner.scan_setup(string)
      do_parse
    end

    def next_token
      return if @scanner.eos?

      loop do
        token = @scanner.next_token
        return if token.nil?

        return token unless skip_token?(token)
      end
    end

    private

    # 空白はいらないので消す
    def skip_token?((symbol, _value))
      symbol == :SPACE
    end
  end
end
