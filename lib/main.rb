# frozen_string_literal: true

require 'dry/monads'
require 'app'
require 'handlers/with_error_handling'
require 'handlers/stdin_handler'
require 'representers/string_representer'
require 'representers/table_representer'

class Main
  class << self
    def call(input_handler: Handlers::StdinHandler.new, output: $stdout, width:, height:, render_table: false)
      table = Models::Table.default_from(width: width, height: height)
      representer = render_table ? Representers::TableRepresenter : Representers::StringRepresenter
      app = App.new(output: output, table: table, representer: representer)

      input_handler.each do |input_line|
        Handlers::WithErrorHandling.call(output: output) do
          app.call(input_line)
        end
      end
    end
  end
end
