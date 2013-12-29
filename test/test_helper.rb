#require 'simplecov'
#SimpleCov.start do
#  add_group "Models", "app/models"
#  add_group "Controllers", "app/controllers"
#  add_group "Views", "app/views"
#end

#require 'simplecov-rcov'
#class SimpleCov::Formatter::MergedFormatter
#  def format(result)
#    SimpleCov::Formatter::HTMLFormatter.new.format(result)
#    SimpleCov::Formatter::RcovFormatter.new.format(result)
#  end
#end
#SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter

require 'webmock/minitest'
include WebMock::API


ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase

  def deny(condition)
    assert !condition
  end

  def create_context
    # Create 4 organization categories
    @blitz = FactoryGirl.create(:organization_category, :name => "Blitz")
    @independent = FactoryGirl.create(:organization_category, :name => "Independent")
    @frat = FactoryGirl.create(:organization_category, :name => "Fraternity")
    @sorority = FactoryGirl.create(:organization_category, :name => "Sorority")

    # Create 3 organizations
    @theta = FactoryGirl.create(:organization, :name => "Kappa Alpha Theta", :organization_category => @sorority)
    @sdc = FactoryGirl.create(:organization, :name => "Student Dormitory Council", :organization_category => @independent)
    @scc = FactoryGirl.create(:organization, :name => "Spring Carnival Committee", :organization_category => @independent)

    # Create 3 organization aliases
    @theta_alias = FactoryGirl.create(:organization_alias, :name => "Theta", :organization => @theta)
    @sdc_alias = FactoryGirl.create(:organization_alias, :name => "SDC", :organization => @sdc)
    @scc_alias = FactoryGirl.create(:organization_alias, :name => "SCC", :organization => @scc)

    # Create 3 shift types
    @watch_shift = FactoryGirl.create(:shift_type)
    @security_shift = FactoryGirl.create(:shift_type, :name => "Security Shift")
    @ride_shift = FactoryGirl.create(:shift_type, :name => "Ride Shift")

    # Create 3 shifts
    @shift1 = FactoryGirl.create(:shift, :ends_at => Time.local(2000,1,1,15,0,0), :required_number_of_participants => 3, :starts_at => Time.local(2000,1,1,12,3,0), :organization => @theta, :shift_type => @watch_shift)
    @shift2 = FactoryGirl.create(:shift, :ends_at => Time.local(2000,1,1,15,0,0), :required_number_of_participants => 3, :starts_at => Time.local(2000,1,1,13,4,0), :organization => @sdc, :shift_type => @watch_shift)
    @shift3 = FactoryGirl.create(:shift, :ends_at => Time.local(2000,1,1,15,0,0), :required_number_of_participants => 3, :starts_at => Time.local(2000,1,1,14,10,0), :organization => @theta, :shift_type => @watch_shift)

    #ORDER MATTERS: Participant first, then user.

    # Create 6 participants
    @member_participant = FactoryGirl.create(:participant, :andrewid => "member_FG", :phone_number => 1234567890, :user => @member_user)
    @rachel_participant = FactoryGirl.create(:participant, :andrewid => "rcrown_FG", :phone_number => 6178617669, :user => @rachel_user)
    @shannon_participant = FactoryGirl.create(:participant, :andrewid => "shannon1_FG", :phone_number => 4124124124, :user => @shannon_user)
    @dylan_participant = FactoryGirl.create(:participant, :andrewid => "dcorwin_FG", :phone_number => 4121235555, :user => @dylan_user)
    @alexis_participant = FactoryGirl.create(:participant, :andrewid => "asteger_FG", :phone_number => 5391234124, :user => @alexis_user)
    @jonathan_participant = FactoryGirl.create(:participant, :andrewid => "juc", :phone_number => 4128675309, :user => @jonathan_user)

    # Create 5 users
    @member_user = FactoryGirl.create(:user, :participant => @member_participant)
    @member_user.add_role(:member)

    @rachel_user = FactoryGirl.create(:user, :name => "Rachel Crown", :email => "rcrown_FG@andrew.cmu.edu", :participant => @rachel_participant)
    @rachel_user.add_role(:admin)

    @dylan_user = FactoryGirl.create(:user, :name => "Dylan Corwin", :email => "dcorwin_FG@andrew.cmu.edu", :participant => @dylan_participant)
    @dylan_user.add_role(:admin)

    @alexis_user = FactoryGirl.create(:user, :name => "Alexis Steiger", :email => "asteiger_FG@andrew.cmu.edu", :participant => @alexis_participant)
    @alexis_user.add_role(:booth_chair)

    @shannon_user = FactoryGirl.create(:user, :name => "Shannon Chen", :email => "shannon1_FG@andrew.cmu.edu", :participant => @shannon_participant)
    @shannon_user.add_role(:scc)

    @jonathan_user = FactoryGirl.create(:user, :name => "Jonathan U Chung", :email => "jonathanc@andrew.cmu.edu", :participant => @jonathan_participant)
    @jonathan_user.add_role(:member)

    # Create 2 memberships
    @member_rachel = FactoryGirl.create(:membership, :participant => @rachel_participant, :organization => @scc)
    @member_alexis = FactoryGirl.create(:membership, :participant => @alexis_participant, :organization => @theta, :booth_chair_order => 1, :is_booth_chair => true, :title => nil)
    @member_member = FactoryGirl.create(:membership, :participant => @member_participant, :organization => @sdc)

    # Create 2 charge types
    @miss_meeting = FactoryGirl.create(:charge_type)
    @trip_breaker = FactoryGirl.create(:charge_type, :requires_booth_chair_approval => true)

    # Create 2 charges
    @meeting_fine = FactoryGirl.create(:charge, :charge_type => @miss_meeting, :issuing_participant => @rachel_participant, :receiving_participant => nil, :organization => @theta, :amount => 50.00, :charged_at => Date.today, :description => "Missed 10/2 meeting")
    @breaker_fine = FactoryGirl.create(:charge, :charge_type => @trip_breaker, :issuing_participant => @rachel_participant, :receiving_participant => @alexis_participant, :organization => @theta, :amount => 25.00, :charged_at => Date.today-1, :description => "Breaker trip")

    # Create 3 tasks
    @assign_rides = FactoryGirl.create(:task, :completed_by => @rachel_participant, :due_at => Time.local(2000,1,1,12,3,0))
    @buy_wood = FactoryGirl.create(:task, :name => "Buy wood", :completed_by => @shannon_participant, :due_at => Time.local(2000,1,1,15,0,0))
    @takeout_trash = FactoryGirl.create(:task, :name => "Take-out trash", :completed_by => @dylan_participant, :is_completed => true, :due_at => Time.local(2020,1,1,15,0,0))
        
    # Create 4 tools
    @hammer = FactoryGirl.create(:tool)
    @saw = FactoryGirl.create(:tool, :barcode => 1239043, :description => "SAW", :name => "Saw")
    @ladder = FactoryGirl.create(:tool, :barcode => 120120, :description => "LADDER", :name => "Ladder")
    @hard_hat = FactoryGirl.create(:tool, :barcode => 1280812, :description => "HARD HAT", :name => "Hardhat")
    @radio = FactoryGirl.create(:tool, :name => "Radio")

    # Create 4 checkouts
    @hammer_checkout1 = FactoryGirl.create(:checkout, :checked_in_at => DateTime.now + 3.days, :tool => @hammer, :organization => @sdc)
    @hammer_checkout2 = FactoryGirl.create(:checkout, :tool => @hammer, :organization => @sdc)
    @saw_checkout = FactoryGirl.create(:checkout, :tool => @saw, :organization => @theta, :participant => @shannon_participant)
    @hard_hat_checkout = FactoryGirl.create(:checkout, :tool => @hard_hat, :organization => @theta)
  end

  def remove_context
    # Destroy 4 organization categories
    @blitz.destroy
    @independent.destroy
    @frat.destroy
    @sorority.destroy

    # Destroy 3 organizations
    @theta.destroy
    @sdc.destroy
    @scc.destroy

    # Destroy 3 organization aliases
    @theta_alias.destroy
    @sdc_alias.destroy
    @scc_alias.destroy

    # Destroy 2 charge types
    @miss_meeting.destroy
    @trip_breaker.destroy

    # Destroy 4 participants
    @rachel_participant.destroy
    @shannon_participant.destroy
    @dylan_participant.destroy
    @alexis_participant.destroy
    @member_participant.destroy
    @jonathan_participant.destroy

    # Destroy 3 tasks
    @assign_rides.destroy
    @buy_wood.destroy
    @takeout_trash.destroy

    # Destroy 3 shift types
    @watch_shift.destroy
    @security_shift.destroy
    @ride_shift.destroy

    # Destroy 3 shifts
    @shift1.destroy
    @shift2.destroy
    @shift3.destroy

    # Destroy 4 tools
    @hammer.destroy
    @saw.destroy
    @ladder.destroy
    @hard_hat.destroy
    @radio.destroy

    # Destroy 2 charges
    @meeting_fine.destroy
    @breaker_fine.destroy

    # Destroy 2 memberships
    @member_rachel.destroy
    @member_alexis.destroy

    # Destroy 5 users
    @member_user.destroy
    @alexis_user.destroy
    @shannon_user.destroy
    @rachel_user.destroy
    @jonathan_user.destroy
  end
end
