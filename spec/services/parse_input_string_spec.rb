# frozen_string_literal: true

require 'spec_helper'
require 'services/parse_input_string'

RSpec.describe Services::ParseInputString do
  describe '.call' do
    subject(:call) { described_class.call(rotation_direction, direction) }
  end
end
