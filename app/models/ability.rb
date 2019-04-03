class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    cannot :manage, :all

    if (user.participant.blank?)
      return
    end

    can :read, [OrganizationAlias, OrganizationCategory, Organization, Participant,
                ShiftType, Tool, Membership]

    can :search

    can :read, Checkout do |c|
      c.organization.participants.include?(user.participant)
    end

    can :read_basic_details, Organization do |o|
      o.participants.include?(user.participant)
    end

    can :read_org_details, Organization do |o|
      o.participants.include?(user.participant)
    end

    can :read, Shift do |s|
      s.organization.participants.include?(user.participant) unless s.organization.nil?
    end

    can :update, Participant, :id => user.participant.id
    can :read_phone_number, Participant, :id => user.participant.id

    can :read, StoreItem

    can [:read, :structural, :electrical], OrganizationTimelineEntry

    if user.participant.is_booth_chair?
      can :read, [ChargeType, Checkout, Shift]
      can :read_basic_details, Organization

      can :read_all_details, Organization do |o|
        o.participants.include?(user.participant)
      end

      can :read, Charge do |c|
        c.organization.booth_chairs.include?(user.participant)
      end

      can :read_phone_number, Participant

      can [:create, :update, :destroy], Membership do |m|
        m.organization.booth_chairs.include?(user.participant)
      end

      cannot :read, Shift, :shift_type => { :name => "Coordinator Shift" }

      can :read, ShiftParticipant do |s|
        s.shift.organization.booth_chairs.include?(user.participant)
      end

      can [:create, :end], OrganizationTimelineEntry do |e|
        ['structural', 'electrical'].include?(e.entry_type) && e.organization.booth_chairs.include?(user.participant)
      end

      can :read, OrganizationStatus do |s|
        s.organization.booth_chairs.include?(user.participant)
      end
    end

    if user.participant.is_scc?
      can :read, :all
      cannot :read, Role


      can [:create, :update], Charge
      can [:create, :update], Checkout
      can [:create, :update, :approve], Event
      can [:create, :update], EventType
      can [:create, :update, :destroy], Membership
      can [:hardhats, :read_basic_details, :read_all_details], Organization
      can [:create, :update, :destroy], OrganizationStatus
      can [:create, :update], OrganizationStatusType
      can [:create, :edit, :update, :end, :structural, :electrical, :downtime], OrganizationTimelineEntry
      can [:create, :update, :read_phone_number], Participant
      can :read_coord, Shift
      can :create, ShiftParticipant
      can [:create, :update], StoreItem
      can [:create, :complete, :update], Task
      can [:create, :update], Tool
      can [:create, :update], ToolType
      can [:create, :destroy], Certification
    end

    if user.has_role? :admin
      can :manage, :all
      can :skip_video, WaiversController
    end
  end
end
