module ShiftsHelper

  def current? shift
    shift.starts_at <= Time.now and shift.ends_at > Time.now
  end

end
