# frozen_string_literal: true

require 'spec_helper'
require 'models/coordinate'
require 'models/table'

RSpec.describe Models::Table do
  describe '.new' do
    subject { described_class.new(coord, width, height) }

    let(:coord) { Models::Coordinate.new(1, 1) }
    let(:width) { 5 }
    let(:height) { 8 }
    let(:expected_coordinates) do
      [
        Models::Coordinate.new(1, 1),
        Models::Coordinate.new(5, 1),
        Models::Coordinate.new(1, 8),
        Models::Coordinate.new(5, 8)
      ]
    end

    its(:coordinate) { should eq(coord) }
    its(:width) { should eq(5) }
    its(:height) { should eq(8) }
    its(:coordinates) { should eq(expected_coordinates) }
  end
end