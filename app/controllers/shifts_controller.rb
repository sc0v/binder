class ShiftsController < ApplicationController

  def index
    @upcoming_shifts = Shift.upcoming
    @current_shifts = Shift.current
  end

end
