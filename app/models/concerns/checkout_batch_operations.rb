# frozen_string_literal: true

module CheckoutBatchOperations
  extend ActiveSupport::Concern

  module ClassMethods
    def checkout_batch(organization:, participant:, tool_ids:)
      if tool_ids.blank?
        failed = [missing_tools_checkout(organization:, participant:)]
        return { checked_out: [], failed:, remaining_ids: [] }
      end

      checked_out, failed = checkout_tools(tool_ids, organization, participant)
      { checked_out:, failed:, remaining_ids: tool_ids - checked_out.map(&:tool_id) }
    end

    def checkin_batch(tool_ids:)
      errors, remaining_ids = checkin_tools(tool_ids.map(&:to_i))
      { checked_in: tool_ids.size - remaining_ids.size, errors:, remaining_ids: }
    end

    private

    def checkout_tools(tool_ids, organization, participant)
      tool_ids.each_with_object([[], []]) do |tool_id, (successes, failures)|
        checkout_one(tool_id, organization, participant, successes, failures)
      end
    end

    def checkout_one(tool_id, organization, participant, successes, failures)
      tool = Tool.find_by(id: tool_id)
      unless tool
        failures << missing_tool_checkout(organization:, participant:, tool_id:)
        return
      end
      checkout = build_checkout(organization:, participant:, tool:)
      return successes << checkout if checkout.save

      apply_checkout_error(checkout, tool)
      failures << checkout
    end

    def checkin_tools(tool_ids)
      tool_ids.each_with_object([[], []]) do |tool_id, (errs, remaining)|
        checkin_one(tool_id, errs, remaining)
      end
    end

    def checkin_one(tool_id, errs, remaining)
      tool = Tool.find_by(id: tool_id)
      return add_missing_tool(tool_id, errs, remaining) unless tool

      checkout = tool.checkouts.current.first
      return unless checkout

      checkout.checkin
      add_checkin_error(tool_id, checkout, errs, remaining) if checkout.errors.any?
    end

    def add_missing_tool(tool_id, errs, remaining)
      errs << { type: :missing_tool, id: tool_id }
      remaining << tool_id
    end

    def add_checkin_error(tool_id, checkout, errs, remaining)
      errs << { type: :checkin_error, message: checkout.errors.full_messages.join(', ') }
      remaining << tool_id
    end

    def build_checkout(organization:, participant:, tool: nil)
      new(organization:, participant:, tool:, checked_out_at: Time.zone.now)
    end

    def missing_tools_checkout(organization:, participant:)
      checkout = build_checkout(organization:, participant:)
      checkout.errors.add(:base, 'Add at least one tool to checkout.')
      checkout
    end

    def missing_tool_checkout(organization:, participant:, tool_id:)
      checkout = build_checkout(organization:, participant:)
      checkout.errors.add(:base, "Tool #{tool_id} not found.")
      checkout
    end

    def apply_checkout_error(checkout, tool)
      message = format_checkout_error(tool_name: tool.name, errors: checkout.errors)
      checkout.errors.clear
      checkout.errors.add(:base, message)
    end

    def format_checkout_error(tool_name:, errors:)
      if errors[:tool_id].include?('already has an active checkout') && errors.attribute_names == [:tool_id]
        return "#{tool_name} already checked out."
      end

      "Could not check out '#{tool_name}': #{errors.full_messages.join(', ')}"
    end
  end
end
