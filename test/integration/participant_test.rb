require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase

  context "With a refreshed ldap cache, " do
    setup do
      create_context
    end

    teardown do
      remove_context
    end
    
    should "check that jonathan_participant factory object is created and can recieve message calls" do
      @jonathan_participant.send(:update_cache)
      assert true
    end

    should "check that student object is the same object as the Participant lookup via card number (This depends on the idcard lookup working)" do
      assert_equal @jonathan_participant, Participant.find_by_card(811825505)
    end

    should "return name from directory" do
      assert_equal "Jonathan U Chung", @jonathan_participant.name
    end

    should "return surname from directory" do
      assert_equal "Chung", @jonathan_participant.surname
    end

    should "return email from directory" do
      assert_equal "jonathanc@cmu.edu", @jonathan_participant.email
    end

    should "return department from directory" do
      assert_equal "Dietrich College Interdisciplinary", @jonathan_participant.department
    end

    should "return student class from directory" do
      assert_equal "Senior", @jonathan_participant.student_class
    end

  end
end
