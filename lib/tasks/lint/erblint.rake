# frozen_string_literal: true

ERBLINT_BIN = 'erblint'
ERBLINT_OPT_ALL = '--lint-all'
ERBLINT_OPT_AUTOCORRECT = '-a'

namespace :lint do
  desc 'Lint project embedded ruby files, lint specific erb files'
  task :erblint, [:files] => %i[environment lint:htmlbeautifier] do |t, args|
    include LintHelper
    log(t.name)

    bin = [ERBLINT_BIN]
    bin << ERBLINT_OPT_AUTOCORRECT unless dryrun?(t.name)
    bin << (args.files.presence || ERBLINT_OPT_ALL)
    bin = bin.join(' ')

    log(t.name, " * executing: #{bin}")
    system(bin) or
      abort_with_log(t.name)
  end
end
