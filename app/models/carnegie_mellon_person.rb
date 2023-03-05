class CarnegieMellonPerson < ActiveLdap::Base
  ldap_mapping :dn_attribute => "uid",
               :prefix => ""

  def self.find_by_andrewid( andrewid )
    
    begin
      person = find("uid=#{andrewid}", :attributes => ['uid',
                                                               'cn', 
                                                               'mail',
                                                               'sn',
                                                               'cmuDepartment',
                                                               'cmuStudentClass'
                                                              ]) 

      if person['cmuDepartment'].is_a? Array
        person['cmuDepartment'] = person['cmuDepartment'].join(', ')
      end

      return person unless person[:cn] == "Merged Person"
    rescue
      return nil
    end
  end

end
