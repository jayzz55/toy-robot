# frozen_string_literal: true

require 'spec_helper'
require 'validators/args_string'

RSpec.describe Validators::ArgsString do
  describe '.call' do
    subject(:call) { described_class.call(*input) }

    context 'with an invalid PLACE command' do
      context 'when PLACE command is provided without any argument' do
        let(:input) { ['PLACE', nil] }

        it 'returns a failure with the message :invalid_input' do
          expect(call.failure).to eq :invalid_input
        end
      end

      context 'when PLACE command is provided with only 1 argument' do
        let(:input) { ['PLACE', '0'] }

        it 'returns a failure with the message :invalid_input' do
          expect(call.failure).to eq :invalid_input
        end
      end

      context 'when PLACE command is provided with only 2 argument' do
        let(:input) { ['PLACE', '0,1'] }

        it 'returns a failure with the message :invalid_input' do
          expect(call.failure).to eq :invalid_input
        end
      end

      context 'when the 1st arg in the PLACE command is not an integer' do
        let(:input) { ['PLACE', 'a,1,NORTH'] }

        it 'returns a failure with the message :invalid_input' do
          expect(call.failure).to eq :invalid_input
        end
      end

      context 'when the 2nd arg in the PLACE command is not an integer' do
        let(:input) { ['PLACE', '0,a,NORTH'] }

        it 'returns a failure with the message :invalid_input' do
          expect(call.failure).to eq :invalid_input
        end
      end

      context 'when the 3rd arg in the PLACE command is not one of NORTH, EAST, SOUTH, or WEST' do
        let(:input) { ['PLACE', '0,0,SOUTHEAST'] }

        it 'returns a failure with the message :invalid_input' do
          expect(call.failure).to eq :invalid_input
        end
      end
    end

    context 'with an invalid MOVE command' do
      context 'when MOVE command is provided with any argument' do
        let(:input) { ['MOVE', '0'] }

        it 'returns a failure with the message :invalid_input' do
          expect(call.failure).to eq :invalid_input
        end
      end
    end

    context 'with an invalid LEFT command' do
      context 'when LEFT command is provided with any argument' do
        let(:input) { ['LEFT', '0'] }

        it 'returns a failure with the message :invalid_input' do
          expect(call.failure).to eq :invalid_input
        end
      end
    end

    context 'with an invalid RIGHT command' do
      context 'when RIGHT command is provided with any argument' do
        let(:input) { ['RIGHT', '0'] }

        it 'returns a failure with the message :invalid_input' do
          expect(call.failure).to eq :invalid_input
        end
      end
    end

    context 'with an invalid REPORT command' do
      context 'when REPORT command is provided with any argument' do
        let(:input) { ['REPORT', '0'] }

        it 'returns a failure with the message :invalid_input' do
          expect(call.failure).to eq :invalid_input
        end
      end
    end

    context 'with a valid PLACE command' do
      let(:input) { ['PLACE', '0,0,NORTH'] }

      it 'returns a Success result' do
        expect(call).to be_a Dry::Monads::Success
      end
    end

    context 'with a valid MOVE command' do
      let(:input) { ['MOVE', nil] }

      it 'returns a Success result' do
        expect(call).to be_a Dry::Monads::Success
      end
    end

    context 'with a valid LEFT command' do
      let(:input) { ['LEFT', nil] }

      it 'returns a Success result' do
        expect(call).to be_a Dry::Monads::Success
      end
    end

    context 'with a valid RIGHT command' do
      let(:input) { ['RIGHT', nil] }

      it 'returns a Success result' do
        expect(call).to be_a Dry::Monads::Success
      end
    end

    context 'with a valid REPORT command' do
      let(:input) { ['REPORT', nil] }

      it 'returns a Success result' do
        expect(call).to be_a Dry::Monads::Success
      end
    end
  end
end
