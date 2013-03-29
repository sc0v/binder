class Tool < ActiveRecord::Base
  attr_accessible :barcode, :description, :name
  validates :barcode, :uniqueness => true
  validates :name, :tool_type_id, :presence => true
  belongs_to :tool_type
  validates_associated :tool_type
end
