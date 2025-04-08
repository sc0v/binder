# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)

    # CertificationType
    # Certification
    # ChargeType
    # Charge
    # Checkout
    # EventType                        -- Not currently used: Feature No Longer Used
    # Event                            -- Not currently used: Feature No Longer Used
    can :read, FAQ, organization_category: nil
    # Membership
    # Note
    # OrganizationBuildStatus
    # OrganizationBuildStep
    # OrganizationCategory
    # OrganizationStatusType           -- Not currently used: BuildStatus
    # OrganizationTimelineEntry
    # OrganizationTimelineEntryType    -- Not currently used: Enum in OrgTimelineEntry
    can :read, Organization, %i[id name short_name building? category_name downtime_link remaining_downtime]
    can :login, Participant
    # ScissorLiftCheckout
    # ScissorLift  
    # ShiftParticipant                 -- Not currently used: Feature No Longer Used
    # ShiftType                        -- Not currently used: Feature No Longer Used
    # Shift                            -- Not currently used: Feature No Longer Used
    # StoreItem
    # StorePurchase
    # Task                             -- Not currently used: Feature No Longer Used
    # ToolInventory
    # ToolInventoryTool
    # ToolTypeCertification            -- Not currently used: ScissorLift is now a separate model
    # ToolType
    # Tool 

    return unless user.present?

    can :participate, :carnival if user.signed_waiver?

    can :read, CertificationType
    can :read, Certification, participant_id: user.id
    can :read, ChargeType
    # Charge: No Access
    can :read, Checkout, organization: { memberships: { paricipant_id: user.id } }
    # EventType                        -- Not currently used: Feature No Longer Used
    # Event                            -- Not currently used: Feature No Longer Used
    can :read, FAQ, 
      organization_category: {
        organizations: {
          memberships: {
            participant_id: user.id
          }
        }
      }
    can :read, Membership, organization: { memberships: { participant_id: user.id } }
    can :read, Note, organization: { memberships: { participant_id: user.id } }
    can :read, OrganizationBuildStatus, organization: { memberships: { participant_id: user.id } }
    can :read, OrganizationBuildStep, 
      organization_build_status: {
        organization: {
          memberships: {
            participant_id: user.id
          }
        }
      }
    can :read, OrganizationCategory
    # OrganizationStatusType           -- Not currently used: BuildStatus
    # OrganizationTimelineEntry: No Access
    # OrganizationTimelineEntryType    -- Not currently used: Enum in OrgTimelineEntry
    can :read, Organization
    can %i[read read_phone_number], Participant
    cannot :login, Participant
    can :skip_safety_video, Participant, id: user.id, watched_safety_video: true
    can :show, Participant, id: user.id
    can :update, Participant, id: user.id
    can :update, Participant, %i[adult name_confirmation signed_waiver], id: user.id, signed_waiver: [false, nil], watched_safety_video: true
    can :read, ScissorLiftCheckout, organization: { memberships: { paricipant_id: user.id } }
    can :read, ScissorLift
    # ShiftParticipant                 -- Not currently used: Feature No Longer Used
    # ShiftType                        -- Not currently used: Feature No Longer Used
    # Shift                            -- Not currently used: Feature No Longer Used
    can :read, StoreItem
    # StorePurchase: No Access
    # Task                             -- Not currently used: Feature No Longer Used
    # ToolInventory: No Access
    # ToolInventoryTool: No Access
    # ToolTypeCertification            -- Not currently used: ScissorLift is now a separate model
    can :read, ToolType
    can :read, Tool, %i[name t_name link is_checked_out? t_is_checked_out current_organization t_organization_name current_participant t_participant_name]

    if user.is_booth_chair? 
      # CertificationType: Same as Builder
      can %i[:read read_phone_number], Certification,
        participant: {
          memberships: {
            organization: {
              memberships: {
                participant_id: user.id
              }
            }
          }
        }
      # ChargeType: Same as Builder
      # Charge: Same as Builder
      # Checkout: Same as Builder
      # EventType                        -- Not currently used: Feature No Longer Used
      # Event                            -- Not currently used: Feature No Longer Used
      # FAQ: Same as Builder
      # Membership: Same as Builder
      # Note: Same as Builder
      # OrganizationBuildStatus: Same as Builder
      # OrganizationBuildStep: Same as Builder
      # OrganizationCategory: Same as Builder
      # OrganizationStatusType           -- Not currently used: BuildStatus
      can :manage, OrganizationTimelineEntry, organization: { memberships: { participant: user } }
      # OrganizationTimelineEntryType    -- Not currently used: Enum in OrgTimelineEntry
      # Organization: Same as Builder
      can :read, Participant, 
        memberships: {
          organization: {
            memberships: {
              participant_id: user.id
            }
          }
        }
      # ScissorLiftCheckout: Same as Builder
      # ScissorLift: Same as Builder
      # ShiftParticipant                 -- Not currently used: Feature No Longer Used
      # ShiftType                        -- Not currently used: Feature No Longer Used
      # Shift                            -- Not currently used: Feature No Longer Used
      # StoreItem: Same as Builder
      can :read, StorePurchase, charge: { organization: { memberships: { participant_id: user.id } } }
      # Task                             -- Not currently used: Feature No Longer Used
      # ToolInventory: No Access
      # ToolInventoryTool: No Access
      # ToolTypeCertification            -- Not currently used: ScissorLift is now a separate model
      # ToolType: Same as Builder
      # Tool: Same as Builder
    end

    return unless user.scc?

    can :read, :all

    # CertificationType: Same as Builder
    can %i[create update destroy], Certification
    can %i[create update destroy], ChargeType
    can %i[create update], Charge
    can %i[create update], Checkout
    # EventType                        -- Not currently used: Feature No Longer Used
    # Event                            -- Not currently used: Feature No Longer Used
    # FAQ: Same as Builder
    can :manage, Membership
    can %i[create destroy], Note
    can :manage, OrganizationBuildStatus
    can :manage, OrganizationBuildStep
    # OrganizationCategory: Same as Builder
    # OrganizationStatusType           -- Not currently used: BuildStatus
    can :manage, OrganizationTimelineEntry
    # OrganizationTimelineEntryType    -- Not currently used: Enum in OrgTimelineEntry
    can %i[hardhats read_basic_details read_all_details], Organization
    can %i[read_phone_number update create], Participant
    can %i[create update], ScissorLiftCheckout
    can :manage, ScissorLift
    can :manage, ShiftParticipant
    # ShiftType                        -- Not currently used: Feature No Longer Used
    # Shift                            -- Not currently used: Feature No Longer Used
    can :manage, StoreItem
    can %i[create update], StorePurchase
    # Task                             -- Not currently used: Feature No Longer Used
    # ToolInventory: Same as Builder
    can :manage, ToolInventoryTool
    # ToolTypeCertification            -- Not currently used: ScissorLift is now a separate model
    can :manage, ToolType
    can :manage, Tool
    
    return unless user.admin?

    can :manage, :all
    cannot :participate, :carnival unless user.signed_waiver? # show waiver prompts
    cannot :login, Participant # hide login prompts

    return # TODO: Make sure new abilities above match with old abilities below
           # Because of this return, abilities below have no effect!
    
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
      can :read, Note, %i[hidden? organization_name organization_link participant_name participant_link], participant_id: user.id
      can :read, Note, organization: { memberships: { participant_id: user.id } }
      
      
      if user.scc?
        #can
      end
    end

    # Organizations
    can :read, Organization, %i[id name short_name building? category_name downtime_link remaining_downtime]
    if user.present?
      # TODO: request to join
      # cannot request to join, Organization, organization_category: { lookup_key: 'admin' }
      can :show, Organization, memberships: { participant_id: user.id }
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
      if user.scc?
        can :read,
            Participant
        can :read,
            Participant,
            %i[name is_booth_chair? signed_waiver?]
      end
      can :update, Participant, %i[phone_number], id: user.id
    end

    # Organization Timeline Entries (Electrical Queue, Structural Queue, Downtime)
    # TODO: Restrict downtime
    if user.present?
      can :manage, OrganizationTimelineEntry,
        organization: { memberships: { participant: user } }
    end
    
    # Session
    can :login, Participant if user.blank?

    # Tools
    if user.present? && user.scc?
      can :read,
          Tool,
          %i[name t_name link is_checked_out? t_is_checked_out current_organization t_organization_name current_participant t_participant_name]
    end

    # SCC fallback with corrections
    if user.present? && user.scc?
      can :manage, :all
      cannot :participate, :carnival # show waiver prompts
      cannot :login, Participant # hide login prompts
    end
    
    # Admin fallback with corrections
    if user.present? && user.admin?
      can :manage, :all
      cannot :participate, :carnival # show waiver prompts
      cannot :login, Participant # hide login prompts
    end

    # Admins must sign the waiver, too
    can :participate, :carnival if user.present? && user.signed_waiver?

    # TODO: Work through abilities

    return if user.blank?

    cannot :manage, :all

    return if user.blank?

    can :read,
        [
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

      can :read, OrganizationBuildStatus do |s|
        s.organization.booth_chairs.include?(user)
      end
    end

#          can :read,
#          FAQ,
#          organization_category: {
#            organizations: {
#              memberships: {
#                participant_id: user.id
#              }
#            }
#          }


 #   can %i[create edit update structural electrical], OrganizationTimelineEntry #,

    
# do |e|
#      e.organization&.participants&.include?(user)
#    end

#      %w[structural electrical].include?(e.entry_type) &&
#      e.organization.participants.include?(user)
#    end


    
    if user.scc?
      can :read, :all

      can %i[create update], Charge
      can %i[create update], Checkout
      can %i[create update approve], Event
      can %i[create update], EventType
      can %i[create update destroy], Membership
      can %i[hardhats read_basic_details read_all_details], Organization
      can %i[create update destroy], OrganizationBuildStatus
      can %i[create edit update end structural electrical downtime],
          OrganizationTimelineEntry
      can %i[create update read_phone_number], Participant
      can :read_coord, Shift
      can :create, ShiftParticipant
      can %i[create update], StoreItem
      can %i[create complete update], Task
      can %i[create update destroy], Tool
      can %i[create update], ToolType
      can %i[create destroy], Certification
    end

    return unless user.admin?

    can :manage, :all
    # can :skip_video, WaiversController
  end
end
