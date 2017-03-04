# ## Schema Information
#
# Table name: `participants`
#
# ### Columns
#
# Name                             | Type               | Attributes
# -------------------------------- | ------------------ | ---------------------------
# **`andrewid`**                   | `string(255)`      |
# **`cache_updated`**              | `datetime`         |
# **`cached_department`**          | `string(255)`      |
# **`cached_email`**               | `string(255)`      |
# **`cached_name`**                | `string(255)`      |
# **`cached_student_class`**       | `string(255)`      |
# **`cached_surname`**             | `string(255)`      |
# **`created_at`**                 | `datetime`         |
# **`has_signed_hardhat_waiver`**  | `boolean`          |
# **`has_signed_waiver`**          | `boolean`          |
# **`id`**                         | `integer`          | `not null, primary key`
# **`phone_carrier_id`**           | `integer`          |
# **`phone_number`**               | `string(255)`      |
# **`updated_at`**                 | `datetime`         |
# **`user_id`**                    | `integer`          |
#
# ### Indexes
#
# * `index_participants_on_phone_carrier_id`:
#     * **`phone_carrier_id`**
#

require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase
  # Relationships
  should have_many(:organizations).through(:memberships)
  should have_many(:shifts).through(:shift_participants)
  should have_many(:organizations).through(:memberships)
  should have_many(:checkouts)
  should have_many(:tools).through(:checkouts)
  should have_many(:memberships)
  should have_many(:shift_participants)
  should belong_to(:user)

  # Validations

  context "With a proper context, " do
    setup do
      @participant = FactoryGirl.create(:participant, :phone_number => 1234567890, :andrewid => "agoradia", :cached_name => "Akshay Goradia",)
      @organization_category = FactoryGirl.create(:organization_category)
      @organization = FactoryGirl.create(:organization, :name => "Spring Carnival Committee", :organization_category => @organization_category)
      @temp_participant = FactoryGirl.create(:participant)
      @membership = FactoryGirl.create(:membership, :is_booth_chair => true, :participant => @participant, :organization => @organization)

    end

    teardown do
    end

    should "show that all factories are properly created" do
      assert_equal 2, Participant.all.size
    end

    context "Testing participants" do

      should "show that search scope works properly" do
        assert_equal [@participant], Participant.search("agoradia")
        assert_equal [], Participant.search("rkelly")
      end

      should "show that scc scope works properly" do
        assert_equal [@participant], Participant.scc
      end

      should "correctly format a participant's phone number" do
        assert_equal "(123) 456-7890", @participant.formatted_phone_number
        assert_equal "N/A", @temp_participant.formatted_phone_number
      end

      should "show that is_booth_chair method works correctly" do
        assert_equal true, @participant.is_booth_chair?
      end

      should "show that is_scc method works correctly" do
        assert_equal true, @participant.is_scc?
      end

      should "show that card_number and card_number= methods works correctly" do
        @participant.card_number=("818603330")
        assert_equal "818603330", @participant.card_number
      end

      should "show that name method works correctly" do
        assert_equal "Akshay Goradia", @participant.name
      end

      should "show that surname method works correctly" do
        assert_equal "Goradia", @participant.surname
      end

      should "show that email method works correctly" do
        assert_equal "agoradia@cmu.edu", @participant.email
      end

      should "show that department method works correctly" do
        assert_equal "Dietrich College Interdisciplinary, Human-Computer Interaction", @participant.department
      end

      should "show that student_class method works correctly" do
        assert_equal "Junior", @participant.student_class
      end

      should "show that formatted_phone_number method works correctly" do
        assert_equal "(123) 456-7890", @participant.formatted_phone_number
      end

      should "show that formatted_name method works correctly" do
        assert_equal "Akshay Goradia (agoradia)", @participant.formatted_name
      end

    end
  end
end
