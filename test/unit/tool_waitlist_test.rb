# ## Schema Information
#
# Table name: `tool_waitlists`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`active`**           | `boolean`          | `default(TRUE)`
# **`created_at`**       | `datetime`         |
# **`id`**               | `integer`          | `not null, primary key`
# **`note`**             | `string(255)`      |
# **`organization_id`**  | `integer`          |
# **`participant_id`**   | `integer`          |
# **`tool_type_id`**     | `integer`          |
# **`updated_at`**       | `datetime`         |
# **`wait_start_time`**  | `datetime`         |
#
# ### Indexes
#
# * `index_tool_waitlists_on_tool_type_id`:
#     * **`tool_type_id`**
#

require 'test_helper'

class ToolWaitlistTest < ActiveSupport::TestCase
#Relationships 
  should belong_to(:tool_type)
  should belong_to(:organization)
  should belong_to(:participant)

  #Validations 
  should validate_presence_of(:tool_type)
  should validate_presence_of(:organization)
  should validate_presence_of(:participant)
  should validate_presence_of(:wait_start_time)

  context "With a proper context, " do
    setup do
    # creating people for waitlist 
    @person1 = FactoryGirl.create(:participant, :andrewid => 'ersmith')
    @person2 = FactoryGirl.create(:participant, :andrewid => 'erbob')
    @person3 = FactoryGirl.create(:participant, :andrewid => 'ersam')

    #making tool types 
     @saw = FactoryGirl.create(:tool_type, name: 'Saw')
     @hammer = FactoryGirl.create(:tool_type, name: 'Hammer')

    # making waitlist
    @wait1 = FactoryGirl.create(:tool_waitlist )
    @wait2 = FactoryGirl.create(:tool_waitlist )
    @wait3 = FactoryGirl.create(:tool_waitlist)
    end

    teardown do
    end

    should "show that all factories are properly created" do
      assert_equal 3, ToolWaitlist.all
    end

    # Scopes




  end

end
