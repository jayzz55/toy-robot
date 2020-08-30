# frozen_string_literal: true

require 'spec_helper'
require 'representers/string_representer'
require 'models/robot'
require 'models/coordinate'

RSpec.describe Representers::StringRepresenter do
  describe '.call' do
    subject(:call) { described_class.call(robot) }

    let(:robot_position) { Models::Coordinate.new(3, 3) }
    let(:direction) { 'NORTH' }
    let(:robot) { Models::Robot.new(robot_position, direction) }

    it 'returns a string representation of the robot' do
      expect(call).to eq 'Output: 3,3,NORTH'
    end
  end
end

