# frozen_string_literal: true

module ShiftsHelper
  def current?(shift)
    shift.starts_at <= Time.zone.now and shift.ends_at > Time.zone.now
  end
end
