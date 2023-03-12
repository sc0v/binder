# frozen_string_literal: true

namespace :lint do
  desc 'Check for security vulnerabilities'
  task brakeman: :environment do
    system('brakeman -q --no-summary') or
      raise(StandardError.new, 'brakeman linting failed.')
  end

  desc 'Lint embedded ruby files'
  task erblint: :environment do
    Dir.glob('**/*.erb').each do |f|
      system("erblint -a #{f}") or
        raise(StandardError.new, 'erblint linting failed.')
    end
  end

  desc 'Prettify html'
  task htmlbeautifier: :environment do
    Dir.glob('**/*.{html.erb,html}').each do |f|
      system("htmlbeautifier #{f}") or
        raise(StandardError.new, 'htmlbeautifier linting failed.')
    end
  end

  desc 'Lint ruby files'
  task rubocop: :environment do
    system('rubocop -A') or
      raise(StandardError.new, 'rubocop linting failed.')
  end
end

desc 'Lint everything'
task lint: :environment do
  errors = []

  %i[htmlbeautifier rubocop erblint brakeman].each do |l|
    Rake::Task["lint:#{l}"].invoke
  rescue StandardError => e
    errors << e
  end

  if errors.present?
    puts 'Linting errors:'
    errors.each { |e| puts " * #{e}" }
    exit(1)
  else
    puts 'No linting errors.'
  end
end
