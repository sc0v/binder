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
   # @person1 = FactoryGirl.create(:participant, :andrewid => 'ersmith')
    @person2 = FactoryGirl.create(:participant, :andrewid => 'erbob')
    @person3 = FactoryGirl.create(:participant, :andrewid => 'ersam')

    #making tool types 
     @saw = FactoryGirl.create(:tool_type, name: 'Saw')
     @hammer = FactoryGirl.create(:tool_type, name: 'Hammer')

    # making waitlist
    @wait1 = FactoryGirl.create(:tool_waitlist, :tool_type_id => @saw.id) 
    @wait2 = FactoryGirl.create(:tool_waitlist, :tool_type_id => @saw.id, :wait_start_time => (Time.now + 1.hour) )
    @wait3 = FactoryGirl.create(:tool_waitlist, :tool_type_id => @hammer.id, :wait_start_time => (Time.now + 2.hour))
    end

    teardown do
    end

    should "show that all factories are properly created" do
      assert_equal 3, ToolWaitlist.all.size
    end
    # Scopes

    should "show that for_tool_type scope works" do
      assert_equal 2, ToolWaitlist.for_tool_type(1).size
      assert_equal 1, ToolWaitlist.for_tool_type(1)[0].tool_type_id
      assert_equal 1, ToolWaitlist.for_tool_type(1)[1].tool_type_id
    end

    should "show that by_wait_start_time scope works" do
      assert_equal @wait1.id, ToolWaitlist.by_wait_start_time[0].id
      assert_equal @wait3.id, ToolWaitlist.by_wait_start_time[2].id
    end

    #Methods 
    should "show that duration method works" do
      @wait = FactoryGirl.create(:tool_waitlist, :tool_type_id => @saw.id, :wait_start_time => (Time.now - 1.hour) )
      assert_equal 60, @wait.duration_waiting.round
    end




  end

end
