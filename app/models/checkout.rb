class Checkout < ActiveRecord::Base
  belongs_to :membership
  belongs_to :tool
  # attr_accessible :title, :body
end
