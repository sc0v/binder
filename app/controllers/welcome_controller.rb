# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @notes = Note.accessible_by(Current.ability).unhidden
    @note = Note.new
    load_scc_dashboard if Current.user&.scc?
  end

  private

  def load_scc_dashboard
    @urgents = Urgent.active.unhidden.ordered_by_created_at
    @electrical_queue =
      OrganizationTimelineEntry.electrical.current.includes(:organization)
    @structural_queue =
      OrganizationTimelineEntry.structural.current.includes(:organization)
    @scissor_lift_queue =
      OrganizationTimelineEntry.scissor_lift.current.includes(:organization)
    @available_scissor_lifts = ScissorLift.ordered_by_name.reject(&:checked_out?)
  end
end
