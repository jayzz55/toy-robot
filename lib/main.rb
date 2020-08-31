# frozen_string_literal: true

require 'dry/monads'
require 'app'
require 'services/with_error_handling.rb'

class Main
  class << self
    def call(output: $stdout)
      Services::WithErrorHandling.call(stdout: output) do
        App.new(stdout: output).call('MOVE 1')
      end
    end
  end
end
