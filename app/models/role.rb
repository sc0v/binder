class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  ROLES = [:admin]
end
