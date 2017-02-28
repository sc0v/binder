# ## Schema Information
#
# Table name: `charge_types`
#
# ### Columns
#
# Name                                 | Type               | Attributes
# ------------------------------------ | ------------------ | ---------------------------
# **`created_at`**                     | `datetime`         |
# **`default_amount`**                 | `decimal(8, 2)`    |
# **`description`**                    | `text(65535)`      |
# **`id`**                             | `integer`          | `not null, primary key`
# **`name`**                           | `string(255)`      |
# **`requires_booth_chair_approval`**  | `boolean`          |
# **`updated_at`**                     | `datetime`         |
#

require 'test_helper'

class ChargeTypeTest < ActiveSupport::TestCase
  # Relationships
  should have_many(:charges)

  # Validations

  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)

  context "With a proper context, " do
    setup do
      FactoryGirl.create(:charge_type)
    end

    teardown do
    end

    should "show that all factories are properly created" do
      assert_equal 1, ChargeType.all.size
    end

    # Scopes

    # Methods
  end
end
