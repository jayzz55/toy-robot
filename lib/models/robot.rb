# frozen_string_literal: true

module Models
  class Robot
    attr_accessor :coordinate, :direction

    def initialize(coordinate, direction)
      @coordinate = coordinate
      @direction = direction
    end
  end
end
