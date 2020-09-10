# frozen_string_literal: true

require 'dry/monads'
require 'models/robot'
require 'representers/string_representer'

module Commands
  class Report
    include Dry::Monads[:result]

    attr_reader :robot, :representer, :output, :table

    def initialize(robot:, representer: Representers::StringRepresenter, output: $stdout, table:)
      @robot = robot
      @representer = representer
      @output = output
      @table = table
    end

    def call
      output.puts representer.call(robot, table)
      Success()
    end
  end
end
