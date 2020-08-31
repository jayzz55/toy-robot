# frozen_string_literal: true

require 'dry/monads'
require 'models/robot'
require 'models/coordinate'

module Commands
  class Place
    extend Dry::Monads[:result]

    class << self
      def call(x:, y:, direction:, table:, app:)
        position = Models::Coordinate.new(x, y)

        if table.contain? position
          robot = Models::Robot.new(
            position,
            direction
          )
          app.robot = robot
          Success(robot)
        else
          Failure(:invalid_placement)
        end
      end
    end
  end
end
