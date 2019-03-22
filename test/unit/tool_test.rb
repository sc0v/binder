# ## Schema Information
#
# Table name: `tools`
#
# ### Columns
#
# Name                | Type               | Attributes
# ------------------- | ------------------ | ---------------------------
# **`barcode`**       | `integer`          |
# **`created_at`**    | `datetime`         |
# **`description`**   | `text(65535)`      |
# **`id`**            | `integer`          | `not null, primary key`
# **`tool_type_id`**  | `integer`          |
# **`updated_at`**    | `datetime`         |
#
# ### Indexes
#
# * `index_tools_on_barcode`:
#     * **`barcode`**
# * `index_tools_on_tool_type_id`:
#     * **`tool_type_id`**
#

require 'test_helper'

class ToolTest < ActiveSupport::TestCase
  # Relationships
  should have_many(:checkouts)
  should have_many(:participants).through(:checkouts)
  should have_many(:organizations).through(:checkouts)
  should belong_to(:tool_type)

  # Validations
  should validate_uniqueness_of(:barcode)
  should validate_presence_of(:tool_type_id)

  context "With a proper context, " do
    setup do
      # Create 3 organizations
      @theta = FactoryGirl.create(:organization)
      @sdc = FactoryGirl.create(:organization)

      # Create 6 participants
      @shannon_participant = FactoryGirl.create(:participant)

      # Create 6 tools
      @hammer = FactoryGirl.create(:tool, :barcode => 12811, :description => "")

      @saw_type = FactoryGirl.create(:tool_type, name: 'Saw')
      @saw = FactoryGirl.create(:tool, :barcode => 12390, :description => "SAW", tool_type: @saw_type)

      @ladder_type = FactoryGirl.create(:tool_type, name: 'Ladder')
      @ladder = FactoryGirl.create(:tool, :barcode => 12012, :description => "LADDER", tool_type: @ladder_type)

      @hard_hat_type = FactoryGirl.create(:tool_type, name: 'Hardhat')
      @hard_hat_1 = FactoryGirl.create(:tool, :barcode => 12808, :description => "HARD HAT 1", tool_type: @hard_hat_type)
      @hard_hat_2 = FactoryGirl.create(:tool, :barcode => 12809, :description => "HARD HAT 2", tool_type: @hard_hat_type)

      @radio_type = FactoryGirl.create(:tool_type, name: 'Radio')
      @radio = FactoryGirl.create(:tool, :barcode => 12810, tool_type: @radio_type, :description => "RADIO")

      # Create 4 checkouts
      @hammer_checkout1 = FactoryGirl.create(:checkout, :checked_in_at => DateTime.now + 3.days, :tool => @hammer, :organization => @sdc)
      @hammer_checkout2 = FactoryGirl.create(:checkout, :tool => @hammer, :organization => @sdc)
      @saw_checkout = FactoryGirl.create(:checkout, :tool => @saw, :organization => @theta, :participant => @shannon_participant)
      @hard_hat_1_checkout = FactoryGirl.create(:checkout, :tool => @hard_hat_1, :organization => @theta)
    end

    teardown do
    end
    #scopes 

    should "show that all factories are properly created" do
      assert_equal 6, Tool.all.size
    end

    should "show that the by barcode scope works" do
      assert_equal 12012, Tool.by_barcode[0].barcode
      assert_equal 12811, Tool.by_barcode[5].barcode
    end

    should "show that the by type scope works" do
      assert_equal [@hard_hat_1, @hard_hat_2], Tool.by_type(@hard_hat_type)
      assert_equal [@radio], Tool.by_type(@radio_type)
      assert_equal [@ladder], Tool.by_type(@ladder_type)
    end

    should "have a scope 'hardhats' that works" do
       assert_equal 2, Tool.hardhats.size
    end

    should "have a scope 'radios' that works" do
       assert_equal 1, Tool.radios.size
    end

    should "have a scope 'just_tools' that works" do
       assert_equal 3, Tool.just_tools.size
    end

    should "have a scope 'search' that works" do
       assert_equal @radio.barcode, Tool.search('radio')[0].barcode
    end

    should "have a scope 'checked_in' that works" do
      @radio_checkin = FactoryGirl.create(:checkout, :tool => @radio, :checked_out_at => Time.now - 1.hour, :checked_in_at => Time.now + 1.hour)
      @ladder_checkin = FactoryGirl.create(:checkout, :tool => @ladder, :checked_out_at => Time.now - 1.hour, :checked_in_at => Time.now + 1.hour)
      @hardhat2_checkin = FactoryGirl.create(:checkout, :tool => @hard_hat_2, :checked_out_at => Time.now - 1.hour, :checked_in_at => Time.now + 1.hour)
      assert_equal 3, Tool.checked_in.size
    end

    should "have a scope 'checked_out' that works" do
       assert_equal 3, Tool.checked_out.size
    end

    #methods 

     should "show that the 'current_organization' method works" do
      assert_equal @sdc, @hammer.current_organization
      assert_equal @theta, @saw.current_organization
      assert_equal @theta, @hard_hat_1.current_organization
      assert_equal nil, @ladder.current_organization
    end

        should "show that the 'current_participant' method works" do
      assert_equal nil, @hammer.current_participant
      assert_equal @shannon_participant, @saw.current_participant
      assert_equal nil, @hard_hat_1.current_participant
      assert_equal nil, @ladder.current_participant
    end

    should "show that the is_checked_out? method works" do
      assert @hammer.is_checked_out?
      assert @saw.is_checked_out?
      assert @hard_hat_1.is_checked_out?
      deny @ladder.is_checked_out?
    end

    should "show that is_hardhat works" do
      assert @hard_hat_1.is_hardhat?
      deny @radio.is_hardhat?
    end

    should "show that the 'self.checked_out_by_organization(organization)' method works" do
      assert_equal [@saw, @hard_hat_1], Tool.checked_out_by_organization(@theta)
    end

    should "show that name works" do
      assert_equal 'Radio', @radio.name
    end

    should "show that that the method formatted name works" do
      assert_equal '12810: Radio - RADIO', @radio.formatted_name
      assert_equal '12012: Ladder - LADDER', @ladder.formatted_name
      assert_equal '12811: Hammer', @hammer.formatted_name
    end
    
  end
end
