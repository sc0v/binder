# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # devise :registerable, :omniauthable, omniauth_providers: [:shibboleth]

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :id, :participant
  # attr_accessible :role_ids, :as => :admin

  has_one :participant

  scope :search, lambda { |term|
                   where('lower(name) LIKE lower(?) OR lower(email) LIKE lower(?)', "#{term}%", "#{term}%")
                 }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  def self.find_for_shibboleth_oauth(request, _signed_in_resource = nil)
    user = User.where(email: request.env['eppn']).first
    user = User.create(email: request.env['eppn'], name: request.env['displayName']) if user.blank?
    user.participant ||= Participant.where(eppn: user.email[/[^@]*/]).first
    user.participant ||= Participant.create(eppn: user.email[/[^@]*/])

    user
  end
end
