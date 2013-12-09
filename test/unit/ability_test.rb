require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  context "With a proper context, " do
    setup do
      @org = create(:organization)
      @scc = create(:organization, :name => "Spring Carnival Committee")

      @member_participant = create(:participant)
      create(:membership, :participant => @member_participant, :organization => @org)
      @member_user = create(:user, :participant => @member_participant)
      @member_user.add_role(:member)

      @booth_chair_participant = create(:participant)
      create(:membership, :participant => @booth_chair_participant, :organization => @org, :is_booth_chair => true)
      @booth_chair_user = create(:user, :participant => @booth_chair_participant)
      @booth_chair_user.add_role(:booth_chair)

      @scc_participant = create(:participant)
      create(:membership, :participant => @scc_participant, :organization => @scc)
      @scc_user = create(:user, :participant => @scc_participant)
      @scc_user.add_role(:scc)

      @admin_user = create(:user)
      @admin_user.add_role(:admin)
    end

    teardown do
    end

    # member tests
    should "allow a member to do some things but not other things" do
      ability = Ability.new(@member_user)

      assert ability.cannot?(:manage, CarnegieMellonIDCard)
      assert ability.cannot?(:manage, CarnegieMellonPerson)
      assert ability.cannot?(:manage, Charge)
      assert ability.cannot?(:manage, ChargeType)
      assert ability.cannot?(:manage, ContactList)
      assert ability.cannot?(:manage, Document)
      assert ability.cannot?(:manage, Faq)
      assert ability.cannot?(:manage, ShiftParticipant)
      assert ability.cannot?(:manage, Task)
      assert ability.cannot?(:manage, TaskStatus)
      assert ability.cannot?(:manage, User)

      assert ability.cannot?(:create, Checkout)
      assert ability.cannot?(:update, Checkout)
      assert ability.cannot?(:destroy, Checkout)
      assert ability.can?(:read, Checkout)

      assert ability.cannot?(:create, Membership)
      assert ability.cannot?(:update, Membership)
      assert ability.cannot?(:destroy, Membership)
      assert ability.can?(:read, Membership)

      assert ability.cannot?(:create, Organization)
      assert ability.cannot?(:update, Organization)
      assert ability.cannot?(:destroy, Organization)
      assert ability.can?(:read, Organization)

      assert ability.cannot?(:create, OrganizationAlias)
      assert ability.cannot?(:update, OrganizationAlias)
      assert ability.cannot?(:destroy, OrganizationAlias)
      assert ability.can?(:read, OrganizationAlias)

      assert ability.cannot?(:create, OrganizationCategory)
      assert ability.cannot?(:update, OrganizationCategory)
      assert ability.cannot?(:destroy, OrganizationCategory)
      assert ability.can?(:read, OrganizationCategory)

      assert ability.cannot?(:create, Participant)
      assert ability.can?(:update, @member_participant)
      assert ability.cannot?(:update, Participant.new)
      assert ability.cannot?(:destroy, Participant)
      assert ability.can?(:read, Participant)

      assert ability.cannot?(:create, Role)
      assert ability.cannot?(:update, Role)
      assert ability.cannot?(:destroy, Role)
      assert ability.can?(:read, Role)

      assert ability.cannot?(:create, Shift)
      assert ability.cannot?(:update, Shift)
      assert ability.cannot?(:destroy, Shift)
      assert ability.can?(:read, Shift.new(:organization => @org))
      assert ability.cannot?(:read, Shift.new(:organization => Organization.new))

      assert ability.cannot?(:create, ShiftType)
      assert ability.cannot?(:update, ShiftType)
      assert ability.cannot?(:destroy, ShiftType)
      assert ability.can?(:read, ShiftType)

      assert ability.cannot?(:create, Tool)
      assert ability.cannot?(:update, Tool)
      assert ability.cannot?(:destroy, Tool)
      assert ability.can?(:read, Tool)
    end

    # booth_chair tests
    should "allow a booth chair to read most things but not edit anything" do
      ability = Ability.new(@booth_chair_user)
      assert ability.cannot?(:create, Charge)
      assert ability.cannot?(:update, Charge)
      assert ability.cannot?(:destroy, Charge)
      assert ability.can?(:read, Charge.new(:organization => @org))
      assert ability.cannot?(:read, Charge.new(:organization => @scc))

      assert ability.cannot?(:create, ChargeType)
      assert ability.cannot?(:update, ChargeType)
      assert ability.cannot?(:destroy, ChargeType)
      assert ability.can?(:read, ChargeType)

      assert ability.cannot?(:create, Checkout)
      assert ability.cannot?(:update, Checkout)
      assert ability.cannot?(:destroy, Checkout)
      assert ability.can?(:read, Checkout)

      assert ability.cannot?(:create, ContactList)
      assert ability.cannot?(:update, ContactList)
      assert ability.cannot?(:destroy, ContactList)
      assert ability.can?(:read, ContactList)

      assert ability.cannot?(:create, Document)
      assert ability.cannot?(:update, Document)
      assert ability.cannot?(:destroy, Document)
      assert ability.can?(:read, Document)

      assert ability.cannot?(:create, Faq)
      assert ability.cannot?(:update, Faq)
      assert ability.cannot?(:destroy, Faq)
      assert ability.can?(:read, Faq)

      assert ability.cannot?(:create, Shift)
      assert ability.cannot?(:update, Shift)
      assert ability.cannot?(:destroy, Shift)
      assert ability.can?(:read, Shift)

      assert ability.cannot?(:create, ShiftParticipant)
      assert ability.cannot?(:update, ShiftParticipant)
      assert ability.cannot?(:destroy, ShiftParticipant)
      assert ability.can?(:read, ShiftParticipant.new(:shift => Shift.new(:organization => @org)))
      assert ability.cannot?(:read, ShiftParticipant.new(:shift => Shift.new(:organization => @scc)))
    end

    # scc tests
    should "allow a scc member to read everything and create and update some things" do
      ability = Ability.new(@scc_user)
      assert ability.can?(:read, CarnegieMellonIDCard)
      assert ability.can?(:read, CarnegieMellonPerson)
      assert ability.can?(:read, Charge)
      assert ability.can?(:read, ChargeType)
      assert ability.can?(:read, Checkout)
      assert ability.can?(:read, ContactList)
      assert ability.can?(:read, Document)
      assert ability.can?(:read, Faq)
      assert ability.can?(:read, Membership)
      assert ability.can?(:read, Organization)
      assert ability.can?(:read, OrganizationAlias)
      assert ability.can?(:read, OrganizationCategory)
      assert ability.can?(:read, Participant)
      assert ability.can?(:read, Role)
      assert ability.can?(:read, Shift)
      assert ability.can?(:read, ShiftParticipant)
      assert ability.can?(:read, ShiftType)
      assert ability.can?(:read, Task)
      assert ability.can?(:read, TaskStatus)
      assert ability.can?(:read, Tool)
      assert ability.can?(:read, User)

      assert ability.can?(:create, Charge)
      assert ability.can?(:update, Charge)

      assert ability.can?(:create, Checkout)
      assert ability.can?(:update, Checkout)

      assert ability.can?(:create, Participant)
      assert ability.can?(:update, Participant)

      assert ability.can?(:create, ShiftParticipant)
      assert ability.can?(:update, ShiftParticipant)
    end

    # admin tests
    should "allow an admin to manage everything" do
      ability = Ability.new(@admin_user)
      assert ability.can?(:manage, :all)
    end
  end
end
