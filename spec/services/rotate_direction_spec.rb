# frozen_string_literal: true

require 'spec_helper'
require 'services/rotate_direction'

RSpec.describe Services::RotateDirection do
  describe '.call' do
    subject(:call) { described_class.call(rotation_direction, direction) }

    context 'when rotation_direction is LEFT' do
      let(:rotation_direction) { 'LEFT' }

      context 'when direction is NORTH' do
        let(:direction) { 'NORTH' }

        it 'returns WEST' do
          expect(call).to eq 'WEST'
        end
      end

      context 'when direction is EAST' do
        let(:direction) { 'EAST' }

        it 'returns NORTH' do
          expect(call).to eq 'NORTH'
        end
      end

      context 'when direction is SOUTH' do
        let(:direction) { 'SOUTH' }

        it 'returns EAST' do
          expect(call).to eq 'EAST'
        end
      end

      context 'when direction is WEST' do
        let(:direction) { 'WEST' }

        it 'returns SOUTH' do
          expect(call).to eq 'SOUTH'
        end
      end

      context 'when direction is invalid' do
        let(:direction) { 'SOUTHEAST' }

        it 'returns the input direction as it is' do
          expect(call).to eq 'SOUTHEAST'
        end
      end
    end

    context 'when rotation_direction is RIGHT' do
      let(:rotation_direction) { 'RIGHT' }

      context 'when direction is NORTH' do
        let(:direction) { 'NORTH' }

        it 'returns EAST' do
          expect(call).to eq 'EAST'
        end
      end

      context 'when direction is EAST' do
        let(:direction) { 'EAST' }

        it 'returns SOUTH' do
          expect(call).to eq 'SOUTH'
        end
      end

      context 'when direction is SOUTH' do
        let(:direction) { 'SOUTH' }

        it 'returns WEST' do
          expect(call).to eq 'WEST'
        end
      end

      context 'when direction is WEST' do
        let(:direction) { 'WEST' }

        it 'returns NORTH' do
          expect(call).to eq 'NORTH'
        end
      end

      context 'when direction is invalid' do
        let(:direction) { 'SOUTHEAST' }

        it 'returns the input direction as it is' do
          expect(call).to eq 'SOUTHEAST'
        end
      end
    end
  end
end
