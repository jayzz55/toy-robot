# frozen_string_literal: true

require 'models/rectangle'

module Models
  class Table
    DEFAULT_SHAPE = Models::Rectangle.new

    def self.default_from(width:, height:)
      new(
        Models::Rectangle.new(
          Models::Rectangle::DEFAULT_COORDINATE,
          width,
          height
        )
      )
    end

    attr_reader :shape

    def initialize(shape = DEFAULT_SHAPE)
      @shape = shape
    end

    def contain?(point)
      shape.coordinates.include? point
    end
  end
end
