# frozen_string_literal: true

module Models
  Coordinate = Struct.new(:x, :y) do
    def +(other)
      Coordinate.new(x + other.x, y + other.y)
    end
  end
end
