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
# **`short_name`**                | `string(255)`      |
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
  should have_many(:organization_timeline_entries)
  should have_many(:organization_statuses)
  should have_many(:documents)

  # Validations
  should validate_presence_of(:organization_category)
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)

  context "With a proper context, " do
    setup do
      @short_org = FactoryGirl.create(:organization, :name => 'short name', :short_name => 'name')
      @long_org = FactoryGirl.create(:organization, :name => 'long name', :short_name => nil)
    end

    teardown do
    end

    should "show that all factories are properly created" do
      assert_equal 2, Organization.all.size
    end

    # Scopes
    # only_categories
    should "show that the only_categories functions correctly" do
      short_org_category = @short_org.organization_category.name
      long_org_category = @long_org.organization_category.name
      assert_equal ['short name'], Organization.only_categories(short_org_category).map {|org| org.name}
      assert_equal ['long name'], Organization.only_categories(long_org_category).map {|org| org.name}
    end

    # search
    should "show that the search scope functions correcly" do
      assert_equal ['long name'], Organization.search('long name').map {|org| org.name }
      assert_equal ['long name', 'short name'], Organization.search('name').map {|org| org.name}
    end

    # ---------------------------- End of scope testing

    # Methods
    should 'have a short_name method' do
      assert_equal('name', @short_org.short_name)
      assert_equal('long name', @long_org.short_name)
    end

    should 'give back the correct booth chair for this organization' do
      chair_person = FactoryGirl.create(:participant)
      short_chair = FactoryGirl.create(:membership,
                   is_booth_chair: true,
                   organization: @short_org,
                   participant: chair_person)
      # random_part.update_attribute(:is_booth_chair, true)
      # random_part.update_attribute(:organization, @short_org)
      assert_equal [chair_person.andrewid], @short_org.booth_chairs.map { |bc| bc.andrewid }
      assert_equal [], @long_org.booth_chairs
    end
  end
end
