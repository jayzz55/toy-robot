# frozen_string_literal: true

require 'constants/command'
require 'models/coordinate'
require 'models/robot'
require 'models/obstacle'
require 'models/destination'

module Services
  class ParseInputString
    class << self
      def call(command_string, args_string)
        case command_string
        when Constants::PLACE
          x, y, direction = args_string.split(',')
          { robot: Models::Robot.new(Models::Coordinate.new(x.to_i, y.to_i), direction) }
        when Constants::PLACE_OBSTACLE
          x, y = args_string.split(',')
          obstacle = Models::Obstacle.new(Models::Coordinate.new(x.to_i, y.to_i))
          { obstacle: obstacle }
        when Constants::FIND_PATH
          x, y = args_string.split(',')
          destination = Models::Destination.new(Models::Coordinate.new(x.to_i, y.to_i))
          { destination: destination }
        else
          {}
        end
      end
    end
  end
end
