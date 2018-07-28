# frozen_string_literal: true

module MfFormula
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

    def skip_token?(token)
      # 空白はいらないので消す
      token[0] == :LITERAL && token[1] == ' '
    end
  end
end
