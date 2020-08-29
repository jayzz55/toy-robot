# frozen_string_literal: true

require 'spec_helper'
require 'commands/place'
require 'models/coordinate'
require 'models/table'

RSpec.describe Commands::Place do
  describe '.call' do
    subject(:call) { described_class.call(x_coord: x_coord, y_coord: y_coord, direction: direction, table: table) }

    let(:direction) { 'NORTH' }
    let(:table) { Models::Table.new }

    context 'when placement position is within the table' do
      let(:x_coord) { 0 }
      let(:y_coord) { 0 }

      it 'returns a robot instance wrapped in a Success Result' do
        expect(call.value!).to eq Models::Robot.new(Models::Coordinate.new(x_coord, y_coord), direction)
      end
    end

    context 'when placement position is outside the table' do
      let(:x_coord) { -1 }
      let(:y_coord) { -1 }

      it 'returns a Failure Result with a message of :invalid_placement' do
        expect(call.failure).to eq :invalid_placement
      end
    end
  end
end
