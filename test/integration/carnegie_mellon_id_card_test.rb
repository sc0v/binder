require 'test_helper'

class CarnegieMellonIDCardTest < ActiveSupport::TestCase
  # Relationships
  
  # Validations

  # Scopes

  # Methods

  # why did I put these here? Are these necessary? I don't think so,
  # given the assertions below are self-contained
  setup do
    create_context
  end

  teardown do
    #remove_context
  end

  should "identify student based on card id" do
  	assert_equal "juc", CarnegieMellonIDCard.search(811825505)
  	assert_equal "juc", CarnegieMellonIDCard.search('%811825505')
  end

end