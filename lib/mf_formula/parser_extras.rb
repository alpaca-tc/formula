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
      @scanner.next_token
    end
  end
end
