class ContactList < ActiveRecord::Base 
   # attr_accessible :participant_id, :participant

   belongs_to :participant
   
   # scope :admins, where(:participants.user.user_role.role => Role.find_by_role("admin").id) #this requires links participant <--> user <--> user_role
   
end
