# ## Schema Information
#
# Table name: `shift_types`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`active`**      | `boolean`          | `default(TRUE)`
# **`created_at`**  | `datetime`         |
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string(255)`      |
# **`short_name`**  | `string(255)`      |
# **`updated_at`**  | `datetime`         |
#

require 'test_helper'

class ShiftTypeTest < ActiveSupport::TestCase
  # Relationships
  should have_many(:shifts)

  # Validations
  should validate_presence_of(:name)

  context "With a proper context, " do
    setup do
      # Create 3 shift types
      @watch_shift = FactoryGirl.create(:shift_type)
      @security_shift = FactoryGirl.create(:shift_type, :name => "Security Shift")
      @ride_shift = FactoryGirl.create(:shift_type, :name => "Ride Shift")
    end

    teardown do
    end

    should "show that all factories are properly created" do
      assert_equal 3, ShiftType.all.size
    end

    # Scopes

    # Methods

    #use factory girl to test uniqueness of name and dependent destroy

  end
end
