# frozen_string_literal: true

require 'spec_helper'
require 'app'
require 'models/robot'
require 'models/coordinate'
require 'models/table'
require 'stringio'

RSpec.describe App do
  let(:output) { StringIO.new }
  let(:table) { Models::Table.new }
  let(:robot_position) { Models::Coordinate.new(1, 2) }
  let(:direction) { 'EAST' }
  let(:robot) { Models::Robot.new(robot_position, direction) }

  describe '.new' do
    subject(:app) { described_class.new(robot: robot, table: table, output: output) }

    its(:robot) { should eq(robot) }
    its(:table) { should eq(table) }
    its(:output) { should eq(output) }

    context 'with default value' do
      subject { described_class.new() }

      its(:robot) { should eq(nil) }
      its(:table) { should eq(App::DEFAULT_TABLE) }
      its(:output) { should eq($stdout) }
    end
  end

  describe '#call' do
    subject(:call) { app.call(input_string) }

    let(:app) { described_class.new(robot: robot, table: table, output: output) }

    context 'with an invalid input_string' do
      context 'when input_string is invalid PLACE command' do
        let(:input_string) { 'PLACE' }

        it 'returns a failure with the message :invalid_input' do
          expect(call.failure).to eq(:invalid_input)
        end
      end
      context 'when input_string is not one of the valid commands' do
        let(:input_string) { 'JUMP' }

        it 'returns a failure with the message :invalid_input' do
          expect(call.failure).to eq(:invalid_input)
        end
      end
    end

    context 'with a valid input_string' do
      context 'when the robot state is nil' do
        let(:robot) { nil }

        context 'with a PLACE command' do
          let(:input_string) { 'PLACE 0,0,NORTH' }

          it 'returns app in a Success result' do
            expect(call.value!).to eq(app)
          end

          it 'sets the robot state with the result of the PLACE command' do
            expect { call }.to change { app.robot }
              .from(nil)
              .to(Models::Robot.new(Models::Coordinate.new(0,0), 'NORTH'))
          end
        end
        context 'with a LEFT command' do
          let(:input_string) { 'LEFT' }

          it 'returns a failure with the message :missing_robot' do
            expect(call.failure).to eq(:missing_robot)
          end
        end
        context 'with a RIGHT command' do
          let(:input_string) { 'RIGHT' }

          it 'returns a failure with the message :missing_robot' do
            expect(call.failure).to eq(:missing_robot)
          end
        end
        context 'with a MOVE command' do
          let(:input_string) { 'MOVE' }

          it 'returns a failure with the message :missing_robot' do
            expect(call.failure).to eq(:missing_robot)
          end
        end
        context 'with a REPORT command' do
          let(:input_string) { 'REPORT' }

          it 'returns a failure with the message :missing_robot' do
            expect(call.failure).to eq(:missing_robot)
          end
        end
      end

      context 'when the robot state is NOT nil' do
        let(:robot_position) { Models::Coordinate.new(1, 2) }
        let(:direction) { 'EAST' }
        let(:robot) { Models::Robot.new(robot_position, direction) }

        context 'with a PLACE command' do
          let(:input_string) { 'PLACE 0,0,NORTH' }

          it 'returns app in a Success result' do
            expect(call.value!).to eq(app)
          end

          it 'sets the robot state with the result of the PLACE command' do
            expect { call }.to change { app.robot }
              .from(robot)
              .to(Models::Robot.new(Models::Coordinate.new(0,0), 'NORTH'))
          end
        end
        context 'with a LEFT command' do
          let(:input_string) { 'LEFT' }

          it 'returns app in a Success result' do
            expect(call.value!).to eq(app)
          end

          it 'sets the robot state with the result of the LEFT command' do
            expect { call }.to change { app.robot }
              .from(robot)
              .to(Models::Robot.new(Models::Coordinate.new(1,2), 'NORTH'))
          end
        end
        context 'with a RIGHT command' do
          let(:input_string) { 'RIGHT' }

          it 'returns app in a Success result' do
            expect(call.value!).to eq(app)
          end

          it 'sets the robot state with the result of the RIGHT command' do
            expect { call }.to change { app.robot }
              .from(robot)
              .to(Models::Robot.new(Models::Coordinate.new(1,2), 'SOUTH'))
          end
        end
        context 'with a MOVE command' do
          let(:input_string) { 'MOVE' }

          it 'returns app in a Success result' do
            expect(call.value!).to eq(app)
          end

          it 'sets the robot state with the result of the MOVE command' do
            expect { call }.to change { app.robot }
              .from(robot)
              .to(Models::Robot.new(Models::Coordinate.new(2,2), 'EAST'))
          end
        end
        context 'with a REPORT command' do
          let(:input_string) { 'REPORT' }

          it 'returns app in a Success result' do
            expect(call.value!).to eq(app)
          end

          it 'updates the output state with the result of the REPORT command' do
            expect { call }.to change { output.string }.from('').to("Output: 1,2,EAST\n")
          end
        end
      end
    end
  end
end
