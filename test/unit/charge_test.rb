require 'test_helper'

class ChargeTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:organization)
  should belong_to(:issuing_participant)
  should belong_to(:receiving_participant)
  should belong_to(:charge_type)

  # Validations


  # Methods
  context "With a proper context, " do
    setup do
      create_context
    end

    teardown do
      remove_context
    end

    should "show that all factories are properly created" do
      assert_equal 2, Charge.all.size
    end

      

      context "Testing charges" do
        should "know charges" do
          assert_equal ["Missed 10/2 meeting", "Breaker trip"], Charge.all.map{|e| e.description}
        end  
      
        should "not let charge with string for amount value be created" do
          charge1 = FactoryGirl.build(:charge, :charge_type => @miss_meeting, :issuing_participant => @rachel, :receiving_participant => nil, :organization => @theta, :amount => "a", :charged_at => Date.today, :description => "Missed 10/2 meeting")
          deny charge1.valid? 
        end
                
      end
  end
end