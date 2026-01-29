# frozen_string_literal: true
module CheckoutsHelper
  def checkout_organization_select_options(participant)
    orgs = participant.organizations.to_a
    selected =
      if orgs.size == 1
        orgs.first&.id
      else
        participant.primary_organization_id
      end

    {
      prompt: orgs.size == 1 ? nil : 'Select organization',
      selected: selected
    }
  end
end
