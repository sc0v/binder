require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase

  context "With a refreshed ldap cache, " do
    setup do
      @participant = FactoryGirl.create(:participant, :andrewid => "erwilson")
    end

    teardown do
    end

    should "check that participant factory object is created and can recieve message calls" do
      @participant.send(:update_cache)
      assert true
    end

    should "return name from directory" do
      assert_equal "Eleanor Wilson", @participant.name
    end

    should "return surname from directory" do
      assert_equal "Wilson", @participant.surname
    end

    should "return email from directory" do
      assert_equal "erwilson@andrew.cmu.edu", @participant.email
    end

    should "return department from directory" do
      assert_equal "Dietrich College Interdisciplinary", @participant.department
    end

    should "return student class from directory" do
      assert_equal "Junior", @participant.student_class
    end
  end
end

