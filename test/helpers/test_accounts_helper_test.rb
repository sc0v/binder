# frozen_string_literal: true

require 'test_helper'

# A plain object wearing the helper, since the helper's own method names
# start with test_, which Minitest would run as tests
class TestAccountsHelperTest < ActiveSupport::TestCase
  setup do
    @helper = Object.new.extend(TestAccountsHelper)
    Current.user = FactoryBot.create(:participant, eppn: 'cc00@andrew.cmu.edu')
  end

  teardown { Current.reset }

  test 'caution tape everywhere but production' do
    %w[development test staging].each do |env|
      with_rails_env(env) { assert_predicate @helper, :caution_tape? }
    end

    with_rails_env('production') { assert_not @helper.caution_tape? }
  end

  test 'test-account bar for a signed-in test account in development and test' do
    %w[development test].each do |env|
      with_rails_env(env) { assert_predicate @helper, :test_account_bar? }
    end
  end

  test 'no test-account bar on staging or in production' do
    %w[staging production].each do |env|
      with_rails_env(env) { assert_not @helper.test_account_bar? }
    end
  end

  test 'no test-account bar signed out' do
    Current.user = nil

    assert_not @helper.test_account_bar?
  end

  test 'no test-account bar while acting as someone else' do
    Current.imposter = FactoryBot.create(:participant, admin: true)

    assert_not @helper.test_account_bar?
  end

  test 'names each role as the developer sign-in page does' do
    organization =
      FactoryBot.create(:organization, name: 'Spring Carnival Committee')
    booth = FactoryBot.create(:organization)
    admin = FactoryBot.create(:participant, admin: true)
    scc = FactoryBot.create(:participant)
    FactoryBot.create(:membership, participant: scc, organization:)
    chair = FactoryBot.create(:participant)
    FactoryBot.create(
      :membership,
      participant: chair,
      organization: booth,
      is_booth_chair: true
    )
    member = FactoryBot.create(:participant)
    FactoryBot.create(:membership, participant: member, organization: booth)

    people = [admin, scc, chair, member, Current.user]

    assert_equal(
      ['Admin', 'SCC Member', 'Booth Chair', 'Participant', 'Non-Participant'],
      people.map { |person| @helper.test_account_role(person) }
    )
  end
end
