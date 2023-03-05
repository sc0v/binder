require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_one(:participant)

  # Validating email...
  should allow_value("fred@andrew.cmu.edu").for(:email)
  should allow_value("fred@cmu.edu").for(:email)

end
