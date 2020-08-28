# frozen_string_literal: true

require 'spec_helper'
require 'models/coordinate'

RSpec.describe Models::Coordinate do
  describe '.new' do
    subject(:coordinate) { described_class.new(1, 2) }

    its(:x) { should eq(1) }
    its(:y) { should eq(2) }
  end
end
