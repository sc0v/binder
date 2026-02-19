# frozen_string_literal: true

module PowerDashboard
  module Actions
    class Base
      def name
        raise NotImplementedError, "#{self.class} must define #name"
      end

      def command_words
        []
      end

      def suggestions
        []
      end

      def priority
        100
      end

      def match?(_rest, session_state:)
        true
      end

      def confirmation_required?
        false
      end

      def required_resources(_pending)
        []
      end

      def parse(_rest, session_state:, command:)
        nil
      end

      def execute(_pending, resources:, session_state:, ability:)
        raise NotImplementedError, "#{self.class} must define #execute"
      end

      def receipt(_pending, resources:, session:)
        if confirmation_required?
          raise NotImplementedError, "#{self.class} must implement #receipt"
        end

        raise NotImplementedError, "#{self.class} does not require confirmation, so it should not build a receipt"
      end

      protected

      def pending(payload = {})
        { pending: payload.merge(action: name, requires_confirmation: confirmation_required?) }
      end

      def error(message)
        { error: message }
      end

      def message(message)
        { message: message }
      end

      def receipt_line(label, value)
        { label: label, value: value.presence || '—' }
      end

      def receipt_list(label, items)
        { label: label, list: items.presence || ['—'] }
      end

      def receipt_payload(title, lines)
        { title: title, lines: lines }
      end

      def t(key, **options)
        I18n.t(key, **options)
      end

      def cart_tool_names(session)
        tool_ids = Array(session[:tools]).map(&:to_i)
        tools_by_id = Tool.where(id: tool_ids).index_by(&:id)
        tool_ids.filter_map do |tool_id|
          tool = tools_by_id[tool_id]
          next if tool.blank?

          status_class = tool.is_checked_out? ? 'power-item-unavailable' : 'power-item-available'
          { label: tool.formatted_name, status_class: status_class }
        end
      end

      def checked_out_to_label(checkout)
        return '—' if checkout.blank?

        borrower = checkout.participant&.formatted_name || checkout.participant&.name
        organization = checkout.organization&.name
        return borrower if organization.blank?

        "#{borrower} (#{organization})"
      end

      def targets_tools_cart?(rest)
        rest.to_s.strip.match?(/\A(tools?|cart|c)\b/i)
      end

      def lift_match?(rest)
        rest.to_s.strip.match?(/\A(lift|scissor|l)\b/i)
      end
    end
  end
end
