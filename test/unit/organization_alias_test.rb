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


  context "With a proper context, " do
    setup do
      create_context
    end

    teardown do
      remove_context
    end

    should "show that all factories are properly created" do
      assert_equal 3, OrganizationAlias.all.size
    end
    
    # Scopes
  
    # Methods


  end
end
