class Participant < ActiveRecord::Base
  attr_accessible :andrewid, :has_signed_waiver, :phone_number, :has_signed_hardhat_waiver
  validates :andrewid, :presence => true, :uniqueness => true
  validates :has_signed_waiver, :acceptance => true
  validates :phone_number, :length => { :minimum => 10, :maximum => 10}, :numericality => true, :allow_nil => true
  has_many :organizations, :through => :memberships
  has_many :shifts, :through => :shift_participants
  has_many :organizations, :through => :memberships
  has_many :checkouts
  has_many :tools, :through => :checkouts
  has_many :memberships
  has_many :shift_participants

  def ldap_reference
    @ldap_reference ||= CarnegieMellonPerson.find_by_andrewid( self.andrewid )
    # Add new attributes to CarnegieMellonPerson attributes before adding 
    # references to them in participant.rb
  end

  def name
    Array.[](ldap_reference["cn"]).flatten.last
  end

  def surname
    ldap_reference["sn"]
  end
  
  def email
    ldap_reference["mail"]
  end

  def department
    ldap_reference["cmuDepartment"]
  end

  def student_class
    ldap_reference["cmuStudentClass"]
  end


  def self.find_by_card full_card_number
    card_number = full_card_number[1,9]
    lookup = ActiveSupport::JSON.decode( 
                 RestClient.get( 
                   "http://merichar-dev.eberly.cmu.edu/cgi-bin/card-lookup?card_id=#{card_number}"
                 )
               )
    unless lookup.nil?
      self.find_by_andrewid lookup['andrewid']
    end
  end

end
