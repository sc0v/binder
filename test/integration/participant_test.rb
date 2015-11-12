require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase

  context "With a refreshed ldap cache, " do
    setup do
      # Webmock request to card lookup since it doesn't work from random machines
      stub_request(:any, /.*merichar-dev\.eberly\.cmu\.edu.*/).to_return(:body => '{ "andrewid": "meribyte", "expiration": "2013-11-29T00:00:00+00:00" }', :status => 200, :headers => { 'Content-Length' => 17 })

      @participant = FactoryGirl.create(:participant, :andrewid => "meribyte")
    end

    teardown do
    end

    should "check that participant factory object is created and can recieve message calls" do
      @participant.send(:update_cache)
      assert true
    end

    should "check that student object is the same object as the Participant lookup via card number (This depends on the idcard lookup working)" do
      assert_equal @participant, Participant.find_by_card("811825505")
    end

    should "return name from directory" do
      assert_equal "Margaret Richards", @participant.name
    end

    should "return surname from directory" do
      assert_equal "Richards", @participant.surname
    end

    should "return email from directory" do
      assert_equal "mouse@cmu.edu", @participant.email
    end

    should "return department from directory" do
      assert_equal "Eberly Center, Teaching Excellence & Educational Innovation", @participant.department
    end

    should "return student class from directory" do
      assert_equal "Masters", @participant.student_class
    end
  end
end

