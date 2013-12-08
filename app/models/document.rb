class Document < ActiveRecord::Base
  # attr_accessible :url, :name

  mount_uploader :url, DocumentUploader
  
end
