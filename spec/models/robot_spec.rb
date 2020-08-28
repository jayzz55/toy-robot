require 'spec_helper'
require 'models/robot'

RSpec.describe Models::Robot do
  describe '.new' do
    subject(:robot) { described_class.new(coord, direction) }

    let(:coord) { Coordinate.new(1,2) }
    let(:direction) { 'NORTH' }

    its(:coord) { should eq(coord) }
    its(:direction) { should eq('NORTH') }
  end
end

