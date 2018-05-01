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
validates_uniqueness_of :andrew_id, :scope => :organization_id

scope :user_orgs, ->(and_id) { where(andrew_id: and_id) }

# This model allows Organizations to upload lists of andrewIDs before Carnival
# When a user signs in, they will automatically be added to the organization

def self.add(org, andrew_id)
    OrganizationList.create(organization_id: org, andrew_id: andrew_id)
end 

def self.import (org, file)
        count = 0
    	CSV.foreach(file.path, headers: false) do |row|
    	  begin
    	     OrganizationList.create(organization_id: org, andrew_id: row[0].strip)
             count += 1
    	  rescue
    # 	  If the record already exists, don't add it by uniqueness, but ignore
    	  else
    	  end
    	end
        return count
    # end
end
end
