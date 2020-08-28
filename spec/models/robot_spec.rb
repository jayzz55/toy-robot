# frozen_string_literal: true

require 'spec_helper'
require 'models/coordinate'
require 'models/robot'

RSpec.describe Models::Robot do
  describe '.new' do
    subject(:robot) { described_class.new(coord, direction) }

    let(:coord) { Models::Coordinate.new(1, 2) }
    let(:direction) { 'NORTH' }

    its(:coordinate) { should eq(coord) }
    its(:direction) { should eq('NORTH') }
  end
end
