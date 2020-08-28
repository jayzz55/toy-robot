# frozen_string_literal: true

module Models
  class Table
    attr_accessor :coordinate, :width, :height

    def initialize(coordinate, width, height)
      @coordinate = coordinate
      @width = width
      @height = height
    end
  end
end
