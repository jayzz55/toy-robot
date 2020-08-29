# frozen_string_literal: true

require 'models/rectangle'

module Models
  class Table
    attr_reader :shape

    DEFAULT_SHAPE = Models::Rectangle.new

    def initialize(shape = DEFAULT_SHAPE)
      @shape = shape
    end

    def contain?(point)
      shape.coordinates.include? point
    end
  end
end
