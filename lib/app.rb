# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'models/table'
require 'constants/direction'
require 'validators/command_string'
require 'validators/args_string'
require 'services/parse_input_string'
require 'services/generate_command'
require 'representers/string_representer'

class App
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  DEFAULT_TABLE = Models::Table.new

  attr_reader :table, :output, :representer
  attr_accessor :robot

  def initialize(robot: nil, table: DEFAULT_TABLE, output: $stdout, representer: Representers::StringRepresenter)
    @robot = robot
    @table = table
    @output = output
    @representer = representer
  end

  def call(input_string)
    command_string, args_string = input_string.upcase.split(' ')

    yield validate_input_string(command_string, args_string)
    yield validate_command(command_string)

    args = Services::ParseInputString.call(command_string, args_string)

    yield Services::GenerateCommand.call(command_string, self).call(**args)

    Success(self)
  end

  private

  def validate_input_string(command_string, args_string)
    Validators::CommandString.call(command_string)
                             .and(Validators::ArgsString.call(command_string, args_string))
  end

  def validate_command(command_string)
    robot.nil? && command_string != Constants::PLACE ? Failure(:missing_robot) : Success()
  end
end
