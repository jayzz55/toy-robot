# frozen_string_literal: true

require 'spec_helper'
require 'models/coordinate'
require 'models/table'

RSpec.describe Models::Table do
  describe '.new' do
    subject(:table) { described_class.new(coord, width, height) }

    let(:coord) { Models::Coordinate.new(1, 2) }
    let(:width) { 5 }
    let(:height) { 5 }

    its(:coordinate) { should eq(coord) }
    its(:width) { should eq(5) }
    its(:height) { should eq(5) }
  end
end
