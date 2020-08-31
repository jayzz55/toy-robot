# frozen_string_literal: true

require 'spec_helper'
require 'dry/monads'

require 'services/with_error_handling'

RSpec.describe Services::WithErrorHandling do
  include Dry::Monads[:result]

  subject(:error_handling) { described_class.call(stdout: stdout) { result } }

  let(:stdout) { StringIO.new }

  context 'when result return a Success' do
    let(:result) { Success() }

    it 'returns an :ok' do
      expect(error_handling).to eq :ok
    end

    it 'does NOT puts anything to stdout' do
      expect { error_handling }.not_to change { stdout.string }
    end
  end

  context 'when result return a Failure(:invalid_placement)' do
    let(:result) { Failure(:invalid_placement) }

    it 'returns an :error' do
      expect(error_handling).to eq :error
    end

    it 'calls puts on the stdout with "Sorry, Placement is invalid."' do
      expect { error_handling }.to change { stdout.string }.from('').to("Sorry, Placement is invalid.\n")
    end
  end
  context 'when result return a Failure(:invalid_movement)' do
    let(:result) { Failure(:invalid_movement) }

    it 'returns an :error' do
      expect(error_handling).to eq :error
    end

    it 'calls puts on the stdout with "Sorry, it is impossible to move."' do
      expect { error_handling }.to change { stdout.string }.from('').to("Sorry, it is impossible to move.\n")
    end
  end
  context 'when result return a Failure(:invalid_direction)' do
    let(:result) { Failure(:invalid_direction) }

    it 'returns an :error' do
      expect(error_handling).to eq :error
    end

    it 'calls puts on the stdout with "Something is wrong with the direction."' do
      expect { error_handling }.to change { stdout.string }.from('').to("Something is wrong with the direction.\n")
    end
  end
  context 'when result return a Failure(:missing_robot)'do
    let(:result) { Failure(:missing_robot) }

    it 'returns an :error' do
      expect(error_handling).to eq :error
    end

    it 'calls puts on the stdout with "No Robot Found! Need to PLACE a robot first."' do
      expect { error_handling }.to change { stdout.string }.from('').to("No Robot Found! Need to PLACE a robot first.\n")
    end
  end
  context 'when result return a Failure(:invalid_input)' do
    let(:result) { Failure(:invalid_input) }

    it 'returns an :error' do
      expect(error_handling).to eq :error
    end

    it 'calls puts on the stdout with "Sorry, provided input is invalid."' do
      expect { error_handling }.to change { stdout.string }.from('').to("Sorry, provided input is invalid.\n")
    end
  end
  context 'when result return a Failure with other message' do
    let(:result) { Failure(:error) }

    it 'returns an :error' do
      expect(error_handling).to eq :error
    end

    it 'calls puts on the stdout with "Oops, this is embarassing, some unexpected error has occured."' do
      expect { error_handling }.to change { stdout.string }.from('').to("Oops, this is embarassing, some unexpected error has occured.\n")
    end
  end
  context 'when result raises and unexpected exception' do
    let(:result) { raise('KABOOM!') }

    it 'returns an :error' do
      expect(error_handling).to eq :error
    end

    it 'calls puts on the stdout with "Oops, this is embarassing, some unexpected error has occured."' do
      expect { error_handling }.to change { stdout.string }.from('').to("Oops, this is embarassing, some unexpected error has occured.\n")
    end
  end
end
