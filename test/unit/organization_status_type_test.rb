# ## Schema Information
#
# Table name: `organization_status_types`
#
# ### Columns
#
# Name           | Type               | Attributes
# -------------- | ------------------ | ---------------------------
# **`display`**  | `boolean`          |
# **`id`**       | `integer`          | `not null, primary key`
# **`name`**     | `string(255)`      |
## ## Schema Information
#
# Table name: `organization_status_types`
#
# ### Columns
#
# Name           | Type               | Attributes
# -------------- | ------------------ | ---------------------------
# **`display`**  | `boolean`          |
# **`id`**       | `integer`          | `not null, primary key`
# **`name`**     | `string(255)`      |
#

class OrganizationStatusTypeTest < ActiveRecord::TestCase
  # Relationships
  should have_many(:organization_statuses)
  should have_many(:organizations)
  should have_many(:participants).through(:organization_statuses)

  context "With a proper context, " do
    setup do
      @type1 = FactoryGirl.create(:organization_status_type)
    end

    teardown do
      @type1 = nil
    end


    should "show that all factories are properly created" do
      assert_equal 1, OrganizationStatusType.all.size
    end

    # Dependency
    should "show that status is destroyed if status type is destroyed" do
      org = FactoryGirl.create(:organization)
      person = FactoryGirl.create(:participant)
      status = FactoryGirl.create(:organization_status,
              organization: org, organization_status_type: @type1, participant: person)
      @type1.destroy
      assert status.destroyed?
    end
  end
end