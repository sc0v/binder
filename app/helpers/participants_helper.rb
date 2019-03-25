# ## Schema Information
#
# Table name: `participants`
#
# ### Columns
#
# Name                             | Type               | Attributes
# -------------------------------- | ------------------ | ---------------------------
# **`active`**                     | `boolean`          | `default(TRUE)`
# **`andrewid`**                   | `string(255)`      |
# **`cache_updated`**              | `datetime`         |
# **`cached_department`**          | `string(255)`      |
# **`cached_email`**               | `string(255)`      |
# **`cached_name`**                | `string(255)`      |
# **`cached_student_class`**       | `string(255)`      |
# **`cached_surname`**             | `string(255)`      |
# **`created_at`**                 | `datetime`         |
# **`has_signed_hardhat_waiver`**  | `boolean`          |
# **`has_signed_waiver`**          | `boolean`          |
# **`id`**                         | `integer`          | `not null, primary key`
# **`phone_number`**               | `string(255)`      |
# **`updated_at`**                 | `datetime`         |
# **`user_id`**                    | `integer`          |
# **`waiver_start`**               | `datetime`         |
#

module ParticipantsHelper
end
