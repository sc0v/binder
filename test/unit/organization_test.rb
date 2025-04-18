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
  should validate_presence_of(:organization_category)
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)

  context 'With a proper context, ' do
    setup do
      @short_org = FactoryGirl.create(:organization, name: 'short name', short_name: 'name')
      @long_org = FactoryGirl.create(:organization, name: 'long name', short_name: nil)
    end

    teardown do
    end

    should 'show that all factories are properly created' do
      assert_equal 2, Organization.all.size
    end

    # Scopes
    # only_categories
    should 'show that the only_categories functions correctly' do
      short_org_category = @short_org.organization_category.name
      long_org_category = @long_org.organization_category.name
      assert_equal ['short name'], Organization.only_categories(short_org_category).map(&:name)
      assert_equal ['long name'], Organization.only_categories(long_org_category).map(&:name)
    end

    # search
    should 'show that the search scope functions correcly' do
      assert_equal ['long name'], Organization.search('long name').map(&:name)
      assert_equal ['long name', 'short name'], Organization.search('name').map(&:name)
    end

    # ---------------------------- End of scope testing

    # Methods
    should 'have a short_name method' do
      assert_equal('name', @short_org.short_name)
      assert_equal('long name', @long_org.short_name)
    end

    should 'give back the correct booth chair for this organization' do
      chair_person = FactoryGirl.create(:participant)
      short_chair = FactoryGirl.create(:membership,
                                       is_booth_chair: true,
                                       organization: @short_org,
                                       participant: chair_person)
      assert_equal [chair_person.andrewid], @short_org.booth_chairs.map(&:andrewid)
      assert_equal [], @long_org.booth_chairs
    end

    should 'give back the correct hour of current downtime' do
      t = Time.zone.now
      entry = FactoryGirl.create(:organization_timeline_entry, entry_type: 2,
                                                               started_at: t - 2.hours, ended_at: t, organization: @short_org)

      assert_equal 2.hours, @short_org.downtime
    end

    should 'give back the correct hour of remaining downtime' do
      t = Time.zone.now
      entry = FactoryGirl.create(:organization_timeline_entry, entry_type: 2,
                                                               started_at: t - 3.hours, ended_at: t, organization: @short_org)

      assert_equal 1.hour, @short_org.remaining_downtime
    end

    # --------------------------- End of Methods testing

    # Dependencies

    should 'delete all associated organization_timeline_entries once the organization is removed' do
      entry1 = FactoryGirl.create(:organization_timeline_entry, organization: @short_org)
      entry2 = FactoryGirl.create(:organization_timeline_entry, organization: @short_org)
      entry3 = FactoryGirl.create(:organization_timeline_entry, organization: @long_org)

      assert_equal 3, OrganizationTimelineEntry.all.size
      @short_org.destroy
      assert_equal 1, OrganizationTimelineEntry.all.size
    end

    should 'delete all associated charges once the organization is removed' do
      issuer = FactoryGirl.create(:participant)
      type = FactoryGirl.create(:charge_type)

      charge1 = FactoryGirl.create(:charge,
                                   organization: @short_org, issuing_participant: issuer, charge_type: type)
      charge2 = FactoryGirl.create(:charge,
                                   organization: @short_org, issuing_participant: issuer,
                                   charge_type: type, is_approved: true)
      charge3 = FactoryGirl.create(:charge,
                                   organization: @long_org, issuing_participant: issuer, charge_type: type)

      assert_equal 3, Charge.all.size

      @short_org.destroy

      assert_equal 1, Charge.all.size
    end

    should 'delete all checkouts once the organization is removed' do
      type = FactoryGirl.create(:tool_type)
      tool = FactoryGirl.create(:tool, tool_type: type)
      checkout = FactoryGirl.create(:checkout, tool:, organization: @short_org)
      assert_equal 1, Checkout.all.size
      @short_org.destroy
      assert_equal 0, Checkout.all.size
    end
  end
end
