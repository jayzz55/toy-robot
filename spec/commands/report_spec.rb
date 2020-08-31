# frozen_string_literal: true

require 'spec_helper'
require 'commands/report'
require 'models/robot'
require 'models/coordinate'
require 'stringio'

RSpec.describe Commands::Report do
  describe '.call' do
    subject(:call) { described_class.call(robot: robot, representer: representer, output: output) }

    let(:representer) { lambda { |robot| "robot has #{robot.coordinate.x},#{robot.coordinate.y},#{robot.direction}" } }
    let(:output) { StringIO.new }
    let(:robot_position) { Models::Coordinate.new(1, 2) }
    let(:direction) { 'EAST' }
    let(:robot) { Models::Robot.new(robot_position, direction) }

    context 'when placement position is within the table' do
      let(:x_coord) { 0 }
      let(:y_coord) { 0 }

      it 'returns a Success Result' do
        expect(call).to be_a Dry::Monads::Success
      end

      it 'calls puts on the output with the representer' do
        expect { call }.to change { output.string }.from('').to("robot has 1,2,EAST\n")
      end
    end
  end
end
