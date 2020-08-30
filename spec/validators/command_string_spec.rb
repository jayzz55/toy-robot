# frozen_string_literal: true

require 'spec_helper'
require 'validators/command_string'

RSpec.describe Validators::CommandString do
  describe '.call' do
    subject(:call) { described_class.call(input_string) }

    context 'with an unknown command' do
      let(:input_string) { 'JUMP' }

      it 'returns a failure with the message :invalid_input' do
        expect(call.failure).to eq :invalid_input
      end
    end

    context 'with a PLACE command' do
      let(:input_string) { 'PLACE' }

      it 'returns input_string in a Success result' do
        expect(call.value!).to eq 'PLACE'
      end
    end

    context 'with a MOVE command' do
      let(:input_string) { 'MOVE' }

      it 'returns input_string in a Success result' do
        expect(call.value!).to eq 'MOVE'
      end
    end

    context 'with a LEFT command' do
      let(:input_string) { 'LEFT' }

      it 'returns input_string in a Success result' do
        expect(call.value!).to eq 'LEFT'
      end
    end

    context 'with a RIGHT command' do
      let(:input_string) { 'RIGHT' }

      it 'returns input_string in a Success result' do
        expect(call.value!).to eq 'RIGHT'
      end
    end

    context 'with a REPORT command' do
      let(:input_string) { 'REPORT' }

      it 'returns input_string in a Success result' do
        expect(call.value!).to eq 'REPORT'
      end
    end
  end
end
