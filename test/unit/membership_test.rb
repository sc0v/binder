# ## Schema Information
#
# Table name: `memberships`
#
# ### Columns
#
# Name                     | Type               | Attributes
# ------------------------ | ------------------ | ---------------------------
# **`booth_chair_order`**  | `integer`          |
# **`created_at`**         | `datetime`         |
# **`id`**                 | `integer`          | `not null, primary key`
# **`is_booth_chair`**     | `boolean`          |
# **`organization_id`**    | `integer`          |
# **`participant_id`**     | `integer`          |
# **`title`**              | `string(255)`      |
# **`updated_at`**         | `datetime`         |
#
# ### Indexes
#
# * `index_memberships_on_organization_id`:
#     * **`organization_id`**
# * `index_memberships_on_participant_id`:
#     * **`participant_id`**
#

require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:organization)
  should belong_to(:participant)

  # Validations
  should validate_presence_of(:participant)
  should validate_presence_of(:organization)

  context "With a proper context, " do
    setup do
      FactoryGirl.create(:membership)
      @chair = FactoryGirl.create(:membership, :is_booth_chair => true)
    end

    teardown do
    end

    should "show that all factories are properly created" do
      assert_equal 2, Membership.all.size
    end

    # Scopes

    # Methods
    context "Testing memberships" do
      should "know booth chairs" do
        #puts Membership.booth_chairs.map{ |bc| bc.participant.andrewid }
        assert_equal 1, Membership.booth_chairs.size
        assert_equal @chair, Membership.booth_chairs.first
      end
    end
  end
end
