# ## Schema Information
#
# Table name: `organization_timeline_entries`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`created_at`**       | `datetime`         |
# **`description`**      | `text(65535)`      |
# **`ended_at`**         | `datetime`         |
# **`entry_type`**       | `integer`          |
# **`id`**               | `integer`          | `not null, primary key`
# **`organization_id`**  | `integer`          |
# **`started_at`**       | `datetime`         |
# **`updated_at`**       | `datetime`         |
#
# ### Indexes
#
# * `index_organization_timeline_entries_on_organization_id`:
#     * **`organization_id`**
#

require 'test_helper'

class OrganizationTimelineEntryTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:organization)

  # Validations
  should validate_presence_of(:started_at)
  should validate_presence_of(:entry_type)
  should validate_presence_of(:organization)

  context "With a proper context, " do
    setup do
      time = Time.now
      @finished = FactoryGirl.create(:organization_timeline_entry, :started_at => time - 1.hour, :ended_at => time)
      @not_finished = FactoryGirl.create(:organization_timeline_entry, :started_at => DateTime.now - 12.hours, :ended_at => nil)
    end

    teardown do
    end

    should "show that all factories are properly created" do
      assert_equal 2, OrganizationTimelineEntry.all.size
    end

    # Scopes

    # Methods
    should 'show that the duration method works' do
      assert_equal 1.hour, @finished.duration
      assert_equal 12.hour, (@not_finished.duration / 1.hour).round * 1.hour
    end
  end
end
