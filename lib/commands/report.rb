# frozen_string_literal: true

require 'dry/monads'
require 'models/robot'
require 'representers/string_representer'

module Commands
  class Report
    include Dry::Monads[:result]

    attr_reader :robot, :representer, :output

    def initialize(robot:, representer: Representers::StringRepresenter, output: $stdout)
      @robot = robot
      @representer = representer
      @output = output
    end

    def call
      output.puts representer.call(robot)
      Success()
    end
  end
end
