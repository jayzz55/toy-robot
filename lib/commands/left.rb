# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'models/robot'
require 'models/coordinate'
require 'constants/direction'

module Commands
  class Left
    class << self
      include Dry::Monads[:result]

      def call(robot:)
        if Constants::DIRECTIONS.index(robot.direction)
          direction_index = (Constants::DIRECTIONS.index(robot.direction) - 1) % Constants::DIRECTIONS.size

          robot.direction = Constants::DIRECTIONS[direction_index]
        end

        Success(robot)
      end
    end
  end
end
