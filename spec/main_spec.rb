# frozen_string_literal: true

require 'spec_helper'
require 'main'
require 'models/robot'
require 'models/coordinate'
require 'models/table'
require 'stringio'

RSpec.describe Main do
  describe '.call' do
    subject(:call) do
      described_class.call(
        input_handler: input_handler,
        output: output,
        width: width,
        height: height
      )
    end

    let(:input_handler) { Handlers::StdinHandler.new(stdin) }
    let(:stdin) { StringIO.new }
    let(:output) { StringIO.new }
    let(:width) { 5 }
    let(:height) { 5 }

    context 'scenario in spec/fixtures/input_1.txt' do
      let(:stdin) { StringIO.new(File.read("spec/fixtures/input_1.txt")) }
      it 'returns Output: 0,1,NORTH' do
        call
        expect(output.string).to eq "Output: 0,1,NORTH\n"
      end
    end

    context 'scenario in spec/fixtures/input_2.txt' do
      let(:stdin) { StringIO.new(File.read("spec/fixtures/input_2.txt")) }
      it 'returns Output: 0,0,WEST' do
        call
        expect(output.string).to eq "Output: 0,0,WEST\n"
      end
    end

    context 'scenario in spec/fixtures/input_3.txt' do
      let(:stdin) { StringIO.new(File.read("spec/fixtures/input_3.txt")) }
      it 'returns Output: 3,3,NORTH' do
        call
        expect(output.string).to eq "Output: 3,3,NORTH\n"
      end
    end

    context 'scenario in spec/fixtures/input_4.txt' do
      let(:stdin) { StringIO.new(File.read("spec/fixtures/input_4.txt")) }
      it 'returns Output: 1,0,EAST' do
        call
        expect(output.string).to eq "Output: 1,0,EAST\n"
      end
    end

    context 'scenario in spec/fixtures/input_5.txt' do
      let(:stdin) { StringIO.new(File.read("spec/fixtures/input_5.txt")) }
      it 'returns Output: 0,0,EAST' do
        call
        expect(output.string).to include "Output: 0,0,EAST\n"
      end
    end

    context 'scenario in spec/fixtures/input_6.txt' do
      let(:stdin) { StringIO.new(File.read("spec/fixtures/input_6.txt")) }
      it 'returns Output: 0,0,EAST' do
        call
        expect(output.string).to include "Sorry, Placement is invalid."
      end
    end

    context 'scenario in spec/fixtures/input_7.txt' do
      let(:stdin) { StringIO.new(File.read("spec/fixtures/input_7.txt")) }
      it 'returns Output' do
        call
        expect(output.string).to include <<~TEXT
        0,0
        0,1
        0,2
        1,2
        2,2
        TEXT
      end
    end
  end
end
