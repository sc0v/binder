# frozen_string_literal: true

require Rails.root.join('lib/tasks/lint/lint_helper')

ALL_LINT_TASKS = %i[lint:rubocop lint:erblint lint:brakeman].freeze

# TODO: Add CSS linter
desc 'Lint project (run w/ lint:dryrun to disable autocorrection), lint specific files'
task :lint, [:file] => :environment do |t, args|
  include LintHelper

  if args.file.present?
    # TODO: Add dryrun mode for single files
    abort_with_log(t.name, 'No dryrun option for file.') if dryrun?(t.name)
    Rake::Task["lint:file:#{args.file}"].invoke
  else
    errors = []

    tasks = ALL_LINT_TASKS
    tasks.map! { |task| "#{task}:dryrun" } if dryrun?(t.name)
    tasks.each do |task|
      Rake::Task[task].invoke
    rescue SystemExit => e
      errors << e.message
    end

    if errors.present?
      log(t.name, 'Errors from invoked tasks:')
      errors.each { |e| log t.name, " * #{e}" }
      abort_with_log(t.name)
    end
  end
end

# Each lint task can be initiated with a dryrun rule
# e.g. rails lint:rubocop:dryrun
namespace :lint do |namespace|
  rule ':dryrun', [:files] do |t, args|
    include LintHelper
    task = t.name.delete_suffix(':dryrun') # determine task name
    dryrun(task) # flag env as dryrun for task

    # Change all lint-namespace prerequisites of the task to be dryruns, too
    prereqs = Rake::Task[task].prerequisites
    prefix = "^#{namespace.scope.path}" # i.e. ^lint
    prereqs.map! { |x| x.match?(prefix) ? "#{x}:dryrun" : x }
    Rake::Task[task].prerequisites.replace(prereqs)

    # Invoke the task after dryrun configured
    Rake::Task[task].invoke(args.files)
  end
end

# Determine proper linter for single files
namespace :lint do
  namespace :file do |namespace|
    rule '.html' do |t, _args|
      file = t.name.delete_prefix("#{namespace.scope.path}:")
      Rake::Task['lint:prettier'].invoke(file)
    end

    rule '.html.erb' do |t, _args|
      file = t.name.delete_prefix("#{namespace.scope.path}:")
      Rake::Task['lint:prettier'].invoke(file)
      Rake::Task['lint:erblint'].invoke(file)
    end

    rule '.rake' do |t, _args|
      file = t.name.delete_prefix("#{namespace.scope.path}:")
      Rake::Task['lint:rubocop'].invoke(file)
    end

    rule '.rb' do |t, _args|
      file = t.name.delete_prefix("#{namespace.scope.path}:")
      Rake::Task['lint:rubocop'].invoke(file)
    end
  end
end
