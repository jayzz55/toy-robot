# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'constants/command'
require 'constants/direction'

module Validators
  class ArgsString
    class << self
      include Dry::Monads[:maybe, :result]
      include Dry::Monads::Do.for(:call)

      MAPPINGS = {
        Constants::PLACE => :validate_placement_args,
        Constants::MOVE => :validate_no_args,
        Constants::LEFT => :validate_no_args,
        Constants::RIGHT => :validate_no_args,
        Constants::REPORT => :validate_no_args
      }.freeze

      def call(command_string, args_string)
        yield Maybe(MAPPINGS[command_string])
          .to_result(:invalid_input)
          .bind { |method_name| method(method_name).call(args_string) }

        Success()
      end

      private

      def validate_no_args(args_string)
        args_string.nil? ? Success() : Failure(:invalid_input)
      end

      def validate_placement_args(args_string)
        Maybe(args_string).to_result(:invalid_input)
                          .fmap { |string| string.split(',') }
                          .bind { |args| validate_placement_args_size(args) }
                          .bind { |args| validate_placement_position(args) }
                          .bind { |args| validate_placement_direction(args) }
      end

      def validate_placement_args_size(args)
        args.size != 3 ? Failure(:invalid_input) : Success(args)
      end

      def validate_placement_position(args)
        if args[0..1].any? { |string| string.to_i.to_s != string }
          Failure(:invalid_input)
        else
          Success(args)
        end
      end

      def validate_placement_direction(args)
        if Constants::DIRECTIONS.include? args[2].upcase
          Success(args)
        else
          Failure(:invalid_input)
        end
      end
    end
  end
end
