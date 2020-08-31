# frozen_string_literal: true

require 'spec_helper'
require 'commands/place'
require 'models/coordinate'
require 'models/table'

RSpec.describe Commands::Place do
  describe '#call' do
    subject(:call) { described_class.new(table: table, app: app).call(robot: robot) }

    let(:robot) { Models::Robot.new(Models::Coordinate.new(x, y), direction) }
    let(:app) { Struct.new(:robot).new }
    let(:direction) { 'NORTH' }
    let(:table) { Models::Table.new }

    context 'when placement position is within the table' do
      let(:x) { 0 }
      let(:y) { 0 }

      it 'returns a robot instance wrapped in a Success Result' do
        expect(call.value!).to eq robot
      end

      it 'sets the robot state of the app' do
        expect { call }.to change { app.robot }.from(nil).to(Models::Robot.new(Models::Coordinate.new(x, y), direction))
      end
    end

    context 'when placement position is outside the table' do
      let(:x) { -1 }
      let(:y) { -1 }

      it 'returns a Failure Result with a message of :invalid_placement' do
        expect(call.failure).to eq :invalid_placement
      end

      it 'does NOT sets the robot state of the app' do
        expect { call }.not_to change { app.robot }
      end
    end
  end
end
