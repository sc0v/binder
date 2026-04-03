# frozen_string_literal: true

module Dashboard
  # Builds a pending action payload from the stateless dashboard flow params.
  class PendingBuilder
    def call(flow)
      case flow['kind']
      when 'checkin'
        build_checkin(flow)
      when 'checkout'
        build_checkout(flow)
      when 'lift'
        build_lift(flow)
      when 'queue'
        build_queue(flow)
      else
        { error: I18n.t('dashboard.errors.unknown_flow') }
      end
    end

    private

    def build_checkin(flow)
      if Array(flow['tool_ids']).empty?
        return { error: I18n.t('dashboard.errors.scan_tool') }
      end

      { pending: { 'action' => 'checkin_tools_cart' } }
    end

    def build_checkout(flow)
      if Array(flow['tool_ids']).empty?
        return { error: I18n.t('dashboard.errors.scan_tool') }
      end
      if flow['participant_id'].blank?
        return { error: I18n.t('dashboard.errors.select_borrower') }
      end
      if flow['organization_id'].blank?
        return { error: I18n.t('dashboard.errors.select_organization') }
      end

      participant = Participant.find_by(id: flow['participant_id'])
      organization = Organization.find_by(id: flow['organization_id'])
      if participant.blank? || organization.blank?
        return { error: I18n.t('dashboard.errors.invalid_borrower_or_org') }
      end

      org_valid = participant.organizations.exists?(organization.id)
      unless org_valid
        return { error: I18n.t('dashboard.errors.org_invalid_for_borrower') }
      end

      {
        pending: {
          'action' => 'checkout_tools_cart',
          'participant_id' => participant.id,
          'organization_id' => organization.id
        }
      }
    end

    def build_lift(flow)
      if flow['lift_action'].blank?
        return { error: I18n.t('dashboard.errors.select_lift_action') }
      end
      if flow['scissor_lift_id'].blank?
        return { error: I18n.t('dashboard.errors.select_scissor_lift') }
      end

      case flow['lift_action']
      when 'renew'
        build_lift_renew(flow)
      when 'checkin'
        build_lift_checkin(flow)
      when 'checkout'
        build_lift_checkout(flow)
      else
        { error: I18n.t('dashboard.errors.unknown_lift_action') }
      end
    end

    def build_lift_renew(flow)
      if flow['hours'].blank?
        return { error: I18n.t('dashboard.errors.set_renewal_hours') }
      end

      {
        pending: {
          'action' => 'renew_scissor_lift',
          'scissor_lift_id' => flow['scissor_lift_id'],
          'hours' => flow['hours']
        }
      }
    end

    def build_lift_checkin(flow)
      {
        pending: {
          'action' => 'checkin_scissor_lift',
          'scissor_lift_id' => flow['scissor_lift_id']
        }
      }
    end

    def build_lift_checkout(flow)
      if flow['participant_id'].blank?
        return { error: I18n.t('dashboard.errors.select_borrower') }
      end
      if flow['organization_id'].blank?
        return { error: I18n.t('dashboard.errors.select_organization') }
      end

      participant = Participant.find_by(id: flow['participant_id'])
      organization = Organization.find_by(id: flow['organization_id'])
      if participant.blank? || organization.blank?
        return { error: I18n.t('dashboard.errors.invalid_borrower_or_org') }
      end

      org_valid = participant.organizations.exists?(organization.id)
      unless org_valid
        return { error: I18n.t('dashboard.errors.org_invalid_for_borrower') }
      end

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
      if flow['queue_type'].blank?
        return { error: I18n.t('dashboard.errors.select_queue_type') }
      end
      if flow['queue_action'].blank?
        return { error: I18n.t('dashboard.errors.select_queue_action') }
      end
      if flow['organization_id'].blank?
        return { error: I18n.t('dashboard.errors.select_organization') }
      end

      valid_action = %w[add remove].include?(flow['queue_action'])
      unless valid_action
        return { error: I18n.t('dashboard.errors.invalid_queue_action') }
      end

      return build_queue_add(flow) if flow['queue_action'] == 'add'

      {
        pending: {
          'action' => 'remove_queue',
          'queue_type' => flow['queue_type'],
          'organization_id' => flow['organization_id']
        }
      }
    end

    def build_queue_add(flow)
      if flow['queue_source'].blank?
        return { error: I18n.t('dashboard.errors.select_queue_source') }
      end

      if flow['queue_source'] == 'by_user'
        if flow['participant_id'].blank?
          return { error: I18n.t('dashboard.errors.select_borrower') }
        end

        participant = Participant.find_by(id: flow['participant_id'])
        if participant.blank?
          return { error: I18n.t('dashboard.errors.invalid_borrower') }
        end

        org_valid = participant.organizations.exists?(flow['organization_id'])
        unless org_valid
          return { error: I18n.t('dashboard.errors.org_invalid_for_borrower') }
        end
      end

      if flow['queue_message'].blank?
        return { error: I18n.t('dashboard.errors.enter_queue_message') }
      end

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
