class Document < ActiveRecord::Base
  validates_associated :organization

  belongs_to :organization

  mount_uploader :url, DocumentUploader
  
end
