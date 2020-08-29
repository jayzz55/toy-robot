# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'models/robot'
require 'models/coordinate'
require 'services/direction_to_coordinate'

module Commands
  class Move
    class << self
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      def call(robot:, table:)
        new_position = robot.coordinate + Services::DirectionToCoordinate.call(robot.direction)

        if table.contain? new_position
          robot.coordinate = new_position
          Success(robot)
        else
          Failure(:invalid_movement)
        end
      end
    end
  end
end
