require 'test_helper'

class AbilityTest < ActiveSupport::TestCase

  context "With a proper context, " do
    setup do
      create_context
    end

    teardown do
      remove_context
    end

    # admin tests
    should "admin can manage everything" do
      ability = Ability.new(@rachel_user)
      assert ability.can?(:manage, :all)
    end

    # scc tests
    should "scc can do everything except destroy user" do
      ability = Ability.new(@shannon_user)
      assert ability.can?(:manage, CarnegieMellonIDCard)
      assert ability.can?(:manage, CarnegieMellonPerson)
      assert ability.can?(:manage, Charge)
      assert ability.can?(:manage, ChargeType)
      assert ability.can?(:manage, Checkout)
      assert ability.can?(:manage, ContactList)
      assert ability.can?(:manage, Document)
      assert ability.can?(:manage, Faq)
      assert ability.can?(:manage, Membership)
      assert ability.can?(:manage, Organization)
      assert ability.can?(:manage, OrganizationAlias)
      assert ability.can?(:manage, OrganizationCategory)
      assert ability.can?(:manage, Participant)
      assert ability.can?(:manage, Role)
      assert ability.can?(:manage, Shift)
      assert ability.can?(:manage, ShiftParticipant)
      assert ability.can?(:manage, ShiftType)
      assert ability.can?(:manage, Task)
      assert ability.can?(:manage, TaskStatus)
      assert ability.can?(:manage, Tool)

      assert ability.can?(:create, User)
      assert ability.can?(:update, User)
      assert ability.can?(:read, User)
      assert ability.cannot?(:destroy, User)
    end

    # booth_chair tests
    should "booth chair can do some things but not other things" do
      ability = Ability.new(@alexis_user)
      assert ability.cannot?(:manage, CarnegieMellonIDCard)
      assert ability.cannot?(:manage, CarnegieMellonPerson)

      assert ability.cannot?(:create, Charge)
      assert ability.cannot?(:update, Charge)
      assert ability.cannot?(:destroy, Charge)
      assert ability.can?(:read, Charge.new(:organization => @alexis_user.participant.organizations.first))

      assert ability.can?(:read, ChargeType)
      assert ability.cannot?(:create, ChargeType)
      assert ability.cannot?(:update, ChargeType)
      assert ability.cannot?(:destroy, ChargeType)

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

      assert ability.cannot?(:create, Membership)
      assert ability.cannot?(:update, Membership)
      assert ability.cannot?(:destroy, Membership)
      assert ability.can?(:read, Membership)

      assert ability.cannot?(:create, Organization)
      assert ability.cannot?(:update, Organization)
      assert ability.cannot?(:destroy, Organization)
      assert ability.can?(:read, Organization)
      assert ability.cannot?(:read, @sdc)

      assert ability.cannot?(:create, OrganizationAlias)
      assert ability.cannot?(:update, OrganizationAlias)
      assert ability.cannot?(:destroy, OrganizationAlias)
      assert ability.can?(:read, OrganizationAlias)

      assert ability.cannot?(:create, OrganizationCategory)
      assert ability.cannot?(:update, OrganizationCategory)
      assert ability.cannot?(:destroy, OrganizationCategory)
      assert ability.can?(:read, OrganizationCategory)

      assert ability.cannot?(:create, Participant)
      assert ability.cannot?(:update, Participant)
      assert ability.cannot?(:destroy, Participant)
      assert ability.can?(:read, Participant)

      assert ability.cannot?(:create, Role)
      assert ability.cannot?(:update, Role)
      assert ability.cannot?(:destroy, Role)
      assert ability.can?(:read, Role)

      assert ability.cannot?(:create, Shift)
      assert ability.cannot?(:update, Shift)
      assert ability.cannot?(:destroy, Shift)
      assert ability.can?(:read, Shift.new(:organization => @alexis_user.participant.organizations.first))
      assert ability.cannot?(:create, ShiftParticipant)
      assert ability.cannot?(:update, ShiftParticipant)
      assert ability.cannot?(:destroy, ShiftParticipant)
      assert ability.can?(:read, ShiftParticipant)

      assert ability.cannot?(:create, ShiftType)
      assert ability.cannot?(:update, ShiftType)
      assert ability.cannot?(:destroy, ShiftType)
      assert ability.can?(:read, ShiftType)

      assert ability.cannot?(:manage, Task)
      assert ability.cannot?(:manage, TaskStatus)

      assert ability.cannot?(:create, Tool)
      assert ability.cannot?(:update, Tool)
      assert ability.cannot?(:destroy, Tool)
      assert ability.can?(:read, Tool)

      assert ability.can?(:read, User)
    end

    # member tests
    should "member can do some things but not other things" do
      ability = Ability.new(@member_user)

      assert ability.cannot?(:manage, CarnegieMellonIDCard)
      assert ability.cannot?(:manage, CarnegieMellonPerson)
      assert ability.cannot?(:manage, Charge)
      assert ability.cannot?(:manage, ChargeType)

      assert ability.can?(:read, Checkout)
      assert ability.cannot?(:create, Checkout)
      assert ability.cannot?(:update, Checkout)
      assert ability.cannot?(:destroy, Checkout)

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

      assert ability.cannot?(:create, Membership)
      assert ability.cannot?(:update, Membership)
      assert ability.cannot?(:destroy, Membership)
      assert ability.can?(:read, Membership)

      assert ability.cannot?(:create, Organization)
      assert ability.cannot?(:update, Organization)
      assert ability.cannot?(:destroy, Organization)
      assert ability.can?(:read, Organization)
      assert ability.cannot?(:read, @theta)

      assert ability.cannot?(:create, OrganizationAlias)
      assert ability.cannot?(:update, OrganizationAlias)
      assert ability.cannot?(:destroy, OrganizationAlias)
      assert ability.can?(:read, OrganizationAlias)

      assert ability.cannot?(:create, OrganizationCategory)
      assert ability.cannot?(:update, OrganizationCategory)
      assert ability.cannot?(:destroy, OrganizationCategory)
      assert ability.can?(:read, OrganizationCategory)

      assert ability.cannot?(:create, Participant)
      assert ability.cannot?(:update, Participant)
      assert ability.cannot?(:destroy, Participant)
      assert ability.can?(:read, Participant)

      assert ability.cannot?(:create, Role)
      assert ability.cannot?(:update, Role)
      assert ability.cannot?(:destroy, Role)
      assert ability.can?(:read, Role)

      assert ability.cannot?(:create, Shift)
      assert ability.cannot?(:update, Shift)
      assert ability.cannot?(:destroy, Shift)
      assert ability.can?(:read, Shift.new(:organization => @member_user.participant.organizations.first))

      assert ability.cannot?(:create, ShiftParticipant)
      assert ability.cannot?(:update, ShiftParticipant)
      assert ability.cannot?(:destroy, ShiftParticipant)
      assert ability.can?(:read, ShiftParticipant)

      assert ability.cannot?(:create, ShiftType)
      assert ability.cannot?(:update, ShiftType)
      assert ability.cannot?(:destroy, ShiftType)
      assert ability.can?(:read, ShiftType)

      assert ability.cannot?(:manage, Task)
      assert ability.cannot?(:manage, TaskStatus)

      assert ability.cannot?(:create, Tool)
      assert ability.cannot?(:update, Tool)
      assert ability.cannot?(:destroy, Tool)
      assert ability.can?(:read, Tool)

      assert ability.can?(:read, User)
    end
  end
end
