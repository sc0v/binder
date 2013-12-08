require 'spec_helper'

describe "Organizations", :type => :feature do
  before :each do
    create_mocks

  end

  after :each do
    destroy_mocks
    Warden.test_reset! 
  end


  describe "GET /organizations" do
    it "shows all organizations" do
      login_as @member_user, scope: :user
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/organizations'
      expect(page).to have_content 'Organizations'

      #DEBUG
      #save_and_open_page

      expect(page).to have_content 'Kappa Alpha Theta'
    end
  end

end