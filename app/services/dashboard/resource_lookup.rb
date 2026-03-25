# frozen_string_literal: true

module Dashboard
  class ResourceLookup
    def lookup_resource(input)
      find_resource(:organization, Organization.lookup(input, exact: true)) ||
        find_resource(:scissor_lift, ScissorLift.lookup(input)) ||
        find_resource(:tool, Tool.lookup(input)) ||
        find_resource(:participant, Participant.lookup(input)) ||
        find_resource(:organization, Organization.lookup(input))
    end

    private

    def find_resource(type, record)
      { type:, record: } if record.present?
    end
  end
end
