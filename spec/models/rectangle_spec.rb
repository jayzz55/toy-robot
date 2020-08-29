# frozen_string_literal: true

require 'spec_helper'
require 'models/coordinate'
require 'models/rectangle'

RSpec.describe Models::Rectangle do
  describe '.new' do
    subject { described_class.new(coord, width, height) }

    let(:coord) { Models::Coordinate.new(1, 1) }
    let(:width) { 2 }
    let(:height) { 3 }

    its(:coordinate) { should eq(coord) }
    its(:width) { should eq(2) }
    its(:height) { should eq(3) }

    context 'with default value' do
      subject { described_class.new() }

      its(:coordinate) { should eq Models::Coordinate.new(0, 0) }
      its(:width) { should eq(5) }
      its(:height) { should eq(5) }
    end
  end

  describe '#coordinates' do
    subject(:coordinates) { described_class.new(coord, width, height).coordinates }

    let(:coord) { Models::Coordinate.new(1, 1) }
    let(:width) { 2 }
    let(:height) { 3 }

    let(:expected_coordinates) do
      [
        Models::Coordinate.new(1, 1),
        Models::Coordinate.new(2, 1),
        Models::Coordinate.new(1, 2),
        Models::Coordinate.new(2, 2),
        Models::Coordinate.new(1, 3),
        Models::Coordinate.new(2, 3)
      ]
    end

    it 'returns an array of all the coordinate points' do
      expect(coordinates).to contain_exactly(*expected_coordinates)
    end
  end
end
