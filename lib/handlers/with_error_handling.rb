# frozen_string_literal: true

require 'dry/monads'

module Handlers
  class WithErrorHandling
    class << self
      include Dry::Monads[:try]

      # rubocop:disable Metrics/MethodLength
      def call(output: $stdout)
        result = Try { yield }.to_result.flatten
        binding.pry if result.failure?
        return :ok if result.success?

        case result.failure
        when :invalid_placement
          output.puts 'Sorry, Placement is invalid.'
        when :invalid_movement
          output.puts 'Sorry, it is impossible to move.'
        when :invalid_direction
          output.puts 'Something is wrong with the direction.'
        when :missing_robot
          output.puts 'No Robot Found! Need to PLACE a robot first.'
        when :invalid_input
          output.puts 'Sorry, provided input is invalid.'
        else
          output.puts 'Oops, this is embarassing, some unexpected error has occured.'
        end

        :error
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
