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

  context 'With a proper context, ' do
    setup do
      @org1 = FactoryGirl.create(:organization)
      @org2 = FactoryGirl.create(:organization)
      @nonchair = FactoryGirl.create(:membership, organization: @org1)
      @chair = FactoryGirl.create(:membership, organization: @org2, :is_booth_chair => true)
    end

    teardown do
      @nonchair = nil
      @chair = nil
    end

    should 'show that all factories are properly created' do
      assert_equal 2, Membership.all.size
    end

    # Scopes
    should 'booth_chair scope should return all booth chairs' do
      assert_equal 1, Membership.booth_chairs.size
    end

    # Methods
    should 'formatted_name should return the organization followed and indication if this member is booth chair' do
      assert_equal "#{@org1.name}", @nonchair.organization_name_formatted
      assert_equal "#{@org2.name} - Booth Chair", @chair.organization_name_formatted
    end
  end
end
