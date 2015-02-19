# ## Schema Information
#
# Table name: `judgements`
#
# ### Columns
#
# Name                         | Type               | Attributes
# ---------------------------- | ------------------ | ---------------------------
# **`created_at`**             | `datetime`         | `not null`
# **`id`**                     | `integer`          | `not null, primary key`
# **`judge_id`**               | `integer`          |
# **`judgement_category_id`**  | `integer`          |
# **`organization_id`**        | `integer`          |
# **`updated_at`**             | `datetime`         | `not null`
# **`value`**                  | `integer`          |
#
# ### Indexes
#
# * `index_judgements_on_judge_id`:
#     * **`judge_id`**
# * `index_judgements_on_judgement_category_id`:
#     * **`judgement_category_id`**
# * `index_judgements_on_organization_id`:
#     * **`organization_id`**
#

require 'test_helper'

class JudgementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
