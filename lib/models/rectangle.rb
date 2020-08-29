# frozen_string_literal: true

require 'models/coordinate'

module Models
  class Rectangle
    attr_reader :coordinate, :height, :width

    DEFAULT_COORDINATE = Models::Coordinate.new(0, 0)
    DEFAULT_WIDTH = 5
    DEFAULT_HEIGHT = 5

    def initialize(coordinate = DEFAULT_COORDINATE, width = DEFAULT_WIDTH, height = DEFAULT_HEIGHT)
      @coordinate = coordinate
      @height = height
      @width = width
    end

    def coordinates
      @coordinates ||= (coordinate.x..max_width_point).flat_map do |x_point|
        (coordinate.y..max_height_point).map do |y_point|
          Models::Coordinate.new(x_point, y_point)
        end
      end
    end

    private

    def max_width_point
      coordinate.x + width - 1
    end

    def max_height_point
      coordinate.y + height - 1
    end
  end
end
