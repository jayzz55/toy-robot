# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'models/robot'
require 'models/coordinate'
require 'services/direction_to_coordinate'

module Commands
  class Move
    include Dry::Monads[:result]
    include Dry::Monads::Do.for(:call)

    attr_reader :robot, :table

    def initialize(robot:, table:)
      @robot = robot
      @table = table
    end

    def call
      new_coordinate = yield Services::DirectionToCoordinate.call(robot.direction).to_result(:invalid_movement)
      new_position = robot.coordinate + new_coordinate

      if table.contain? new_position
        robot.coordinate = new_position
        Success(robot)
      else
        Failure(:invalid_movement)
      end
    end
  end
end
