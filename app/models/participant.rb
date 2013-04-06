class Participant < ActiveRecord::Base
  attr_accessible :andrewid, :has_signed_waiver, :phone_number
  validates :andrewid, :presence => true, :uniqueness => true
  validates :has_signed_waiver, :acceptance => true
  validates :phone_number, :length => { :minimum => 10, :maximum => 10}, :numericality => true, :allow_nil => true
  has_many :organizations, :through => :memberships
  has_many :shifts, :through => :shift_participants
  has_many :organizations, :through => :memberships
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

end
