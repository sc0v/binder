# frozen_string_literal: true

class CarnegieMellonPerson < ActiveLdap::Base
  ldap_mapping dn_attribute: 'uid',
               prefix: ''

  def self.find_by(params)
    eppn = params[:eppn]
    person = find("eduPersonPrincipalName=#{eppn}", attributes: %w[uid
                                                                   cn
                                                                   mail
                                                                   sn
                                                                   cmuDepartment
                                                                   cmuStudentClass])

    person['cmuDepartment'] = person['cmuDepartment'].join(', ') if person['cmuDepartment'].is_a? Array

    return person unless person[:cn] == 'Merged Person'
  rescue StandardError
    nil
  end
end
