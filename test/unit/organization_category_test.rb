# ## Schema Information
#
# Table name: `organization_categories`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`created_at`**  | `datetime`         |
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string(255)`      |
# **`updated_at`**  | `datetime`         |
#

require 'test_helper'

class OrganizationCategoryTest < ActiveSupport::TestCase
  # Relationships
  should have_many(:organizations)

  # Validations

  context "With a proper context, " do
    setup do
      FactoryGirl.create(:organization_category)
    end

    teardown do
    end

    should "show that all factories are properly created" do
      assert_equal 1, OrganizationCategory.all.size
    end

    # Scopes

    # Methods

  end
end
