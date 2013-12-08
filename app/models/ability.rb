class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all

    elsif user.has_role? :scc
      can :manage, :all

      cannot :read, Membership
      cannot :destroy, :all

    elsif user.has_role? :booth_chair
      cannot :manage, :all

      can :read, [ChargeType, Checkout, ContactList, Document, Faq, OrganizationAlias,
                  OrganizationCategory, Participant, Role, ShiftParticipant, ShiftType, Tool,
                  Membership]

      can :read, Charge do |c|
        c.organization.participants.include? (user.participant)
      end

      can :read, Organization do |o|
        o.memberships.where("is_booth_chair=?", true).map{|m| m.participant}.include? (user.participant)
      end

      can :read, Shift do |s|
        s.organization.participants.include? (user.participant)
      end

      can :read, User, :user_id => user.id
      cannot :update, User
      cannot :destroy, User

    elsif user.has_role? :member
      cannot :manage, :all

      can :read, [Checkout, ContactList, Document, Faq, OrganizationAlias,
                  OrganizationCategory, Participant, Role, ShiftParticipant, ShiftType, Tool,
                  Membership]

      can :read, Shift do |s|
        s.organization.participants.include? (user.participant)
      end

      can :read, User, :user_id => user.id

      can :read, Organization do |o|
        o.participants.include? (user.participant)
      end

      cannot :update, Checkout
      
      cannot :update, User
      cannot :destroy, User

    end
  end
end
