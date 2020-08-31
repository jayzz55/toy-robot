# frozen_string_literal: true

require 'constants/command'
require 'models/coordinate'
require 'models/robot'

module Services
  class ParseInputString
    class << self
      def call(command_string, args_string)
        case command_string
        when Constants::PLACE
          x, y, direction = args_string.split(',')
          { robot: Models::Robot.new(Models::Coordinate.new(x.to_i, y.to_i), direction) }
        else
          {}
        end
      end
    end
  end
end
