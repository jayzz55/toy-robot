# frozen_string_literal: true

require 'spec_helper'
require 'services/direction_to_coordinate'
require 'models/coordinate'

RSpec.describe Services::DirectionToCoordinate do
  describe '.call' do
    subject(:call) { described_class.call(direction) }

    context 'when direction is NORTH' do
      let(:direction) { 'NORTH' }

      it 'returns Some coordinate of (0, 1)' do
        expect(call.value!).to eq Models::Coordinate.new(0, 1)
      end
    end

    context 'when direction is EAST' do
      let(:direction) { 'EAST' }

      it 'returns Some coordinate of (1, 0)' do
        expect(call.value!).to eq Models::Coordinate.new(1, 0)
      end
    end

    context 'when direction is SOUTH' do
      let(:direction) { 'SOUTH' }

      it 'returns Some coordinate of (0, -1)' do
        expect(call.value!).to eq Models::Coordinate.new(0, -1)
      end
    end

    context 'when direction is WEST' do
      let(:direction) { 'WEST' }

      it 'returns Some coordinate of (-1, 0)' do
        expect(call.value!).to eq Models::Coordinate.new(-1, 0)
      end
    end

    context 'when direction is invalid' do
      let(:direction) { 'SOUTHEAST' }

      it 'returns a None' do
        expect(call).to be_a Dry::Monads::None
      end
    end
  end
end
