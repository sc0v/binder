# ## Schema Information
#
# Table name: `checkouts`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`checked_in_at`**    | `datetime`         |
# **`checked_out_at`**   | `datetime`         |
# **`created_at`**       | `datetime`         |
# **`id`**               | `integer`          | `not null, primary key`
# **`organization_id`**  | `integer`          |
# **`participant_id`**   | `integer`          |
# **`tool_id`**          | `integer`          |
# **`updated_at`**       | `datetime`         |
#
# ### Indexes
#
# * `index_checkouts_on_tool_id`:
#     * **`tool_id`**
#

require 'test_helper'

class CheckoutTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:participant)
  should belong_to(:organization)
  should belong_to(:tool)

  # Validations
  should validate_presence_of(:tool)
  should validate_presence_of(:organization)

  context "With a proper context, " do
    setup do
      @org = FactoryGirl.create(:organization, name: "bruce")
      @person = FactoryGirl.create(:participant)
      @type1 = FactoryGirl.create(:tool_type, name: "hammer")
      @type2 = FactoryGirl.create(:tool_type, name: "drill")
      @type3 = FactoryGirl.create(:tool_type, name: "lmao")
      @t1 = FactoryGirl.create(:tool, barcode: 1111, tool_type: @type1)
      @t2 = FactoryGirl.create(:tool, barcode: 2222, tool_type: @type2)
      @t3 = FactoryGirl.create(:tool, barcode: 3333, tool_type: @type3)
      @checkout1 = FactoryGirl.create(:checkout, :checked_in_at => Time.now, organization: @org, participant: @person, tool: @t1)
      @checkout2 = FactoryGirl.create(:checkout, :checked_in_at => Time.now, organization: @org, participant: @person, tool: @t2)
      @checkout3 = FactoryGirl.create(:checkout, :checked_in_at => nil, organization: @org, participant: @person, tool: @t3)
    end

    teardown do
    end

    should "show that all factories are properly created" do
      assert_equal 3, Checkout.all.size
    end

    # Scopes
    should "show that current scope works" do
      assert_equal 1, Checkout.current.size
    end

    should "show that old scope works" do
      assert_equal 2, Checkout.old.size
    end



  end
end
