# frozen_string_literal: true

require 'dry/monads'
require 'models/obstacle'
require 'models/coordinate'

module Commands
  class PlaceObstacle
    include Dry::Monads[:result]

    attr_reader :table, :app

    def initialize(table:, app:)
      @table = table
      @app = app
    end

    def call(obstacle:)
      if table.contain?(obstacle.coordinate) &&
          obstacle.coordinate != app.robot.coordinate &&
          !app.obstacles.map(&:coordinate).include?(obstacle.coordinate)

        app.obstacles << obstacle
        Success(obstacle)
      else
        Failure(:invalid_placement)
      end
    end
  end
end
