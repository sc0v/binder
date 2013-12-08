require 'spec_helper'

describe "Presentation", :type => :feature do
  before :each do
    create_mocks
  end

  after :each do
    destroy_mocks

    Warden.test_reset! 
  end

  describe "Tool Checkout" do
    it "can checkout existing tool with set id card swipe" do
      login_as @rachel_user, scope: :user
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/tools'

      expect(page).to have_content 'Checkout Tool'

      #DEBUG: 
      save_and_open_page
      click_link 'Checkout Tool'

      #save_and_open_page
      within("#new_checkout") do
        fill_in 'checkout_tool_id', :with => '1239043'
        fill_in 'checkout_card_number', :with => '1234'
      end

      click_button 'Check Tool Out'

      expect(page).to have_content 'Checkout was successfully created.'
      expect(page).to have_content 'Tool'
      expect(page).to have_content 'Name: Saw'
      expect(page).to have_content 'Barcode: 1239043'
      expect(page).to have_content 'Description: SAW'
      expect(page).to have_content 'Is checked out: Yes'
      expect(page).to have_content 'Checked out by: Default Factory User'
 
    end

    it "checkout non-existing tool with id card swipe" do
      login_as @admin, scope: :user
      false
    end
  end #End of Tool Checkout

  describe "Shift Check In" do
    it "can check in with id card swipe" do
      login_as @admin, scope: :user
      false
    end
  end

  describe "Add new participant" do
    it "can add new participant with id card swipe" do
      login_as @admin, scope: :user
      false
    end
  end #end of Add Participant

  describe "Organization Dashboard" do
    describe "for booth chair" do
      it "can see fines for own org" do 
        login_as @admin, scope: :user
        false

      end

      it "can see members for own org" do 
        login_as @admin, scope: :user
        false

      end

    end

    describe "for SEC admin" do
      it "see fines for all orgs" do 
        login_as @admin, scope: :user
        false

      end

      it "can see members for all org" do 
        login_as @admin, scope: :user
        false

      end

    end

    describe "for member of student org" do
      it "can see booth chairs" do 
        login_as @admin, scope: :user
        false

      end

      it "can booth chairs' phone numbers" do 
        login_as @admin, scope: :user
        false

      end

    end
  end 

end

  