# frozen_string_literal: true

# Outside production (development, test and staging), every page wears the
# Web Kilt's caution tape. In development and test, Sign In goes to the
# developer sign-in page, so whoever is signed in is a test account.
module TestAccountsHelper
  # The caution tape: anywhere but production
  def caution_tape?
    !Rails.env.production?
  end

  # The gold site bar naming the test account: signed in through the
  # developer sign-in page (development and test only), and not while acting
  # as someone else (that has its own bar)
  def test_account_bar?
    Rails.env.local? && Current.user.present? && !Current.imposter
  end

  # A test account's role, as the developer sign-in page names it
  def test_account_role(person)
    return 'Admin' if person.admin?
    return 'SCC Member' if person.scc?
    return 'Booth Chair' if person.booth_chair?

    Membership.exists?(participant: person) ? 'Participant' : 'Non-Participant'
  end
end
