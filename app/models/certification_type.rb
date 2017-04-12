class CertificationType < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
end
