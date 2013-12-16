class Tool < ActiveRecord::Base
  has_many :checkouts, dependent: :destroy
  has_many :participants, :through => :checkouts
  has_many :organizations, :through => :checkouts

  validates :barcode, :presence => true, :uniqueness => true, :length => { :minimum => 2, :maximum => 20}
  validates :name, :presence => true

  default_scope { order('barcode') }
  scope :by_barcode, -> { order('barcode') }

  scope :hardhats, -> { where("lower(name) LIKE lower(?)", "%hardhat") }
  scope :radios, -> { where("lower(NAME) LIKE lower(?)", "%radio") }
  scope :just_tools, -> { where("lower(NAME) NOT LIKE lower(?) AND lower(NAME) NOT LIKE lower(?)", "%radio", "%hardhat") }
  scope :search, lambda { |term| where("lower(name) LIKE lower(?) OR lower(CAST(barcode AS TEXT)) LIKE lower(?) OR lower(description) LIKE lower(?)", "%#{term}%", "%#{term}%", "%#{term}%") }


  def current_organization
    self.checkouts.current.take.organization unless self.checkouts.current.blank?
  end

  def current_participant
    self.checkouts.current.take.participant unless self.checkouts.current.blank?
  end

  def is_checked_out?
    return not(self.checkouts.current.empty?)
  end

  def self.checked_out_by_organization(organization)
    joins(:checkouts).where(:checkouts => {:organization_id => organization }).merge(Checkout.current)
  end
end

