# frozen_string_literal: true

# Maps file extensions to the lint tasks that should run on them.
FILE_LINT_TASKS = {
  '.css' => %w[lint:prettier],
  '.html' => %w[lint:prettier],
  '.html.erb' => %w[lint:prettier lint:erblint],
  '.js' => %w[lint:prettier],
  '.rake' => %w[lint:prettier lint:rubocop],
  '.rb' => %w[lint:prettier lint:rubocop],
  '.yml' => %w[lint:prettier]
}.freeze

# Determine proper linter for single files
namespace :lint do
  namespace :file do |namespace|
    FILE_LINT_TASKS.each do |ext, tasks|
      rule ext do |t, _args|
        file = t.name.delete_prefix("#{namespace.scope.path}:")
        tasks.each { |task| Rake::Task[task].invoke(file) }
      end
    end
  end
end
