# frozen_string_literal: true

require 'constants/command'
require 'commands/place'
require 'commands/move'
require 'commands/left'
require 'commands/right'
require 'commands/report'

module Services
  class GenerateCommand
    class << self
      def call(command_string, app)
        case command_string
        when Constants::PLACE
          Commands::Place.new(table: app.table, app: app)
        when Constants::MOVE
          Commands::Move.new(robot: app.robot, table: app.table)
        when Constants::LEFT
          Commands::Left.new(robot: app.robot)
        when Constants::RIGHT
          Commands::Right.new(robot: app.robot)
        when Constants::REPORT
          Commands::Report.new(robot: app.robot, output: app.output)
        end
      end
    end
  end
end
