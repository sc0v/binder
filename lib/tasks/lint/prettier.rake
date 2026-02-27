# frozen_string_literal: true

PRETTIER_BIN = 'npm exec prettier --'
PRETTIER_OPT_CHECK = '--check'
PRETTIER_OPT_AUTOCORRECT = '--write'

namespace :lint do
  desc 'Prettify project files, prettify specific files'
  task :prettier, [:files] => :environment do |t, args|
    include LintHelper
    log(t.name)
    bin = [PRETTIER_BIN]
    bin << (dryrun?(t.name) ? PRETTIER_OPT_CHECK : PRETTIER_OPT_AUTOCORRECT)

    # Pass explicit file if given; otherwise use '.' so prettier discovers files
    # itself and respects .prettierignore
    bin << (args.files.presence || '.')
    bin = bin.join(' ')

    log(t.name, " * executing: #{bin}")
    system(bin) or abort_with_log(t.name)
  end
end
