# frozen_string_literal: true

# Developer sign-in: in development and test, Sign In comes here instead of
# single sign-on. Pick a test account, one per role, and go back to the page
# you were on. The routes are drawn only there, and this refuses everywhere
# else too, staging included.
class DevSessionsController < ApplicationController
  include TestAccountsHelper

  skip_before_action :verify_authenticity_token, only: :new
  before_action { head :not_found unless Rails.env.local? }
  helper_method :initials
  layout 'dev_sign_in'

  ROLES = {
    'Admin' => 'Everything, including settings and acting as someone else.',
    'SCC Member' => 'Spring Carnival Committee work across every organization.',
    'Booth Chair' => "Their organization's members, tools and build progress.",
    'Participant' => 'Their own organization, mostly to look at.',
    'Non-Participant' => 'Signed in, with no organization yet.'
  }.freeze

  def new
    @return_to = safe_return_to(params[:return_to].presence || request.referer)
    @people = people_by_role
  end

  def create
    cookies.encrypted[:user_id] = Participant.find(params[:participant_id]).id
    redirect_to safe_return_to(params[:return_to]) || root_path
  end

  # Signed Out: see the app as a visitor
  def destroy
    cookies.encrypted[:user_id] = nil
    redirect_to safe_return_to(params[:return_to]) || root_path
  end

  private

  # The first person (by name) in each role
  def people_by_role
    found = {}
    Participant.ordered_by_name.find_each do |p|
      found[test_account_role(p)] ||= p
      break if found.size == ROLES.size
    end
    ROLES.keys.filter_map do |role|
      [role, found[role], ROLES[role]] if found[role]
    end
  end

  # A card's initials: first and last name's first letters
  def initials(person)
    words = person.name.to_s.split
    [words.first, words.last].compact.uniq.pluck(0).join.upcase
  end

  # A path on this site only, and never this page again
  def safe_return_to(value)
    uri = URI.parse(value.to_s)
    return if uri.host.present? && uri.host != request.host

    path = uri.path.to_s
    return unless local_path?(path)

    uri.query ? "#{path}?#{uri.query}" : path
  rescue URI::InvalidURIError
    nil
  end

  def local_path?(path)
    path.start_with?('/') &&
      !path.start_with?('//', '/login', '/logout', '/auth/')
  end
end
