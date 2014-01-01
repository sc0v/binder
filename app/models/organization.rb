class Organization < ActiveRecord::Base
  validates_presence_of :organization_category, :name
  validates_associated :organization_category
  validates :name, :uniqueness => true

  belongs_to :organization_category
  has_many :memberships
  has_many :organization_aliases, :dependent => :destroy
  has_many :organization_statuses, :dependent => :destroy
  has_many :participants, :through => :memberships
  has_many :charges, :dependent => :destroy
  has_many :documents, :dependent => :destroy
  has_many :tools, :through => :checkouts
  has_many :checkouts
  has_many :shifts  

  default_scope { order('name asc') }

  scope :search, lambda { |term| where('lower(name) LIKE lower(?)', "%#{term}%") } 
  
  def booth_chairs
    memberships.where(:is_booth_chair => true).order('booth_chair_order ASC').map{|m| m.participant}
  end

  def non_booth_chairs
    memberships.where(:is_booth_chair => false).map{|m| m.participant}
  end
end

