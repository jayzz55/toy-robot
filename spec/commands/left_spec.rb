# frozen_string_literal: true

require 'spec_helper'
require 'commands/left'
require 'models/robot'
require 'models/coordinate'

RSpec.describe Commands::Left do
  describe '#call' do
    subject(:call) { described_class.new(robot: robot).call() }

    let(:robot_position) { Models::Coordinate.new(0, 0) }
    let(:robot) { Models::Robot.new(robot_position, direction) }

    context 'when robot is currently facing NORTH direction' do
      let(:direction) { 'NORTH' }

      it 'returns a robot instance wrapped in a Success Result' do
        expect(call.value!).to eq robot
      end

      it 'changes the direction state of the robot to WEST' do
        expect { call }.to change { robot.direction }.from('NORTH').to('WEST')
      end
    end

    context 'when robot is currently facing EAST direction' do
      let(:direction) { 'EAST' }

      it 'returns a robot instance wrapped in a Success Result' do
        expect(call.value!).to eq robot
      end

      it 'changes the direction state of the robot to NORTH' do
        expect { call }.to change { robot.direction }.from('EAST').to('NORTH')
      end
    end

    context 'when robot is currently facing SOUTH direction' do
      let(:direction) { 'SOUTH' }

      it 'returns a robot instance wrapped in a Success Result' do
        expect(call.value!).to eq robot
      end

      it 'changes the direction state of the robot to EAST' do
        expect { call }.to change { robot.direction }.from('SOUTH').to('EAST')
      end
    end

    context 'when robot is currently facing WEST direction' do
      let(:direction) { 'WEST' }

      it 'returns a robot instance wrapped in a Success Result' do
        expect(call.value!).to eq robot
      end

      it 'changes the direction state of the robot to SOUTH' do
        expect { call }.to change { robot.direction }.from('WEST').to('SOUTH')
      end
    end

    context 'when robot is currently facing invalid direction' do
      let(:direction) { 'SOUTHEAST' }

      it 'returns a Failure Result with a message of :invalid_direction' do
        expect(call.failure).to eq :invalid_direction
      end
    end
  end
end
