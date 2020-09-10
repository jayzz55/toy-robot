# frozen_string_literal: true

module Representers
  class TableRepresenter
    class << self
      def call(robot, table)

        canvas_width = table.coordinate.x + table.shape.width
        canvas_height = table.coordinate.y + table.shape.height

        (canvas_height.downto(0)).map do |y|
          (0.upto(canvas_width)).map do |x|
            if robot.coordinate == Models::Coordinate.new(x, y)
              case robot.direction
              when Constants::NORTH
                '^'
              when Constants::EAST
                '>'
              when Constants::SOUTH
                'v'
              when Constants::WEST
                '<'
              end
            elsif table.coordinates.include? Models::Coordinate.new(x, y)
              '.'
            else
              ''
            end
          end.join('')
        end.join("\n").strip
      end
    end
  end
end
