# frozen_string_literal: true

require 'spec_helper'
require 'models/coordinate'

RSpec.describe Models::Coordinate do
  describe '.new' do
    subject(:coordinate) { described_class.new(1, 2) }

    its(:x) { should eq(1) }
    its(:y) { should eq(2) }
  end

  describe '#+' do
    subject(:result) { coordinate_1 + coordinate_2 }

    let(:coordinate_1) { described_class.new(1, 4) }
    let(:coordinate_2) { described_class.new(2, 9) }

    it 'returns the addition of 2 coordinates' do
      expect(result).to eq described_class.new(3, 13)
    end
  end
end
