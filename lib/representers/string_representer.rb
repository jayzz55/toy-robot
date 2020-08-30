# frozen_string_literal: true

module Representers
  class StringRepresenter
    class << self
      def call(robot)
        "Output: #{robot.coordinate.x},#{robot.coordinate.y},#{robot.direction}"
      end
    end
  end
end
