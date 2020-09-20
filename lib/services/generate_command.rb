# frozen_string_literal: true

require 'constants/command'
require 'commands/place'
require 'commands/move'
require 'commands/left'
require 'commands/right'
require 'commands/report'
require 'commands/place_obstacle'
require 'commands/find_path'

module Services
  class GenerateCommand
    class << self
      def call(command_string, app)
        case command_string
        when Constants::PLACE
          Commands::Place.new(table: app.table, app: app)
        when Constants::PLACE_OBSTACLE
          Commands::PlaceObstacle.new(table: app.table, app: app)
        when Constants::FIND_PATH
          Commands::FindPath.new(app: app)
        when Constants::MOVE
          Commands::Move.new(robot: app.robot, table: app.table, obstacles: app.obstacles)
        when Constants::LEFT
          Commands::Left.new(robot: app.robot)
        when Constants::RIGHT
          Commands::Right.new(robot: app.robot)
        when Constants::REPORT
          Commands::Report.new(robot: app.robot, output: app.output, representer: app.representer)
        end
      end
    end
  end
end
