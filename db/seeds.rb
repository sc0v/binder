# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

seeds_folder = '2025 seeds'

# Read the "models" environment variable
models_to_seed = []
if ENV['models'].present?
  models_to_seed = ENV['models'].downcase.split(",")
end

puts
Rails.logger.debug 'Seeding Database...'
puts

if models_to_seed.length == 0 || models_to_seed.include?('organization')
Rails.logger.debug '  Organizations'

csv_text = Rails.root.join('lib', 'seeds', seeds_folder, "organizations.csv").read
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  organization_category ||= OrganizationCategory.find_by(name: row['organization_category'].strip)
  organization_category ||= OrganizationCategory.create(name: row['organization_category'].strip,
                                                        building: row['is_building'] == 'TRUE')
  if organization_category.building != (row['is_building'] == 'TRUE')
    Rails.logger.debug 'OrganizationCategory is_building inconsistent'
    raise
  end
  Organization.create(name: row['name'].strip, organization_category:,
                      short_name: row['short_name'])
end
end

=begin
if models_to_seed.length == 0 || models_to_seed.include?('participant')
Rails.logger.debug '  Participants'

csv_text = Rails.root.join('lib', 'seeds', "#{gdrive_doc}participants.csv").read
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  p row['organization']
  organization = Organization.find_by(name: row['organization'].strip)
  unless organization
    Rails.logger.debug { "    Organization (#{row['organization'].strip}) does not exist error" }
    raise
  end

  participant = Participant.find_by(eppn: "#{row['andrewid'].strip}@andrew.cmu.edu")
  unless participant
    #user = User.find_by(email: "#{row['andrewid'].strip}@andrew.cmu.edu")
    #user ||= User.create(email: "#{row['andrewid'].strip}@andrew.cmu.edu")

    #user.add_role :admin if row['admin'] == 'TRUE'
    #participant = Participant.create(andrewid: row['andrewid'], user:)
    participant = Participant.create(eppn: "#{row['andrewid'].strip}@andrew.cmu.edu")
  end

  Membership.create(organization: Organization.find_by(name:row['organization'].strip), participant:participant, title: row['title'],
                    is_booth_chair: row['booth_chair'] == 'TRUE')

  m = Membership.find_by(participant_id:participant.id)
  unless m
     m = Membership.create(organization: Organization.find_by(name:row['organization'].strip), participant:participant, title: row['title'],
                    is_booth_chair: row['booth_chair'] == 'TRUE')
  end
  if row['booth_chair'] == 'TRUE'
     m.is_booth_chair = true
     m.save
  end
  if m.organization_id == nil
     Rails.logger.debug {" participant : #{row['andrewid'].strip} , org: #{row['organization'].strip} "}
     m.organization_id = Organization.find_by(name:row['organization'].strip).id
     m.save
  end
end
end
=end

if models_to_seed.length == 0 || models_to_seed.include?('organizationbuildstatus')
Rails.logger.debug '  Organization Build Status'

Organization.all.each do |o|
  if o.building?
    OrganizationBuildStatus.create(status_type: 'structural', organization: o)
    OrganizationBuildStatus.create(status_type: 'electrical', organization: o)
  end
end
end

if models_to_seed.length == 0 || models_to_seed.include?('organizationbuildstep')
Rails.logger.debug '  Organization Build Steps'
two_story_csv_text = Rails.root.join('lib', 'seeds', seeds_folder, "two_story_organization_build_steps.csv").read
two_story_csv = CSV.parse(two_story_csv_text, headers: true)

one_story_csv_text = Rails.root.join('lib', 'seeds', seeds_folder, "one_story_organization_build_steps.csv").read
one_story_csv = CSV.parse(one_story_csv_text, headers: true)

Organization.all.each do |o|
  if o.building?
    # TODO: Manually change which orgs are 2-story since that's not defined in Binder
    if o.name.in?(["Kappa Alpha Theta","Alpha Epsilon Pi","Phi Delta Theta","Sigma Phi Epsilon","Kappa Kappa Gamma","Asian Student Association"])
      csv = two_story_csv
    else
      csv = one_story_csv
    end
    csv.each do |row|
      status = OrganizationBuildStatus.all.where(organization: o, status_type: row['status_type']).first
      if status.nil?
        OrganizationBuildStatus.create(status_type: row['status_type'], organization: o)
      end
      OrganizationBuildStep.create(title: row['title'], requirements: row['requirements'],
                                   organization_build_status: status, is_enabled: true)
    end
  end
end
end

if models_to_seed.length == 0 || models_to_seed.include?('chargetype')
Rails.logger.debug '  Charge Types'

csv_text = Rails.root.join('lib', 'seeds', seeds_folder, "charge_types.csv").read
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  ChargeType.create(name: row['name'].strip, description: row['description'] || '',
                    default_amount: Integer(row['default_amount'] || '0'))
end
end

if models_to_seed.length == 0 || models_to_seed.include?('faq')
Rails.logger.debug '  FAQs'

csv_text = Rails.root.join('lib', 'seeds', seeds_folder, "faqs.csv").read
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  organization_category = OrganizationCategory.find_by(name: row['organization_category'])
  FAQ.create(question: row['question'].strip, answer: row['answer'].strip,
             organization_category: )
end
end

=begin
Rails.logger.debug '  Tasks'

csv_text = Rails.root.join('lib', 'seeds', "#{gdrive_doc}tasks.csv").read
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  Task.create(name: row['name'].strip, description: row['description'].strip,
              due_at: DateTime.strptime(row['due_at'], '%m/%d/%Y %H:%M:%S'))
end

Rails.logger.debug '  Shifts'

csv_text = Rails.root.join('lib', 'seeds', "#{gdrive_doc}shifts.csv").read
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  organization = Organization.find_by(name: row['organization'].strip)
  unless organization
    Rails.logger.debug { "    Organization (#{row['organization'].strip}) does not exist" }
    raise
  end

  shift_type ||= ShiftType.find_by(name: row['shift_type'].strip)
  shift_type ||= ShiftType.create(name: row['shift_type'].strip)

  shift = Shift.create(organization:, shift_type:,
                       starts_at: DateTime.strptime(row['starts_at'], '%m/%d/%Y %H:%M:%S'), ends_at: DateTime.strptime(row['ends_at'], '%m/%d/%Y %H:%M:%S'), required_number_of_participants: Integer(row['required_number_of_participants']))

  next unless (row['andrewid'] || '') != ''

  participant = Participant.find_by(andrewid: row['andrewid'].strip)
  unless participant
    Rails.logger.debug { "    Participant (#{row['andrewid']}) does not exist" }
    raise
  end

  ShiftParticipant.create(shift:, participant:)
end
=end

if models_to_seed.length == 0 || models_to_seed.include?('storeitem')
Rails.logger.debug '  Store'

csv_text = Rails.root.join('lib', 'seeds', seeds_folder, "store.csv").read
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  StoreItem.create(name: row['name'].strip, price: Float(row['price'] || '0'),
                   quantity: Integer(row['quantity'] || '0'))
end
end

if models_to_seed.length == 0 || models_to_seed.include?('tool')
Rails.logger.debug '  Tools'

csv_text = Rails.root.join('lib', 'seeds', seeds_folder, "tools.csv").read
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  tool_type ||= ToolType.find_by(name: row['name'].strip)
  tool_type ||= ToolType.create(name: row['name'].strip)
  Tool.create(barcode: Integer(row['barcode']), tool_type:, description: row['description'])
rescue StandardError
  Rails.logger.debug row['barcode']
end
end

if models_to_seed.length == 0 || models_to_seed.include?('scissorlift')
Rails.logger.debug '  Scissor Lifts'

csv_text = Rails.root.join('lib', 'seeds', seeds_folder, "scissor_lifts.csv").read
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  ScissorLift.create(name: row['name'])
end
end

if models_to_seed.length == 0 || models_to_seed.include?('certification')
Rails.logger.debug '  Certifications'

csv_text = Rails.root.join('lib', 'seeds', "#{gdrive_doc}certifications.csv").read
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  certification_type = CertificationType.find_by(name: row['certification'].strip)
  unless certification_type
    tool_type = ToolType.find_by(name: row['certification'].strip)
    unless tool_type
      tool_type = ToolType.create(name: row['certification'].strip)
      Rails.logger.debug { "    ToolType (#{row['certification'].strip}) did not exist, created it" }
    end

    certification_type = CertificationType.create(name: row['certification'].strip)
    ToolTypeCertification.create(tool_type:, certification_type:)
  end

  participant = Participant.find_by(andrewid: row['andrewid'].strip)
  unless participant
    user = User.create(email: "#{row['andrewid'].strip}@andrew.cmu.edu")
    participant = Participant.create(andrewid: row['andrewid'], user:)
  end

  Certification.create(participant:, certification_type:)
end
end

if Rails.env.development?

  Rails.logger.debug '  Development Stuff'

  admin_andrewid = 'rcrown'
  scc_andrewid = 'cbrownel'
  booth_chair_andrewid = 'rpwhite'
  participant_andrewid = 'nharper'

  scc_org = Organization.find_by(name: 'Spring Carnival Committee')
  dtd_org = Organization.find_by(name: 'Delta Tau Delta')

  admin_user = User.create({ email: "#{admin_andrewid}@andrew.cmu.edu" })
  admin_user.add_role :admin
  admin = Participant.create({ andrewid: admin_andrewid, user: admin_user })
  Membership.create({ organization: scc_org, participant: admin, title: 'Admin', is_booth_chair: true })

  scc_user = User.create({ email: "#{scc_andrewid}@andrew.cmu.edu" })
  scc = Participant.create({ andrewid: scc_andrewid, user: scc_user })
  Membership.create({ organization: scc_org, participant: scc })

  booth_chair_user = User.create({ email: "#{booth_chair_andrewid}@andrew.cmu.edu" })
  booth_chair = Participant.create({ andrewid: booth_chair_andrewid, user: booth_chair_user })
  Membership.create({ organization: dtd_org, participant: booth_chair, is_booth_chair: true })

  participant_user = User.create({ email: "#{participant_andrewid}@andrew.cmu.edu" })
  participant = Participant.create({ andrewid: participant_andrewid, user: participant_user })
  Membership.create({ organization: dtd_org, participant: })
end
puts
