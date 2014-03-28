class CarnegieMellonPerson < ActiveLdap::Base
  ldap_mapping :dn_attribute => "guid",
               :prefix => "ou=Person",
               :classes => ["cmuPerson"]

  def self.find_by_andrewid( andrewid )
    
    begin
      person = find("cmuandrewid=#{andrewid}", :attributes => ['cmuandrewid',
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
