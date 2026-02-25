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
      else
        { error: 'Unknown flow.' }
      end
    end

    private

    def build_checkin(flow)
      return { error: 'Scan at least one tool.' } if Array(flow['tool_ids']).empty?

      { pending: { 'action' => 'checkin_tools_cart' } }
    end

    def build_checkout(flow)
      return { error: 'Scan at least one tool.' } if Array(flow['tool_ids']).empty?
      return { error: 'Select a borrower.' } if flow['participant_id'].blank?
      return { error: 'Select an organization.' } if flow['organization_id'].blank?

      participant = Participant.find_by(id: flow['participant_id'])
      organization = Organization.find_by(id: flow['organization_id'])
      if participant.blank? || organization.blank?
        return { error: 'Borrower or organization is invalid.' }
      end
      unless participant.organizations.exists?(organization.id)
        return { error: 'Organization is not valid for this borrower.' }
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
      return { error: 'Select lift action.' } if flow['lift_action'].blank?
      return { error: 'Select a scissor lift.' } if flow['scissor_lift_id'].blank?

      if flow['lift_action'] == 'renew'
        return { error: 'Set renewal hours.' } if flow['hours'].blank?
        return {
          pending: {
            'action' => 'renew_scissor_lift',
            'scissor_lift_id' => flow['scissor_lift_id'],
            'hours' => flow['hours']
          }
        }
      end

      if flow['lift_action'] == 'checkin'
        return {
          pending: {
            'action' => 'checkin_scissor_lift',
            'scissor_lift_id' => flow['scissor_lift_id']
          }
        }
      end

      if flow['lift_action'] == 'checkout'
        return { error: 'Select a borrower.' } if flow['participant_id'].blank?
        return { error: 'Select an organization.' } if flow['organization_id'].blank?

        participant = Participant.find_by(id: flow['participant_id'])
        organization = Organization.find_by(id: flow['organization_id'])
        if participant.blank? || organization.blank?
          return { error: 'Borrower or organization is invalid.' }
        end
        unless participant.organizations.exists?(organization.id)
          return { error: 'Organization is not valid for this borrower.' }
        end

        return {
          pending: {
            'action' => 'checkout_scissor_lift',
            'scissor_lift_id' => flow['scissor_lift_id'],
            'participant_id' => participant.id,
            'organization_id' => organization.id
          }
        }
      end

      return { error: 'Lift action must be renew, checkin, forfeit, or checkout.' } unless flow['lift_action'] == 'forfeit'

      { pending: { 'action' => 'forfeit_scissor_lift', 'scissor_lift_id' => flow['scissor_lift_id'] } }
    end

    def build_queue(flow)
      return { error: 'Select queue type.' } if flow['queue_type'].blank?
      return { error: 'Select queue action.' } if flow['queue_action'].blank?
      return { error: 'Select an organization.' } if flow['organization_id'].blank?
      return { error: 'Queue action must be add or remove.' } unless %w[add remove].include?(flow['queue_action'])

      if flow['queue_action'] == 'add'
        return { error: 'Select queue source.' } if flow['queue_source'].blank?
        if flow['queue_source'] == 'by_user'
          return { error: 'Select a borrower.' } if flow['participant_id'].blank?
          participant = Participant.find_by(id: flow['participant_id'])
          return { error: 'Borrower is invalid.' } if participant.blank?
          unless participant.organizations.exists?(flow['organization_id'])
            return { error: 'Organization is not valid for this borrower.' }
          end
        end
        return { error: 'Enter a queue message.' } if flow['queue_message'].blank?
      end

      action_name = flow['queue_action'] == 'add' ? 'add_queue' : 'remove_queue'
      pending = {
        'action' => action_name,
        'queue_type' => flow['queue_type'],
        'organization_id' => flow['organization_id']
      }
      pending['queue_message'] = flow['queue_message'] if flow['queue_action'] == 'add'
      { pending: pending }
    end
  end
end
