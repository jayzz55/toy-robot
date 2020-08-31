# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'models/robot'
require 'models/coordinate'
require 'constants/direction'
require 'services/rotate_direction'

module Commands
  class Left
    include Dry::Monads[:result]
    include Dry::Monads::Do.for(:call)

    attr_reader :robot

    def initialize(robot:)
      @robot = robot
    end

    def call
      new_direction = yield Services::RotateDirection
                      .call(Services::RotateDirection::LEFT, robot.direction)
                      .to_result(:invalid_direction)

      robot.direction = new_direction

      Success(robot)
    end
  end
end
