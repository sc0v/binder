class ScissorLiftsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @scissor_lifts = ScissorLift.all.ordered_by_name

    respond_to do |format|
      format.html
      format.json do
        data = 
          @scissor_lifts.as_json(
            methods: %i[name link is_checked_out? current_organization checked_out_at due_at]
          )
        render json: {data: }
      end
    end
  end

  def show
    @scissor_lift = ScissorLift.find(params[:id])
  end
end
