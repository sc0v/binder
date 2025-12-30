# frozen_string_literal: true

module PowerDashboard
  module Actions
    class LiftOverviewSelect < Base
      def name
        'select_scissor_lifts_overview'
      end

      def command_words
        %w[lifts]
      end

      def suggestions
        [{ label: 'lifts', value: 'lifts', type: 'action' }]
      end

      def parse(_rest, session_state:, command:)
        pending
      end

      def execute(_pending, resources:, session_state:, ability:)
        return error(t('resources.scissor_lift.overview_not_authorized')) unless ability.call(:read, ScissorLift)
        session_state.set_scissor_lift_overview
        message(t('resources.scissor_lift.overview_selected'))
      end
    end
  end
end
