# frozen_string_literal: true

require 'dry/monads'

module Services
  class WithErrorHandling
    class << self
      include Dry::Monads[:try]

      # rubocop:disable Metrics/MethodLength
      def call(stdout: $stdout)
        result = Try { yield }.to_result.flatten
        return :ok if result.success?

        case result.failure
        when :invalid_placement
          stdout.puts 'Sorry, Placement is invalid.'
        when :invalid_movement
          stdout.puts 'Sorry, it is impossible to move.'
        when :invalid_direction
          stdout.puts 'Something is wrong with the direction.'
        when :missing_robot
          stdout.puts 'No Robot Found! Need to PLACE a robot first.'
        when :invalid_input
          stdout.puts 'Sorry, provided input is invalid.'
        else
          stdout.puts 'Oops, this is embarassing, some unexpected error has occured.'
        end

        :error
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
