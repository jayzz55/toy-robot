# frozen_string_literal: true

require 'dry/monads'
require 'app'
require 'handlers/with_error_handling.rb'
require 'handlers/stdin_handler.rb'

class Main
  class << self
    def call(input_handler: Handlers::StdinHandler, output: $stdout)
      app = App.new(output: output)
      input_handler.call do |input_line|
        Handlers::WithErrorHandling.call(output: output) do
          app.call(input_line)
        end
      end
    end
  end
end
