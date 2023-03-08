# frozen_string_literal: true

class EventTypeTest < ActiveSupport::TestCase
  # Relationships
  should have_many(:events)
end
