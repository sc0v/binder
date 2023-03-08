# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(participant)
    participant ||= Participant.new # guest user (not logged in)

    cannot :manage, :all

    return if participant.blank?

    can :read, [OrganizationAlias, OrganizationCategory, Organization, Participant,
                ShiftType, Tool, Membership]

    can :search, :all

    can :read, Checkout do |c|
      c.organization.participants.include?(participant)
    end

    can :read_basic_details, Organization do |o|
      o.participants.include?(participant)
    end

    can :read_org_details, Organization do |o|
      o.participants.include?(participant)
    end

    can :read, Shift do |s|
      s.organization&.participants&.include?(participant)
    end

    can :update, Participant, id: participant.id
    can :read_phone_number, Participant, id: participant.id

    can :read, StoreItem

    can %i[read structural electrical], OrganizationTimelineEntry

    if participant.is_booth_chair?
      can :read, [ChargeType, Checkout, Shift]
      can :read_basic_details, Organization

      can :read_all_details, Organization do |o|
        o.participants.include?(participant)
      end

      can :read, Charge do |c|
        c.organization.booth_chairs.include?(participant)
      end

      can :read_phone_number, Participant

      can [:create, :update, :destroy], Membership do |m|
        m.organization.booth_chairs.include?(participant)
      end

      cannot :read, Shift, shift_type: { name: 'Coordinator Shift' }

      can :read, ShiftParticipant do |s|
        s.shift.organization.booth_chairs.include?(participant)
      end

      can [:create, :end], OrganizationTimelineEntry do |e|
        %w[structural electrical].include?(e.entry_type) && e.organization.booth_chairs.include?(participant)
      end

      can :read, OrganizationStatus do |s|
        s.organization.booth_chairs.include?(participant)
      end
    end

    if participant.is_scc?
      can :read, :all

      can %i[create update], Charge
      can %i[create update], Checkout
      can %i[create update approve], Event
      can %i[create update], EventType
      can %i[create update destroy], Membership
      can %i[hardhats read_basic_details read_all_details], Organization
      can %i[create update destroy], OrganizationStatus
      can %i[create update], OrganizationStatusType
      can %i[create edit update end structural electrical downtime], OrganizationTimelineEntry
      can %i[create update read_phone_number], Participant
      can :read_coord, Shift
      can :create, ShiftParticipant
      can %i[create update], StoreItem
      can %i[create complete update], Task
      can %i[create update], Tool
      can %i[create update], ToolType
      can %i[create destroy], Certification
    end

    return unless participant.admin?

    can :manage, :all
    can :skip_video, WaiversController
  end
end
