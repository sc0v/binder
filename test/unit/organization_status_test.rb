require 'test_helper'

class OrganizationStatusTest < ActiveSupport::TestCase

  # Relationships
  should belong_to(:organization_status_type)
  should belong_to(:organization)
  should belong_to(:participant)

  # Validations
  should validate_presence_of(:organization_status_type)
  should validate_presence_of(:organization)
  should validate_presence_of(:participant)

  context 'With a proper context,'  do
    setup do
      @status_type1 = FactoryGirl.create(:organization_status_type)
      @status_type2 = FactoryGirl.create(:organization_status_type, :display => true)
      @org = FactoryGirl.create(:organization)
      @p = FactoryGirl.create(:participant)
      @status1 = FactoryGirl.create(:organization_status,
                :organization_status_type => @status_type1,
                :organization => @org, :participant => @p)
      @status2 = FactoryGirl.create(:organization_status,
                :organization_status_type => @status_type2,
                :organization => @org, :participant => @p)
    end

    teardown do
      @status_type1 = nil
      @status_type2 = nil
      @org = nil
      @p = nil
      @status1 = nil
      @status2 = nil
    end

    should 'show that all factories are properly created' do
      assert_equal 2, OrganizationStatus.all.size
    end

    # Scope
    should 'display statuses that are only displayable' do
      assert_equal 1, OrganizationStatus.displayable.size
    end
  end

end
