# frozen_string_literal: true

module LintHelper
  def log(task_name, message = 'Task starting...')
    puts "#{task_name}: #{message}" # rubocop:disable Rails/Output
  end

  def abort_with_log(task_name, message = 'Task failed.')
    abort "#{task_name}: #{message}"
  end

  def dryrun(task_name)
    ENV["TASK_#{task_name.upcase.gsub(':', '_')}_DRYRUN"] = 'TRUE'
  end

  def dryrun?(task_name)
    ENV["TASK_#{task_name.upcase.gsub(':', '_')}_DRYRUN"] == 'TRUE'
  end
end
