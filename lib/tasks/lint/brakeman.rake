# frozen_string_literal: true

BRAKEMAN_BIN = 'brakeman -q --no-summary'

namespace :lint do
  desc 'Check for security vulnerabilities'
  task brakeman: :environment do |t|
    include LintHelper
    log(t.name)
    log(t.name, ' * warning: superfluous dryrun rule') if dryrun?(t.name)

    bin = BRAKEMAN_BIN

    log(t.name, " * executing: #{bin}")
    system(bin) or
      abort_with_log(t.name)
  end
end
