# ## Schema Information
#
# Table name: `organization_categories`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`active`**       | `boolean`          | `default(TRUE)`
# **`created_at`**   | `datetime`         |
# **`id`**           | `integer`          | `not null, primary key`
# **`is_building`**  | `boolean`          |
# **`name`**         | `string(255)`      |
# **`updated_at`**   | `datetime`         |
#

require 'test_helper'

class OrganizationCategoryTest < ActiveSupport::TestCase
  # Relationships
  should have_many(:organizations)

  # Validations
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)

  context 'With a proper context, ' do
    setup do
      @cat1 = FactoryGirl.create(:organization_category)
      @cat2 = FactoryGirl.create(:organization_category)
    end

    teardown do
      @cat1 = nil
      @cat2 = nil
    end

    should 'show that all factories are properly created' do
      assert_equal 2, OrganizationCategory.all.size
    end

    # dependency
    should 'remove all associated organizations once this organization category is removed' do
      @org1 = FactoryGirl.create(:organization, organization_category: @cat1)
      @org2 = FactoryGirl.create(:organization, organization_category: @cat1)
      @org3 = FactoryGirl.create(:organization, organization_category: @cat2)
      assert_equal 3, Organization.all.size
      @cat1.destroy
      assert_equal 1, Organization.all.size
    end
  end
end
