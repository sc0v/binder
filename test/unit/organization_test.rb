# frozen_string_literal: true

require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:organization_category)
  should have_many(:memberships)
  should have_many(:participants).through(:memberships)
  should have_many(:charges)
  should have_many(:tools).through(:checkouts)
  should have_many(:checkouts)
  should have_many(:shifts)
  should have_many(:organization_timeline_entries)

  # Validations
  should validate_presence_of(:organization_category).with_message(:required)
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)

  context 'With a proper context, ' do
    setup do
      @short_org =
        FactoryBot.create(:organization, name: 'short name', short_name: 'name')
      @long_org =
        FactoryBot.create(:organization, name: 'long name', short_name: nil)
    end

    should 'show that all factories are properly created' do
      assert_equal 2, Organization.all.size
    end

    # search
    should 'show that the search scope functions correcly' do
      assert_equal ['long name'], Organization.search('long name').map(&:name)
      assert_equal ['long name', 'short name'],
                   Organization.search('name').map(&:name).sort
    end

    # ---------------------------- End of scope testing

    # Methods
    should 'have a short_name method' do
      assert_equal('name', @short_org.short_name)
      assert_equal('long name', @long_org.short_name)
    end

    should 'give back the correct booth chair for this organization' do
      chair_person = FactoryBot.create(:participant)
      FactoryBot.create(
        :membership,
        is_booth_chair: true,
        organization: @short_org,
        participant: chair_person
      )

      assert_equal [chair_person.eppn], @short_org.booth_chairs.map(&:eppn)
      assert_equal [], @long_org.booth_chairs
    end

    should 'give back the correct hour of current downtime' do
      t = Time.zone.now
      FactoryBot.create(
        :organization_timeline_entry,
        entry_type: 2,
        started_at: t - 2.hours,
        ended_at: t,
        organization: @short_org
      )

      assert_equal 2.hours, @short_org.downtime
    end

    should 'give back the correct hour of remaining downtime' do
      t = Time.zone.now
      FactoryBot.create(
        :organization_timeline_entry,
        entry_type: 2,
        started_at: t - 3.hours,
        ended_at: t,
        organization: @short_org
      )

      assert_equal 1.hour, @short_org.remaining_downtime
    end

    # --------------------------- End of Methods testing

    # Dependencies

    should 'delete all associated organization_timeline_entries once the organization is removed' do
      FactoryBot.create(:organization_timeline_entry, organization: @short_org)
      FactoryBot.create(:organization_timeline_entry, organization: @short_org)
      FactoryBot.create(:organization_timeline_entry, organization: @long_org)

      assert_equal 3, OrganizationTimelineEntry.all.size
      @short_org.destroy

      assert_equal 1, OrganizationTimelineEntry.all.size
    end

    should 'delete all associated charges once the organization is removed' do
      issuer = FactoryBot.create(:participant)
      type = FactoryBot.create(:charge_type)

      FactoryBot.create(
        :charge,
        organization: @short_org,
        issuing_participant: issuer,
        charge_type: type
      )
      FactoryBot.create(
        :charge,
        organization: @short_org,
        issuing_participant: issuer,
        charge_type: type,
        is_approved: true
      )
      FactoryBot.create(
        :charge,
        organization: @long_org,
        issuing_participant: issuer,
        charge_type: type
      )

      assert_equal 3, Charge.all.size

      @short_org.destroy

      assert_equal 1, Charge.all.size
    end

    should 'delete all checkouts once the organization is removed' do
      type = FactoryBot.create(:tool_type)
      tool = FactoryBot.create(:tool, tool_type: type)
      FactoryBot.create(:checkout, tool:, organization: @short_org)

      assert_equal 1, Checkout.all.size
      @short_org.destroy

      assert_equal 0, Checkout.all.size
    end
  end
end
