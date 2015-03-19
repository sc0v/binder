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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_one(:participant)

  # Validating email...
  should allow_value("fred@andrew.cmu.edu").for(:email)
  should allow_value("fred@cmu.edu").for(:email)

end
