require 'spec_helper'

describe "The Page: Emergency Shutdown Procedures ", :type => :feature do
  describe "GET /esp" do
    it "shows basic content" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/esp'
      expect(page).to have_content 'Emergency Shutdown Procedures'
      expect(page).to have_content 'Identify and confirm any details necessitating the shutdown.'
    end
  end

end