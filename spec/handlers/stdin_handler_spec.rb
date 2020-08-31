# frozen_string_literal: true

require 'spec_helper'
require 'dry/monads'

require 'handlers/stdin_handler'

RSpec.describe Handlers::StdinHandler do
  describe '#each' do
    subject(:input_handler) do
      described_class.new(stdin)
    end

    let(:stdin) { StringIO.new(inputs) }
    let(:inputs) { "input1\ninput2\ninput3\ninput4\n" }

    it 'returns the inputs as 4 input line' do
      expect(input_handler.map { |i| i }).to eq ['input1', 'input2', 'input3', 'input4']
    end
  end
end
