# ## Schema Information
#
# Table name: `organizations`
#
# ### Columns
#
# Name                            | Type               | Attributes
# ------------------------------- | ------------------ | ---------------------------
# **`created_at`**                | `datetime`         |
# **`id`**                        | `integer`          | `not null, primary key`
# **`name`**                      | `string(255)`      |
# **`organization_category_id`**  | `integer`          |
# **`updated_at`**                | `datetime`         |
#
# ### Indexes
#
# * `index_organizations_on_organization_category_id`:
#     * **`organization_category_id`**
#

require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:organization_category)
  should have_many(:memberships)
  should have_many(:organization_aliases)
  should have_many(:participants).through(:memberships)
  should have_many(:charges)
  should have_many(:tools).through(:checkouts)
  should have_many(:checkouts)
  should have_many(:shifts)

  # Validations

  context "With a proper context, " do
    setup do
      FactoryGirl.create(:organization)
    end

    teardown do
    end

    should "show that all factories are properly created" do
      assert_equal 1, Organization.all.size
    end

    # Scopes

    # Methods

  end
end
