# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`active`**                  | `boolean`          | `default(TRUE)`
# **`created_at`**              | `datetime`         |
# **`current_sign_in_at`**      | `datetime`         |
# **`current_sign_in_ip`**      | `string(255)`      |
# **`email`**                   | `string(255)`      | `default(""), not null`
# **`encrypted_password`**      | `string(255)`      | `default(""), not null`
# **`id`**                      | `integer`          | `not null, primary key`
# **`last_sign_in_at`**         | `datetime`         |
# **`last_sign_in_ip`**         | `string(255)`      |
# **`name`**                    | `string(255)`      |
# **`remember_created_at`**     | `datetime`         |
# **`reset_password_sent_at`**  | `datetime`         |
# **`reset_password_token`**    | `string(255)`      |
# **`sign_in_count`**           | `integer`          | `default(0), not null`
# **`updated_at`**              | `datetime`         |
#
# ### Indexes
#
# * `index_users_on_email` (_unique_):
#     * **`email`**
# * `index_users_on_reset_password_token` (_unique_):
#     * **`reset_password_token`**
#

class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :registerable, :omniauthable, :omniauth_providers => [:shibboleth]

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :id, :participant
  # attr_accessible :role_ids, :as => :admin


  has_one :participant

  scope :search, lambda { |term| where('lower(name) LIKE lower(?) OR lower(email) LIKE lower(?)', "#{term}%", "#{term}%") }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  def self.find_for_shibboleth_oauth(request, _signed_in_resource=nil)
    user = User.where(:email => request.env["eppn"]).first
    if (user.blank?)
      user = User.create(email: request.env["eppn"], name: request.env["displayName"])
    end
    user.participant ||= Participant.where(:andrewid => user.email[/[^\@]*/]).first
    user.participant ||= Participant.create(andrewid: user.email[/[^\@]*/])

    return user
  end

end
