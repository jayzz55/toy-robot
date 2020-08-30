# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'models/robot'
require 'models/coordinate'
require 'constants/direction'

module Commands
  class Right
    class << self
      include Dry::Monads[:result]

      def call(robot:)
        new_direction = Services::RotateDirection.call(Services::RotateDirection::RIGHT, robot.direction)

        robot.direction = new_direction unless robot.direction == new_direction

        Success(robot)
      end
    end
  end
end
