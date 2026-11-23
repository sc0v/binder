# frozen_string_literal: true

class CarnegieMellonPerson < ActiveLdap::Base
  ldap_mapping dn_attribute: 'uid', prefix: ''

  # Made-up people for development and tests, so neither ever looks anyone up
  # in CMU's directory.
  # The first five are the test accounts on the developer sign-in page, one
  # per role (db/seeds.rb creates them); the test fixtures use the rest.
  MADE_UP_PEOPLE = {
    'aa00' => {
      'cn' => 'Andy Admin',
      'sn' => 'Admin',
      'cmuDepartment' => 'Information Systems'
    },
    'cc00' => {
      'cn' => 'Carly Committee',
      'sn' => 'Committee',
      'cmuDepartment' => 'Design'
    },
    'bb00' => {
      'cn' => 'Bobby Booth',
      'sn' => 'Booth',
      'cmuDepartment' => 'Civil and Environmental Engineering'
    },
    'pp00' => {
      'cn' => 'Polly Participant',
      'sn' => 'Participant',
      'cmuDepartment' => 'Art'
    },
    'ss00' => {
      'cn' => 'Sammy Spectator',
      'sn' => 'Spectator',
      'cmuDepartment' => 'Mathematical Sciences'
    },
    'ac00' => {
      'cn' => 'Andrew Carnegie',
      'sn' => 'Carnegie',
      'cmuDepartment' => 'Spring Carnival Committee'
    },
    'mm00' => {
      'cn' => 'Margaret Morrison',
      'sn' => 'Morrison',
      'cmuDepartment' => 'Spring Carnival Committee'
    },
    'am00' => {
      'cn' => 'Andrew Mellon',
      'sn' => 'Mellon',
      'cmuDepartment' => 'Delta Tau Delta'
    }
  }.freeze

  def self.live?
    %w[production staging].include?(Rails.env)
  end

  def self.find_by(params)
    return made_up_person(params) unless live?

    filter =
      if params[:uid]
        "uid=#{params[:uid]}"
      else
        "eduPersonPrincipalName=#{params[:eppn]}"
      end
    person =
      find(filter, attributes: %w[uid cn mail sn cmuDepartment cmuStudentClass])

    person['cmuDepartment'] = person['cmuDepartment'].join(', ') if person[
      'cmuDepartment'
    ].is_a?(Array)

    person unless person[:cn] == 'Merged Person'
  rescue StandardError
    nil
  end

  def self.made_up_person(params)
    uid = (params[:uid] || params[:eppn].to_s.split('@').first).to_s.downcase
    person = MADE_UP_PEOPLE[uid]
    person&.merge('uid' => uid, 'mail' => "#{uid}@andrew.cmu.edu")
  end
end
