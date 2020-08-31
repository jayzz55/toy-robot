# frozen_string_literal: true

require 'spec_helper'
require 'commands/move'
require 'models/coordinate'
require 'models/table'

RSpec.describe Commands::Move do
  describe '#call' do
    subject(:call) { described_class.new(robot: robot, table: table).call() }

    let(:table) { Models::Table.new }

    context 'when moving the robot resulting in a position within the table' do
      let(:robot_position) { Models::Coordinate.new(0, 0) }
      let(:direction) { 'NORTH' }
      let(:robot) { Models::Robot.new(robot_position, direction) }
      let(:expected_position) { Models::Coordinate.new(0, 1) }

      it 'returns a robot instance wrapped in a Success Result' do
        expect(call.value!).to eq Models::Robot.new(expected_position, direction)
      end

      it 'changes the coordinate position state of the robot' do
        expect { call }.to change { robot.coordinate }.from(robot_position).to(expected_position)
      end
    end

    context 'when moving the robot resulting in a position outside the table' do
      let(:robot_position) { Models::Coordinate.new(0, 0) }
      let(:direction) { 'WEST' }
      let(:robot) { Models::Robot.new(robot_position, direction) }

      it 'returns a Failure Result with a message of :invalid_movement' do
        expect(call.failure).to eq :invalid_movement
      end
    end

    context 'when provided a robot with invalid direction' do
      let(:robot_position) { Models::Coordinate.new(0, 0) }
      let(:direction) { 'NORTHWEST' }
      let(:robot) { Models::Robot.new(robot_position, direction) }

      it 'returns a Failure Result with a message of :invalid_movement' do
        expect(call.failure).to eq :invalid_movement
      end
    end
  end
end
