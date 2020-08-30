# frozen_string_literal: true

require 'dry/monads'
require 'constants/direction'
require 'models/coordinate'

module Services
  class DirectionToCoordinate
    extend Dry::Monads[:maybe]

    MAPPINGS = {
      Constants::NORTH => [0, 1],
      Constants::EAST => [1, 0],
      Constants::SOUTH => [0, -1],
      Constants::WEST => [-1, 0]
    }.freeze

    class << self
      def call(direction)
        Maybe(MAPPINGS[direction]).fmap { |coord| Models::Coordinate.new(*coord) }
      end
    end
  end
end
