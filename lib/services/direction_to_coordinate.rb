# frozen_string_literal: true

require 'dry/monads'
require 'constants/direction'
require 'models/coordinate'

module Services
  class DirectionToCoordinate
    MAPPINGS = {
      Constants::NORTH => [0, 1],
      Constants::EAST => [1, 0],
      Constants::SOUTH => [0, -1],
      Constants::WEST => [-1, 0]
    }.freeze

    class << self
      def call(direction)
        Models::Coordinate.new(*MAPPINGS.fetch(direction, [0, 0]))
      end
    end
  end
end
