# frozen_string_literal: true

require 'test_helper'

class ToolTypeTest < ActiveSupport::TestCase
  should have_many(:tools)
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)

  context 'With an existing tool type' do
    setup do
      @hammer_type = FactoryGirl.create(:tool_type)
    end

    teardown do
    end

    should 'Not allow duplicate tool type names' do
      duplicate_type = ToolType.new(name: 'Hammer')
      deny duplicate_type.save
    end
  end
end
