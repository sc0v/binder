# ## Schema Information
#
# Table name: `organization_aliases`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`created_at`**       | `datetime`         |
# **`id`**               | `integer`          | `not null, primary key`
# **`name`**             | `string(255)`      |
# **`organization_id`**  | `integer`          |
# **`updated_at`**       | `datetime`         |
#
# ### Indexes
#
# * `index_organization_aliases_on_name`:
#     * **`name`**
# * `index_organization_aliases_on_organization_id`:
#     * **`organization_id`**
#

require 'test_helper'

class OrganizationAliasTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:organization)

  # Validations
  should validate_presence_of(:name)
  should validate_presence_of(:organization)
  should validate_uniqueness_of(:name)

  context 'With a proper context, ' do
    setup do
      @alias1 = FactoryGirl.create(:organization_alias, name: 'winner')
      @alias2 = FactoryGirl.create(:organization_alias, name: 'loser')
      @org1 = FactoryGirl.create(:organization)
      @org2 = FactoryGirl.create(:organization)
      @alias1.organization = @org1
      @alias2.organization = @org2
    end

    teardown do
      @alias1 = nil
      @alias2 = nil
      @org1 = nil
      @org2 = nil
    end

    should 'show that all factories are properly created' do
      assert_equal 2, OrganizationAlias.all.size
    end

    # Scopes

    # Search scope
    should 'the search by term function should work correctly' do
      assert_equal 1, OrganizationAlias.search("winner").size
      assert_equal 1, OrganizationAlias.search("loser").size
      assert_equal 0, Organization.search("blah").size
    end

    # Methods
    should 'formatted name should return the organization name followed by the alias in parathesis' do
      answer1 = "#{@org1.name} (winner)"
      answer2 = "#{@org2.name} (loser)"
      assert_equal answer1, @alias1.formatted_name
      assert_equal answer2, @alias2.formatted_name
    end

  end
end
