# frozen_string_literal: true

require 'optparse'
require 'models/rectangle'

class Options
  attr_accessor :height, :width, :render_table

  def initialize(
    height: Models::Rectangle::DEFAULT_HEIGHT,
    width: Models::Rectangle::DEFAULT_WIDTH,
    render_table: false
  )
    @height = height
    @width = width
    @render_table = render_table
  end
end

module Handlers
  class OptionParser
    class << self
      # rubocop:disable Metrics/MethodLength
      def call(options, kernel = Kernel)
        args = Options.new

        opt_parser = ::OptionParser.new do |opts|
          opts.banner = 'Usage: ./bin/run [options]'

          opts.on('--width=WIDTH', Integer, 'Width of the table in Integer') do |width|
            args.width = width
          end

          opts.on('--height=HEIGHT', Integer, 'Height of the table in Integer') do |height|
            args.height = height
          end

          opts.on('--render_table', 'Render table') do
            args.render_table = true
          end

          opts.on('-h', '--help', 'Prints this help') do
            kernel.puts opts
            kernel.exit
          end
        end

        opt_parser.parse!(options)
        args
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
