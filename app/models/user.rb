class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_save :email_downcase
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :id, :participant
  attr_accessible :role_ids, :as => :admin
  

  has_one :participant, dependent: :destroy
  
  # Validations
  # -----------------------------
  # make sure required fields are present
  validates_presence_of :name, :email  
  validates_uniqueness_of :email, :allow_blank => true
  validates_format_of :email, :with => /^[\w]([^@\s,;]+)@(([a-z0-9.-]+\.)+(com|edu|org|net|gov|mil|biz|info))$/i, :message => "is not a valid format", :allow_blank => true
  validates_presence_of :password, :on => :create 
  validates_presence_of :password_confirmation, :on => :create 
  validates_confirmation_of :password, :message => "does not match"
  validates_length_of :password, :minimum => 4, :message => "must be at least 4 characters long", :allow_blank => true
  
  scope :search, lambda { |term| where('lower(name) LIKE lower(?) OR lower(email) LIKE lower(?)', "#{term}%", "#{term}%") }

  def email_downcase
    self.email = self.email.downcase
  end

end
