# frozen_string_literal: true

require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase
  # Relationships
  should have_many(:organizations).through(:memberships)
  should have_many(:shifts).through(:shift_participants)
  should have_many(:organizations).through(:memberships)
  should have_many(:checkouts)
  should have_many(:tools).through(:checkouts)
  should have_many(:memberships)
  should have_many(:shift_participants)

  # Validations

  context 'With a proper context, ' do
    setup do
      @participant =
        FactoryBot.create(
          :participant,
          phone_number: 1_234_567_890,
          eppn: 'pp00@andrew.cmu.edu',
          cached_name: 'Polly Participant'
        )
      @organization_category = FactoryBot.create(:organization_category)
      @organization =
        FactoryBot.create(
          :organization,
          name: 'Spring Carnival Committee',
          organization_category: @organization_category
        )
      @temp_participant = FactoryBot.create(:participant, phone_number: nil)
      @membership =
        FactoryBot.create(
          :membership,
          is_booth_chair: true,
          participant: @participant,
          organization: @organization
        )
      @checkout = FactoryBot.create(:checkout, participant: @participant)
      @shift_participant =
        FactoryBot.create(:shift_participant, participant: @participant)
    end

    should 'show that all factories are properly created' do
      assert_equal 2, Participant.all.size
    end

    context 'Testing participants' do
      should 'show that dependency on checkout works' do
        assert_equal 1, Checkout.all.size
        @participant.destroy

        assert_equal 0, Checkout.all.size
      end

      should 'show that dependency on membership works' do
        assert_equal 1, Membership.all.size
        @participant.destroy

        assert_equal 0, Membership.all.size
      end

      should 'show that dependency on shift_participant works' do
        assert_equal 1, ShiftParticipant.all.size
        @participant.destroy

        assert_equal 0, ShiftParticipant.all.size
      end

      should 'show that scc scope works properly' do
        assert_equal [@participant], Participant.scc
      end

      should "correctly format a participant's phone number" do
        assert_equal '(123) 456-7890', @participant.formatted_phone_number
        assert_equal 'N/A', @temp_participant.formatted_phone_number
      end

      should 'show that is_booth_chair method works correctly' do
        assert_predicate @participant, :booth_chair?
      end

      should 'show that is_scc method works correctly' do
        assert_predicate @participant, :scc?
      end

      should 'show that name method works correctly' do
        assert_equal 'Polly Participant', @participant.name
      end

      should 'show that surname method works correctly' do
        assert_equal 'Participant', @participant.surname
      end

      should 'show that email method works correctly' do
        assert_equal 'pp00@andrew.cmu.edu', @participant.email
      end

      should 'show that department method works correctly' do
        assert_equal 'Art', @participant.department
      end

      should 'show that formatted_phone_number method works correctly' do
        assert_equal '(123) 456-7890', @participant.formatted_phone_number
      end

      should 'show that formatted_name method works correctly' do
        assert_equal 'Polly Participant (pp00@andrew.cmu.edu)',
                     @participant.formatted_name
      end
    end
  end
end
