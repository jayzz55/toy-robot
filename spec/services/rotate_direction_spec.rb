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

        it 'returns a Some of WEST' do
          expect(call.value!).to eq 'WEST'
        end
      end

      context 'when direction is EAST' do
        let(:direction) { 'EAST' }

        it 'returns a Some of NORTH' do
          expect(call.value!).to eq 'NORTH'
        end
      end

      context 'when direction is SOUTH' do
        let(:direction) { 'SOUTH' }

        it 'returns a Some of EAST' do
          expect(call.value!).to eq 'EAST'
        end
      end

      context 'when direction is WEST' do
        let(:direction) { 'WEST' }

        it 'returns a Some of SOUTH' do
          expect(call.value!).to eq 'SOUTH'
        end
      end

      context 'when direction is invalid' do
        let(:direction) { 'SOUTHEAST' }

        it 'returns a None' do
          expect(call).to be_a Dry::Monads::None
        end
      end
    end

    context 'when rotation_direction is RIGHT' do
      let(:rotation_direction) { 'RIGHT' }

      context 'when direction is NORTH' do
        let(:direction) { 'NORTH' }

        it 'returns a Some EAST' do
          expect(call.value!).to eq 'EAST'
        end
      end

      context 'when direction is EAST' do
        let(:direction) { 'EAST' }

        it 'returns a Some SOUTH' do
          expect(call.value!).to eq 'SOUTH'
        end
      end

      context 'when direction is SOUTH' do
        let(:direction) { 'SOUTH' }

        it 'returns a Some of WEST' do
          expect(call.value!).to eq 'WEST'
        end
      end

      context 'when direction is WEST' do
        let(:direction) { 'WEST' }

        it 'returns a Some of NORTH' do
          expect(call.value!).to eq 'NORTH'
        end
      end

      context 'when direction is invalid' do
        let(:direction) { 'SOUTHEAST' }

        it 'returns a None' do
          expect(call).to be_a Dry::Monads::None
        end
      end
    end

    context 'when rotation_direction is RIGHT' do
      let(:rotation_direction) { 'INVALID' }
      let(:direction) { 'NORTH' }

      it 'returns a None' do
        expect(call).to be_a Dry::Monads::None
      end
    end
  end
end
