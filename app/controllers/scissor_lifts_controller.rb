# frozen_string_literal: true

class ScissorLiftsController < ApplicationController
  load_and_authorize_resource

  def index
    @scissor_lifts = ScissorLift.all.ordered_by_name
    @queue = OrganizationTimelineEntry.scissor_lift.current

    respond_to do |format|
      format.html
      format.json { render json: scissor_lifts_json }
    end
  end

  def show
    @scissor_lift = ScissorLift.find(params[:id])
  end

  private

  def scissor_lifts_json
    data =
      @scissor_lifts.as_json(
        methods: %i[
          name
          link
          checked_out?
          current_organization
          checked_out_at
          due_at
        ]
      )
    { data: }
  end
end
