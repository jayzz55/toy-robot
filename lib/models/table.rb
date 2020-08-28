# frozen_string_literal: true

require 'models/coordinate'

module Models
  class Table
    attr_reader :coordinate, :height, :width

    def initialize(coordinate, width, height)
      @coordinate = coordinate
      @height = height
      @width = width
    end

    def coordinates
      @coordinates ||= [
        coordinate,
        coordinate + Models::Coordinate.new(width_point, 0),
        coordinate + Models::Coordinate.new(0, height_point),
        coordinate + Models::Coordinate.new(width_point, height_point)
      ]
    end

    private

    def width_point
      width - 1
    end

    def height_point
      height - 1
    end
  end
end
