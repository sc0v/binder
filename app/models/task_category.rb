class TaskCategory < ActiveRecord::Base
  # attr_accessible :name

  has_many :tasks

  validates :name, :presence => true
end
