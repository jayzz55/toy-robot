# frozen_string_literal: true

require 'dry/monads'
require 'constants/direction'
require 'models/coordinate'

require 'dry/monads'
require 'dry/monads/do'

module Services
  class RotateDirection
    LEFT = 'LEFT'
    RIGHT = 'RIGHT'

    class << self
      include Dry::Monads[:maybe]
      include Dry::Monads::Do.for(:call)

      def call(rotation_direction, direction)
        index_offset = yield maybe_index_offset(rotation_direction)
        direction_index = yield maybe_direction_index(direction)

        Some(Constants::DIRECTIONS[(direction_index + index_offset) % Constants::DIRECTIONS.size])
      end

      private

      def maybe_index_offset(rotation_direction)
        Maybe({ LEFT => -1, RIGHT => 1 }[rotation_direction])
      end

      def maybe_direction_index(direction)
        Maybe(Constants::DIRECTIONS.index(direction))
      end
    end
  end
end
