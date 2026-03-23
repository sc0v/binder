class VisitorCountsController < ApplicationController
  def index
    @visitor_counts = VisitorCount.all
  end

  def show
    @visitor_count = VisitorCount.find(params[:id])
    @count = @visitor_count.count
    @organization_name = @visitor_count.organization.name
  end

  def update
    @visitor_count = VisitorCount.find(params[:id])
    @visitor_count.increment!(:count)
    
    redirect_to visitor_count_path(@visitor_count)

  end

  def search
  end
end
