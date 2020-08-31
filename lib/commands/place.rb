# frozen_string_literal: true

require 'dry/monads'
require 'models/robot'
require 'models/coordinate'

module Commands
  class Place
    include Dry::Monads[:result]

    attr_reader :table, :app

    def initialize(table:, app:)
      @table = table
      @app = app
    end

    def call(robot:)
      if table.contain? robot.coordinate
        app.robot = robot
        Success(robot)
      else
        Failure(:invalid_placement)
      end
    end
  end
end
