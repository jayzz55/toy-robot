# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'models/robot'
require 'models/coordinate'
require 'constants/direction'
require 'services/rotate_direction'

module Commands
  class Left
    class << self
      include Dry::Monads[:result]

      def call(robot:)
        new_direction = Services::RotateDirection.call(Services::RotateDirection::LEFT, robot.direction)

        robot.direction = new_direction unless robot.direction == new_direction

        Success(robot)
      end
    end
  end
end
