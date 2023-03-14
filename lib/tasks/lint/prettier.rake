# frozen_string_literal: true

PRETTIER_BIN = 'prettier --check'
PRETTIER_OPT_AUTOCORRECT = '-w'

namespace :lint do
  desc 'Prettify project html files, prettify specific html files'
  task :prettier, [:files] => :environment do |t, args|
    include LintHelper
    log(t.name)
    args.with_defaults(files: Rake::FileList['**/*.html', '**/*.html.*'])

    bin = [PRETTIER_BIN]
    bin << PRETTIER_OPT_AUTOCORRECT unless dryrun?(t.name)
    bin << args.files if args.files.present?
    bin = bin.join(' ')

    log(t.name, " * executing: #{bin}")
    system(bin) or
      abort_with_log(t.name)
  end
end
