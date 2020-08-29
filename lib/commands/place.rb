# frozen_string_literal: true

require 'dry/monads'
require 'models/robot'
require 'models/coordinate'

module Commands
  class Place
    extend Dry::Monads[:result]

    class << self
      def call(x_coord:, y_coord:, direction:, table:)
        position = Models::Coordinate.new(x_coord, y_coord)

        if table.contain? position
          robot = Models::Robot.new(
            position,
            direction
          )
          Success(robot)
        else
          Failure(:invalid_placement)
        end
      end
    end
  end
end
