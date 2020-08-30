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

  attr_reader :table, :stdout
  attr_accessor :robot

  def initialize(robot: nil, table: DEFAULT_TABLE, stdout: $stdout)
    @robot = robot
    @table = table
    @stdout = stdout
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
      [x.to_i, y.to_i, direction]
    else
      args_string
    end
  end

  def execute_command(command_string, args)
    case command_string
    when Constants::PLACE
      x, y, direction = args
      Commands::Place.call(x: x, y: y, direction: direction, table: table)
                     .fmap { |new_robot| self.robot = new_robot }
    when Constants::MOVE
      Commands::Move.call(robot: robot, table: table)
    when Constants::LEFT
      Commands::Left.call(robot: robot)
    when Constants::RIGHT
      Commands::Right.call(robot: robot)
    when Constants::REPORT
      Commands::Report.call(robot: robot, stdout: stdout)
    end
  end

  def validate_input_string(command_string, args_string)
    Validators::CommandString
      .call(command_string)
      .and(Validators::ArgsString.call(command_string, args_string))
  end

  def validate_command(command_string)
    robot.nil? && command_string != Constants::PLACE ? Failure(:missing_robot) : Success()
  end
end
