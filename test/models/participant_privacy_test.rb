# frozen_string_literal: true

require 'test_helper'

# Who can see a participant's profile and phone number. Everyone sees their
# own and those of the people in their organizations; someone in no
# organization sees only themselves. The Spring Carnival Committee and
# administrators see everyone.
class ParticipantPrivacyTest < ActiveSupport::TestCase
  setup do
    @category = OrganizationCategory.create!(name: 'Booth')
    @booth = organization('Sweepstakes Booth')
    @other_booth = organization('Buggy Booth')
    @booth_chair = person('ac00', @booth, booth_chair: true)
    @member = person('mm00', @booth)
    @builder = person('am00', @other_booth)
    @no_organization = person('hf00')
  end

  test 'everyone sees their own profile and phone number' do
    ability = Ability.new(@no_organization)

    assert ability.can?(:show, @no_organization)
    assert ability.can?(:read_phone_number, @no_organization)
  end

  test "someone with no organization can't see anyone else" do
    ability = Ability.new(@no_organization)

    assert ability.cannot?(:show, @builder)
    assert ability.cannot?(:read_phone_number, @builder)
  end

  test "a member sees their organization's people, with phone numbers" do
    teammate = person('mm01', @booth)
    ability = Ability.new(@member)

    assert ability.can?(:show, teammate)
    assert ability.can?(:read_phone_number, teammate)
    assert ability.can?(:read_phone_number, @booth_chair)
  end

  test "a member doesn't see another organization's people" do
    ability = Ability.new(@member)

    assert ability.cannot?(:show, @builder)
    assert ability.cannot?(:read_phone_number, @builder)
  end

  test "a booth chair sees their organization's people, not others" do
    ability = Ability.new(@booth_chair)

    assert ability.can?(:read_phone_number, @member)
    assert ability.cannot?(:show, @builder)
  end

  test 'the people list holds only their organizations and themselves' do
    visible = Participant.accessible_by(Ability.new(@member))

    assert_includes visible, @booth_chair
    assert_not_includes visible, @builder
  end

  test 'the Spring Carnival Committee sees everyone, with phone numbers' do
    ability = Ability.new(person('hs00', committee))

    assert ability.can?(:show, @no_organization)
    assert ability.can?(:read_phone_number, @no_organization)
  end

  test 'an administrator on the committee sees everyone' do
    ability = Ability.new(person('am01', committee, admin: true))

    assert ability.can?(:show, @no_organization)
    assert ability.can?(:read_phone_number, @no_organization)
  end

  test 'an administrator outside the committee is still an administrator' do
    ability = Ability.new(person('hc00', admin: true))

    assert ability.can?(:show, @no_organization)
    assert ability.can?(:read_phone_number, @no_organization)
    assert ability.can?(:manage, Organization)
  end

  private

  def organization(name)
    Organization.create!(name:, organization_category: @category)
  end

  def committee
    @committee ||= organization('Spring Carnival Committee')
  end

  def person(andrew_id, organization = nil, booth_chair: false, admin: false)
    participant =
      Participant.create!(eppn: "#{andrew_id}@andrew.cmu.edu", admin:)
    if organization
      Membership.create!(
        participant:,
        organization:,
        is_booth_chair: booth_chair
      )
    end
    participant
  end
end
