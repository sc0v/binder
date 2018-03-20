# ## Schema Information
#
# Table name: `organization_lists`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`andrew_id`**        | `string`           |
# **`created_at`**       | `datetime`         | `not null`
# **`id`**               | `integer`          | `not null, primary key`
# **`organization_id`**  | `integer`          |
# **`updated_at`**       | `datetime`         | `not null`
#

class OrganizationList < ActiveRecord::Base
require 'csv'
belongs_to :organization

def user_orgs(and_id)
	OrganizationList.where(andrew_id: and_id).to_a 
end

def self.import (org, file)
	CSV.foreach(file.path, headers: true) do |row|
		OrganizationList.create!(organization_id: org, andrew_id: row)
	end
end
end
