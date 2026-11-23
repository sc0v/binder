# frozen_string_literal: true

require 'test_helper'

# Outside staging and production, names come from the made-up directory
# (CarnegieMellonPerson::MADE_UP_PEOPLE), never CMU's
class ParticipantDirectoryTest < ActiveSupport::TestCase
  context 'A test account from the made-up directory, ' do
    setup do
      @participant =
        FactoryBot.create(:participant, eppn: 'bb00@andrew.cmu.edu')
    end

    should 'return name from directory' do
      assert_equal 'Bobby Booth', @participant.name
    end

    should 'return surname from directory' do
      assert_equal 'Booth', @participant.surname
    end

    should 'return email from directory' do
      assert_equal 'bb00@andrew.cmu.edu', @participant.email
    end

    should 'return department from directory' do
      assert_equal 'Civil and Environmental Engineering',
                   @participant.department
    end

    should 'cache the name until it goes stale' do
      @participant.name

      assert_predicate @participant.send(:cache_current?), :present?
    end
  end

  context 'Someone the made-up directory does not know, ' do
    setup do
      @participant =
        FactoryBot.create(:participant, eppn: 'nobody00@andrew.cmu.edu')
    end

    should 'return N/A for the name' do
      assert_equal 'N/A', @participant.name
    end
  end

  should 'never reach the live directory in test' do
    assert_not CarnegieMellonPerson.live?
  end
end
