# frozen_string_literal: true

module Handlers
  class StdinHandler
    EXIT = 'EXIT'

    class << self
      def call(stdin: $stdin)
        while (input = stdin.gets)
          Kernel.exit(false) if input.upcase == EXIT
          result = yield input.chomp
          Kernel.exit(false) if result == :error
        end
      end
    end
  end
end
