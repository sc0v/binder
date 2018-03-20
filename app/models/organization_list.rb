# ## Schema Information
#
# Table name: `organization_lists`
#
# ### Columns
#
# Name               	 | Type             | Attributes
# ------------------ 	 | -----------------| ---------------------------
# **`organization_name`**| `string`         |
# **`andrew_id`**        | `string`         | 
class OrganizationList < ActiveRecord::Base
require 'csv'

def user_orgs(and_id)
	OrganizationList.where(andrew_id: and_id).to_a 
end

def self.import (org, file)
	CSV.foreach(file.path, headers: true) do |row|
		OrganizationList.create!(org, row.to_hash)
	end
end
end
