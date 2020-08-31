# frozen_string_literal: true

module Handlers
  class StdinHandler
    include Enumerable

    attr_reader :stdin

    def initialize(stdin = $stdin)
      @stdin = stdin
    end

    def each
      while (input = stdin.gets)
        yield input.chomp
      end
    end
  end
end
