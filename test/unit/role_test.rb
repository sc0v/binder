require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  # Relationships

  should have_and_belong_to_many(:users)

  # Validations

  # Scopes

  # Methods

end
