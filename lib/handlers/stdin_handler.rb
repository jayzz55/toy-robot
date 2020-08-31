# frozen_string_literal: true

module Handlers
  class StdinHandler
    EXIT = 'EXIT'

    class << self
      def call(stdin: $stdin, kernel: Kernel)
        puts '#################################'
        puts 'Available Commands:'
        puts '* PLACE 0,0,NORTH'
        puts '* MOVE'
        puts '* LEFT'
        puts '* RIGHT'
        puts '* REPORT'
        puts 'Type "exit" to exit the app.'
        puts '#################################'

        while (input = stdin.gets)
          kernel.exit(false) if input.chomp.upcase == EXIT
          result = yield input.chomp
        end
      end
    end
  end
end
