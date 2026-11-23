# frozen_string_literal: true

require 'test_helper'

class OrganizationMembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    category = OrganizationCategory.create!(name: 'Buggy')
    @team =
      Organization.create!(name: 'Sweepstakes', organization_category: category)
    @member = Participant.create!(eppn: 'ac00@andrew.cmu.edu')
    Membership.create!(organization: @team, participant: @member)
  end

  test 'a signed-out visitor cannot read a roster' do
    get organization_participants_path(@team, format: :json)

    assert_response :forbidden
  end

  test 'a member cannot read another organization roster' do
    other =
      Organization.create!(
        name: 'Other Team',
        organization_category: @team.organization_category
      )
    Membership.create!(organization: other, participant: @member)
    viewer = Participant.create!(eppn: 'mm00@andrew.cmu.edu')
    Membership.create!(organization: other, participant: viewer)
    sign_in_as(viewer)

    get organization_participants_path(@team)

    assert_redirected_to root_path
    get organization_participants_path(@team, format: :json)

    assert_response :forbidden
  end

  test 'members receive only roster fields for their organization' do
    sign_in_as(@member)

    get organization_participants_path(@team, format: :json)

    assert_response :success
    row, = response.parsed_body.fetch('data')

    assert_equal @member.id, row.fetch('id')
    assert_equal %w[booth_chair? eppn id link name signed_waiver?],
                 row.keys.sort
  end
end
