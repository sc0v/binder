# frozen_string_literal: true

# Staging runs as production does, with its own database (config/database.yml)
# and the live directory (CarnegieMellonPerson.live?). Pages still wear the
# caution tape (TestAccountsHelper), but Sign In is single sign-on: the
# developer sign-in page exists only in development and test.
require_relative 'production'
