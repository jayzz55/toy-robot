# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'models/table'
require 'commands/place'
require 'commands/move'
require 'commands/left'
require 'commands/right'
require 'commands/report'
require 'constants/direction'
require 'validators/command_string'
require 'validators/args_string'

class App
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  DEFAULT_TABLE = Models::Table.new

  attr_reader :table, :output
  attr_accessor :robot

  def initialize(robot: nil, table: DEFAULT_TABLE, output: $stdout)
    @robot = robot
    @table = table
    @output = output
  end

  def call(input_string)
    command_string, args_string = input_string.upcase.split(' ')

    yield validate_input_string(command_string, args_string)
    yield validate_command(command_string)

    args = parse_args(command_string, args_string)

    yield execute_command(command_string, args)

    Success(self)
  end

  private

  def parse_args(command_string, args_string)
    case command_string
    when Constants::PLACE
      x, y, direction = args_string.split(',')
      { x: x.to_i, y: y.to_i, direction: direction }
    else
      {}
    end
  end

  def execute_command(command_string, input_args)
    case command_string
    when Constants::PLACE
      x, y, direction = input_args.values_at(:x, :y, :direction)
      Commands::Place.call(x: x, y: y, direction: direction, table: table, app: self)
    when Constants::MOVE
      Commands::Move.call(robot: robot, table: table)
    when Constants::LEFT
      Commands::Left.call(robot: robot)
    when Constants::RIGHT
      Commands::Right.call(robot: robot)
    when Constants::REPORT
      Commands::Report.call(robot: robot, output: output)
    end
  end

  def validate_input_string(command_string, args_string)
    Validators::CommandString.call(command_string)
                             .and(Validators::ArgsString.call(command_string, args_string))
  end

  def validate_command(command_string)
    robot.nil? && command_string != Constants::PLACE ? Failure(:missing_robot) : Success()
  end
end
