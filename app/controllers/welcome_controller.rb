# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @notes = Note.accessible_by(Current.ability).unhidden
    @note = Note.new
    return unless Current.user&.scc?

    @tasks_due = tasks_due
    shifts = Shift.accessible_by(Current.ability).includes(:shift_type, :organization, :participants)
    @shifts_now = shifts.current
    @shifts_next = shifts.future.limit(6)
  end

  private

  # The committee's home page is its operations hub: incomplete tasks due in
  # the next four hours, overdue ones included
  def tasks_due
    Task.accessible_by(Current.ability).is_incomplete.upcoming.limit(8)
  end
end
