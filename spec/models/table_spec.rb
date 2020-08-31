# frozen_string_literal: true

require 'spec_helper'
require 'models/coordinate'
require 'models/table'
require 'models/rectangle'
require 'models/coordinate'

RSpec.describe Models::Table do
  describe '.default_from' do
    subject(:table) { described_class.default_from(width: 10, height: 20) }

    it 'returns a rectangle table with the specified width' do
      expect(table.shape.width).to eq 10
    end

    it 'returns a rectangle table with the specified height' do
      expect(table.shape.height).to eq 20
    end

    it 'returns a rectangle table with the default coordinate' do
      expect(table.shape.coordinate).to eq Models::Rectangle::DEFAULT_COORDINATE
    end
  end

  describe '.new' do
    subject { described_class.new(shape) }

    let(:shape) { Models::Rectangle.new(Models::Coordinate.new(1, 1), 5, 5) }

    its(:shape) { should eq(shape) }

    context 'with default value' do
      subject { described_class.new() }

      its(:shape) { should eq(Models::Table::DEFAULT_SHAPE) }
    end
  end

  describe '#contain?' do
    subject(:is_contain) { described_class.new(shape).contain?(point) }

    let(:shape) { Models::Rectangle.new(Models::Coordinate.new(1, 1), 5, 5) }

    context 'with a coordinate point outside the table' do
      let(:point) { Models::Coordinate.new(0, 0) }

      it 'returns false' do
        expect(is_contain).to eq false
      end
    end

    context 'with a coordinate point within the table' do
      let(:point) { Models::Coordinate.new(1, 1) }

      it 'returns true' do
        expect(is_contain).to eq true
      end
    end
  end
end
