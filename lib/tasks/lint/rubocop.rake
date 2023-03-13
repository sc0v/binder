# frozen_string_literal: true

RUBOCOP_BIN = 'rubocop'
RUBOCOP_OPT_AUTOCORRECT = '-A'

namespace 'lint' do
  desc 'Lint project ruby files, lint specific ruby files'
  task :rubocop, [:files] => :environment do |t, args|
    include LintHelper
    log(t.name)

    bin = [RUBOCOP_BIN]
    bin << RUBOCOP_OPT_AUTOCORRECT unless dryrun?(t.name)
    bin << args.files if args.files.present?
    bin = bin.join(' ')

    log(t.name, " * executing: #{bin}")
    system(bin) or
      abort_with_log(t.name)
  end
end
