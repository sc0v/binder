# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)
    # FAQ
    can :read, FAQ, organization_category: nil
    if user.present?
      can :read,
          FAQ,
          organization_category: {
            organizations: {
              memberships: {
                participant_id: user.id
              }
            }
          }
    end

    # Notes
    if user.present?
      can :read, Note, participant_id: user.id
      can :read, Note, organization: { memberships: { participant_id: user.id } }
    end

    # Organizations
    can :read, Organization, %i[name short_name]
    cannot :read, Organization, organization_category: { lookup_key: 'admin' }
    if user.present?
      can :read, Organization, memberships: { participant_id: user.id }
    end

    # Participants
    if user.present?
      can :skip_safety_video,
          Participant,
          id: user.id,
          watched_safety_video: true
      can :show, Participant, id: user.id
      can :update,
          Participant,
          %i[adult name_confirmation signed_waiver],
          id: user.id,
          signed_waiver: [false, nil],
          watched_safety_video: true
      if user.admin?
        can :update, # must add virtual attrs explicitly
            Participant,
            %i[adult name_confirmation]
      end
      can :update, Participant, %i[phone_number], id: user.id
    end

    # Session
    can :login, Participant if user.blank?

    # Admin fallback with corrections
    if user.present? && user.admin?
      can :manage, :all
      cannot :participate, :carnival # show waiver prompts
      cannot :login, Participant # hide login prompts
    end

    # Admins must sign the waiver, too
    can :participate, :carnival if user.present? && user.signed_waiver?

    # TODO: Work through abilities
    return

    return if user.blank?

    cannot :manage, :all

    return if user.blank?

    can :read,
        [
          OrganizationAlias,
          OrganizationCategory,
          Organization,
          Participant,
          ShiftType,
          Tool,
          Membership
        ]

    can :search, :all

    can :read, Checkout do |c|
      c.organization.participants.include?(user)
    end

    can :read_basic_details, Organization do |o|
      o.participants.include?(user)
    end

    can :read_org_details, Organization do |o|
      o.participants.include?(user)
    end

    can :read, Shift do |s|
      s.organization&.participants&.include?(user)
    end

    can :update, Participant, id: user.id
    can :read_phone_number, Participant, id: user.id

    can :read, StoreItem

    can %i[read structural electrical], OrganizationTimelineEntry

    if user.is_booth_chair?
      can :read, [ChargeType, Checkout, Shift]
      can :read_basic_details, Organization

      can :read_all_details, Organization do |o|
        o.participants.include?(user)
      end

      can :read, Charge do |c|
        c.organization.booth_chairs.include?(user)
      end

      can :read_phone_number, Participant

      can %i[create update destroy], Membership do |m|
        m.organization.booth_chairs.include?(user)
      end

      cannot :read, Shift, shift_type: { name: 'Coordinator Shift' }

      can :read, ShiftParticipant do |s|
        s.shift.organization.booth_chairs.include?(user)
      end

      can %i[create end], OrganizationTimelineEntry do |e|
        %w[structural electrical].include?(e.entry_type) &&
          e.organization.booth_chairs.include?(user)
      end

      can :read, OrganizationStatus do |s|
        s.organization.booth_chairs.include?(user)
      end
    end

    if user.scc?
      can :read, :all

      can %i[create update], Charge
      can %i[create update], Checkout
      can %i[create update approve], Event
      can %i[create update], EventType
      can %i[create update destroy], Membership
      can %i[hardhats read_basic_details read_all_details], Organization
      can %i[create update destroy], OrganizationStatus
      can %i[create update], OrganizationStatusType
      can %i[create edit update end structural electrical downtime],
          OrganizationTimelineEntry
      can %i[create update read_phone_number], Participant
      can :read_coord, Shift
      can :create, ShiftParticipant
      can %i[create update], StoreItem
      can %i[create complete update], Task
      can %i[create update], Tool
      can %i[create update], ToolType
      can %i[create destroy], Certification
    end

    return unless user.admin?

    can :manage, :all
    can :skip_video, WaiversController
  end
end
