class ShiftType < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :shifts, :dependent => :destroy
end

