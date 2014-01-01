# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
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
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_save :email_downcase
  
  # Setup accessible (or protected) attributes for your model
  # attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :id, :participant
  # attr_accessible :role_ids, :as => :admin
  

  has_one :participant, dependent: :destroy
  
  # Validations
  # -----------------------------
  # make sure required fields are present
  validates_presence_of :name, :email  
  validates_uniqueness_of :email, :allow_blank => true
  validates_format_of :email, :with => /\A[\w]([^@\s,;]+)@andrew\.cmu\.edu\Z/i, :message => "is not a valid andrew email", :allow_blank => true
  validates_presence_of :password, :on => :create 
  validates_presence_of :password_confirmation, :on => :create 
  validates_confirmation_of :password, :message => "does not match"
  validates_length_of :password, :minimum => 4, :message => "must be at least 4 characters long", :allow_blank => true
  
  scope :search, lambda { |term| where('lower(name) LIKE lower(?) OR lower(email) LIKE lower(?)', "#{term}%", "#{term}%") }

  def email_downcase
    self.email = self.email.downcase
  end

end
