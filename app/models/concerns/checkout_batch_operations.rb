# frozen_string_literal: true

module CheckoutBatchOperations
  extend ActiveSupport::Concern

  module ClassMethods
    def checkout_batch(organization:, participant:, tool_ids:)
      if tool_ids.blank?
        failed = [missing_tools_checkout(organization: organization, participant: participant)]
        return { checked_out: [], failed: failed, remaining_ids: [] }
      end

      results = { checked_out: [], failed: [], remaining_ids: tool_ids.dup }
      accumulate_checkouts(tool_ids, organization, participant, results)
      results
    end

    def checkin_batch(tool_ids:)
      results = { checked_in: 0, errors: [], remaining_ids: [] }
      tool_ids.map(&:to_i).each { |id| accumulate_checkin(id, results) }
      results
    end

    private

    def empty_checkout_result(organization, participant)
      failed = [missing_tools_checkout(organization: organization, participant: participant)]
      { checked_out: [], failed: failed, remaining_ids: [] }
    end

    def accumulate_checkouts(tool_ids, organization, participant, results)
      tool_ids.each do |tool_id|
        result = checkout_tool(tool_id, organization, participant)
        next results[:failed] << result[:checkout] unless result[:success]

        results[:checked_out] << result[:checkout]
        results[:remaining_ids].delete(tool_id)
      end
    end

    def checkout_tool(tool_id, organization, participant)
      tool = Tool.find_by(id: tool_id)
      if tool.blank?
        checkout = missing_tool_checkout(organization: organization, participant: participant, tool_id: tool_id)
        return { success: false, checkout: checkout }
      end

      checkout = build_checkout(organization: organization, participant: participant, tool: tool)
      return { success: true, checkout: checkout } if checkout.save

      { success: false, checkout: apply_checkout_error(checkout, tool) }
    rescue StandardError => e
      { success: false, checkout: apply_checkout_error(checkout, tool, exception: e) }
    end

    def accumulate_checkin(tool_id, results)
      tool = Tool.find_by(id: tool_id)
      return add_missing_tool_error(tool_id, results) unless tool

      checkout = tool.checkouts.current.first
      return results[:checked_in] += 1 unless checkout

      process_checkin(tool_id, checkout, results)
    end

    def add_missing_tool_error(tool_id, results)
      results[:errors] << { type: :missing_tool, id: tool_id }
      results[:remaining_ids] << tool_id
    end

    def process_checkin(tool_id, checkout, results)
      checkout.checkin
      if checkout.errors.blank?
        results[:checked_in] += 1
      else
        results[:errors] << { type: :checkin_error, message: checkout.errors.full_messages.join(', ') }
        results[:remaining_ids] << tool_id
      end
    end

    def build_checkout(organization:, participant:, tool: nil)
      new(organization: organization, participant: participant, tool: tool, checked_out_at: Time.zone.now)
    end

    def missing_tools_checkout(organization:, participant:)
      checkout = build_checkout(organization: organization, participant: participant)
      checkout.errors.add(:base, 'Add at least one tool to checkout.')
      checkout
    end

    def missing_tool_checkout(organization:, participant:, tool_id:)
      checkout = build_checkout(organization: organization, participant: participant)
      checkout.errors.add(:base, "Tool #{tool_id} not found.")
      checkout
    end

    def apply_checkout_error(checkout, tool, exception: nil)
      message = format_checkout_error(tool_name: tool&.name, errors: checkout.errors, exception: exception)
      checkout.errors.clear
      checkout.errors.add(:base, message)
      checkout
    end

    def format_checkout_error(tool_name:, errors:, exception: nil)
      if errors[:tool_id].include?('already has an active checkout') && errors.attribute_names == [:tool_id]
        return "#{tool_name} already checked out."
      end

      details = exception ? exception.message : errors.full_messages.join(', ')
      "Could not check out '#{tool_name}': #{details}"
    end
  end
end
