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


def self.add(org, andrew_id)
    OrganizationList.create(organization_id: org, andrew_id: andrew_id)
end 

def self.import (org, file)
    # if file.nil?
    #     puts "no file"
    # else
        count = 0
    	CSV.foreach(file.path, headers: false) do |row|
    	  begin
    	     OrganizationList.create(organization_id: org, andrew_id: row[0].strip)
             count += 1
    	  rescue
    	  else
    	  end
    	end
        return count
    # end
end
end
