# frozen_string_literal: true

require 'dry/monads'
require 'constants/direction'
require 'models/coordinate'

module Services
  class RotateDirection
    LEFT = 'LEFT'
    RIGHT = 'RIGHT'

    class << self
      def call(rotation_direction, direction)
        if directions.index(direction)
          direction_index = (directions.index(direction) + index_offset(rotation_direction)) % directions.size

          directions[direction_index]
        else
          direction
        end
      end

      private

      def directions
        Constants::DIRECTIONS
      end

      def index_offset(rotation_direction)
        case rotation_direction
        when LEFT
          -1
        when RIGHT
          1
        end
      end
    end
  end
end
