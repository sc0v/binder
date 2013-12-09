require 'test_helper'

class CarnegieMellonIDCardTest < ActiveSupport::TestCase
  # Relationships
  
  # Validations

  # Scopes

  # Methods

  # why did I put these here? Are these necessary? I don't think so,
  # given the assertions below are self-contained
  setup do
    # Webmock
    stub_request(:any, /.*merichar-dev\.eberly\.cmu\.edu.*/).to_return(:body => '{ "andrewid": "juc", "expiration": "2013-11-29T00:00:00+00:00" }', :status => 200, :headers => { 'Content-Length' => 17 })
  end

  teardown do
  end

  should "identify student based on card id" do
  	assert_equal "juc", CarnegieMellonIDCard.search(811825505)
  	assert_equal "juc", CarnegieMellonIDCard.search('%811825505')
  end
end

