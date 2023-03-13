# frozen_string_literal: true

HTMLBEAUTIFIER_BIN = 'htmlbeautifier'
HTMLBEAUTIFIER_OPT_NOAUTOCORRECT = '-l'

namespace :lint do
  desc 'Lint project html files, lint specific html files'
  task :htmlbeautifier, [:files] => :environment do |t, args|
    include LintHelper
    log(t.name)
    args.with_defaults(files: Rake::FileList['**/*.html', '**/*.html.*'])

    bin = [HTMLBEAUTIFIER_BIN]
    bin << HTMLBEAUTIFIER_OPT_NOAUTOCORRECT if dryrun?(t.name)
    bin << args.files if args.files.present?
    bin = bin.join(' ')

    log(t.name, " * executing: #{bin}")
    system(bin) or
      abort_with_log(t.name)
  end
end
