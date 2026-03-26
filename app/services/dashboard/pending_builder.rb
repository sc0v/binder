# frozen_string_literal: true

module Dashboard
  # Builds a pending action payload from the stateless dashboard flow params.
  class PendingBuilder
    def call(flow)
      case flow['kind']
      when 'checkin' then build_checkin(flow)
      when 'checkout' then build_checkout(flow)
      when 'lift' then build_lift(flow)
      when 'queue' then build_queue(flow)
      else { error: I18n.t('dashboard.errors.unknown_flow') }
      end
    end

    private

    def build_checkin(flow)
      return { error: I18n.t('dashboard.errors.scan_tool') } if Array(flow['tool_ids']).empty?

      { pending: { 'action' => 'checkin_tools_cart' } }
    end

    def build_checkout(flow)
      return { error: I18n.t('dashboard.errors.scan_tool') } if Array(flow['tool_ids']).empty?
      return { error: I18n.t('dashboard.errors.select_borrower') } if flow['participant_id'].blank?
      return { error: I18n.t('dashboard.errors.select_organization') } if flow['organization_id'].blank?

      participant = Participant.find_by(id: flow['participant_id'])
      organization = Organization.find_by(id: flow['organization_id'])
      return { error: I18n.t('dashboard.errors.invalid_borrower_or_org') } if participant.blank? || organization.blank?

      org_valid = participant.organizations.exists?(organization.id)
      return { error: I18n.t('dashboard.errors.org_invalid_for_borrower') } unless org_valid

      {
        pending: {
          'action' => 'checkout_tools_cart',
          'participant_id' => participant.id,
          'organization_id' => organization.id
        }
      }
    end

    def build_lift(flow)
      return { error: I18n.t('dashboard.errors.select_lift_action') } if flow['lift_action'].blank?
      return { error: I18n.t('dashboard.errors.select_scissor_lift') } if flow['scissor_lift_id'].blank?

      case flow['lift_action']
      when 'renew' then build_lift_renew(flow)
      when 'checkin' then build_lift_checkin(flow)
      when 'checkout' then build_lift_checkout(flow)
      else { error: I18n.t('dashboard.errors.unknown_lift_action') }
      end
    end

    def build_lift_renew(flow)
      return { error: I18n.t('dashboard.errors.set_renewal_hours') } if flow['hours'].blank?

      { pending: { 'action' => 'renew_scissor_lift', 'scissor_lift_id' => flow['scissor_lift_id'],
                   'hours' => flow['hours'] } }
    end

    def build_lift_checkin(flow)
      { pending: { 'action' => 'checkin_scissor_lift', 'scissor_lift_id' => flow['scissor_lift_id'] } }
    end

    def build_lift_checkout(flow)
      return { error: I18n.t('dashboard.errors.select_borrower') } if flow['participant_id'].blank?
      return { error: I18n.t('dashboard.errors.select_organization') } if flow['organization_id'].blank?

      participant = Participant.find_by(id: flow['participant_id'])
      organization = Organization.find_by(id: flow['organization_id'])
      return { error: I18n.t('dashboard.errors.invalid_borrower_or_org') } if participant.blank? || organization.blank?

      org_valid = participant.organizations.exists?(organization.id)
      return { error: I18n.t('dashboard.errors.org_invalid_for_borrower') } unless org_valid

      {
        pending: {
          'action' => 'checkout_scissor_lift',
          'scissor_lift_id' => flow['scissor_lift_id'],
          'participant_id' => participant.id,
          'organization_id' => organization.id
        }
      }
    end

    def build_queue(flow)
      return { error: I18n.t('dashboard.errors.select_queue_type') } if flow['queue_type'].blank?
      return { error: I18n.t('dashboard.errors.select_queue_action') } if flow['queue_action'].blank?
      return { error: I18n.t('dashboard.errors.select_organization') } if flow['organization_id'].blank?

      valid_action = %w[add remove].include?(flow['queue_action'])
      return { error: I18n.t('dashboard.errors.invalid_queue_action') } unless valid_action

      return build_queue_add(flow) if flow['queue_action'] == 'add'

      { pending: { 'action' => 'remove_queue', 'queue_type' => flow['queue_type'],
                   'organization_id' => flow['organization_id'] } }
    end

    def build_queue_add(flow)
      return { error: I18n.t('dashboard.errors.select_queue_source') } if flow['queue_source'].blank?

      if flow['queue_source'] == 'by_user'
        return { error: I18n.t('dashboard.errors.select_borrower') } if flow['participant_id'].blank?

        participant = Participant.find_by(id: flow['participant_id'])
        return { error: I18n.t('dashboard.errors.invalid_borrower') } if participant.blank?

        org_valid = participant.organizations.exists?(flow['organization_id'])
        return { error: I18n.t('dashboard.errors.org_invalid_for_borrower') } unless org_valid
      end

      return { error: I18n.t('dashboard.errors.enter_queue_message') } if flow['queue_message'].blank?

      {
        pending: {
          'action' => 'add_queue',
          'queue_type' => flow['queue_type'],
          'organization_id' => flow['organization_id'],
          'queue_message' => flow['queue_message']
        }
      }
    end
  end
end
