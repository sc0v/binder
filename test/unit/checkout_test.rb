# frozen_string_literal: true

require 'test_helper'

class CheckoutTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:participant)
  should belong_to(:organization)
  should belong_to(:tool)

  # Validations
  should validate_presence_of(:tool).with_message(:required)
  should validate_presence_of(:organization).with_message(:required)

  context 'With a proper context, ' do
    setup do
      @org = FactoryBot.create(:organization, name: 'bruce')
      @person = FactoryBot.create(:participant)
      @type1 = FactoryBot.create(:tool_type, name: 'hammer')
      @type2 = FactoryBot.create(:tool_type, name: 'drill')
      @type3 = FactoryBot.create(:tool_type, name: 'lmao')
      @t1 = FactoryBot.create(:tool, barcode: 1111, tool_type: @type1)
      @t2 = FactoryBot.create(:tool, barcode: 2222, tool_type: @type2)
      @t3 = FactoryBot.create(:tool, barcode: 3333, tool_type: @type3)
      @checkout1 =
        FactoryBot.create(
          :checkout,
          checked_in_at: Time.zone.now,
          organization: @org,
          participant: @person,
          tool: @t1
        )
      @checkout2 =
        FactoryBot.create(
          :checkout,
          checked_in_at: Time.zone.now,
          organization: @org,
          participant: @person,
          tool: @t2
        )
      @checkout3 =
        FactoryBot.create(
          :checkout,
          checked_in_at: nil,
          organization: @org,
          participant: @person,
          tool: @t3
        )
    end

    should 'show that all factories are properly created' do
      assert_equal 3, Checkout.all.size
    end

    # Scopes
    should 'show that current scope works' do
      assert_equal 1, Checkout.current.size
    end

    should 'show that old scope works' do
      assert_equal 2, Checkout.old.size
    end
  end
end
