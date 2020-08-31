# frozen_string_literal: true

require 'spec_helper'
require 'dry/monads'

require 'handlers/option_parser'

RSpec.describe Handlers::OptionParser do
  describe '.call' do
    subject(:call) { described_class.call(argv) }

    context 'with out any argv being passed' do
      let(:argv) { [] }

      it 'returns Options with default attributes' do
        expect(call).to have_attributes(width: 5, height: 5)
      end
    end

    context 'with --width=10 argv being passed' do
      let(:argv) { ['--width', '10'] }

      it 'returns Options with the specified width' do
        expect(call).to have_attributes(width: 10, height: 5)
      end
    end

    context 'with --height=10 argv being passed' do
      let(:argv) { ['--height', '10'] }

      it 'returns Options with the specified height' do
        expect(call).to have_attributes(width: 5, height: 10)
      end
    end
  end
end
