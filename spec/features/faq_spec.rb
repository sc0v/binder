require 'spec_helper'

describe "The Page: FAQs", :type => :feature do
  before :each do
    create_mocks

  end

  after :each do
    destroy_mocks

    Warden.test_reset! 
  end
  

  describe "GET /faqs" do
    it "shows basic FAQs" do
   	  login_as @member_user, scope: :user
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/faqs'
      
      #DEBUG: 
      #save_and_open_page
      
      expect(page).to have_content 'FAQs'
      expect(page).to have_content 'What is Booth?'
      expect(page).to have_content 'UC Info Desk'
    end
  end

end