# frozen_string_literal: true

namespace :carnival do
  desc "Import a Carnival's reference data from lib/seeds/<folder>/ " \
       '(folder= defaults to "2025 seeds"; models= limits it, e.g., models=organization,tool)'
  task import: :environment do
    Carnival::Import.new(
      folder: ENV.fetch('folder', Carnival::Import::DEFAULT_FOLDER),
      models: ENV.fetch('models', '').split(',')
    ).run
  end
end
