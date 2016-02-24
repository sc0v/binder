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

    can :read, Document do |d|
      d.public? or (not d.organization.blank? and d.organization.participants.include?(user.participant))
    end

    can :read_basic_details, Organization do |o|
      o.participants.include?(user.participant)
    end

    can :read, Shift do |s|
      s.organization.participants.include?(user.participant) unless s.organization.nil?
    end

    can :update, Participant, :id => user.participant.id
    can :read_phone_number, Participant, :id => user.participant.id

    can :manage, Membership, :participant_id => user.participant.id

    if user.participant.is_booth_chair?
      can :read, [ChargeType, Checkout, Shift]
      can :read_basic_details, Organization

      can :read_all_details, Organization do |o|
        o.booth_chairs.include?(user.participant)
      end

      can :read, Charge do |c|
        c.organization.booth_chairs.include?(user.participant)
      end

      can :read_phone_number, Participant

      can :update, Membership do |m|
        m.organization.booth_chairs.include?(user.participant)
      end

      cannot :read, Shift, :shift_type => { :name => "Coordinator Shift" }

      can :read, ShiftParticipant do |s|
        s.shift.organization.booth_chairs.include?(user.participant)
      end
    end

    if user.participant.is_scc?
      can :read, :all
      cannot :read, Role

      can [:create, :update], Charge
      can [:create, :update], Checkout
      can [:create, :update], Document
      can [:create, :update, :destroy], Membership
      can [:hardhats, :read_basic_details, :read_all_details], Organization
      can [:create, :update, :destroy], OrganizationStatus
      can [:create, :end, :structural, :electrical, :downtime], OrganizationTimelineEntry
      can [:create, :update, :read_phone_number], Participant
      can :read_coord, Shift
      can :create, ShiftParticipant
      can :update, Task
      can [:create, :update], Tool
    end

    if user.has_role? :admin
      can :manage, :all
    end
  end
end
