# frozen_string_literal: true

module Models
  class Robot
    attr_accessor :coordinate, :direction

    def initialise(coordinate, direction)
      @coordinate = coordinate
      @direciton = direction
    end
  end
end
