# ## Schema Information
#
# Table name: `charges`
#
# ### Columns
#
# Name                            | Type               | Attributes
# ------------------------------- | ------------------ | ---------------------------
# **`amount`**                    | `decimal(8, 2)`    |
# **`approved`**                  | `boolean`          |
# **`charge_type_id`**            | `integer`          |
# **`charged_at`**                | `datetime`         |
# **`created_at`**                | `datetime`         |
# **`description`**               | `text`             |
# **`id`**                        | `integer`          | `not null, primary key`
# **`is_approved`**               | `boolean`          |
# **`issuing_participant_id`**    | `integer`          |
# **`organization_id`**           | `integer`          |
# **`receiving_participant_id`**  | `integer`          |
# **`updated_at`**                | `datetime`         |
#
# ### Indexes
#
# * `index_charges_on_organization_id`:
#     * **`organization_id`**
#

require 'test_helper'

class ChargeTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:organization)
  should belong_to(:issuing_participant)
  should belong_to(:receiving_participant)
  should belong_to(:charge_type)

  # Validations


  # Methods
  context "With a proper context, " do
    setup do
      # Create a charges
      @fine = FactoryGirl.create(:charge)
    end

    teardown do
    end

    should "show that all factories are properly created" do
      assert_equal 1, Charge.all.size
    end

    context "Testing charges" do
      should "not let charge with string for amount value be created" do
        charge1 = FactoryGirl.build(:charge, :amount => "a")
        deny charge1.valid?
      end
    end
  end
end
