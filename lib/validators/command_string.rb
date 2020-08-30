# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'constants/command'
require 'constants/direction'

module Validators
  class CommandString
    class << self
      include Dry::Monads[:maybe, :result]
      include Dry::Monads::Do.for(:call)

      def call(command_string)
        command = yield Maybe(command_string).to_result(:invalid_input)
        yield validate_command(command)
        Success(command_string)
      end

      private

      def validate_command(command)
        if Constants::COMMANDS.include?(command.upcase)
          Success(command)
        else
          Failure(:invalid_input)
        end
      end
    end
  end
end
