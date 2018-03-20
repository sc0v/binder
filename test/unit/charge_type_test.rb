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
# **`description`**                    | `text`             |
# **`id`**                             | `integer`          | `not null, primary key`
# **`name`**                           | `string`           |
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
      @charge = FactoryGirl.create(:charge_type)
      @charge_type = FactoryGirl.create(:charge, :charge_type => @charge)
    end

    teardown do
    end

    should "show that all factories are properly created" do
      assert_equal 1, ChargeType.all.size
    end

    should "show dependency on charge" do
      assert_equal 1, Charge.all.size
      @charge_type.destroy
      assert_equal 0, Charge.all.size
    end  


  end
end
