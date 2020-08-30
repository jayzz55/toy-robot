# frozen_string_literal: true

require 'dry/monads'
require 'models/robot'
require 'representers/string_representer'

module Commands
  class Report
    class << self
      include Dry::Monads[:result]

      def call(robot:, representer: Representers::StringRepresenter, stdout: $stdout)
        stdout.puts representer.call(robot)
        Success()
      end
    end
  end
end
