# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

gdrive_doc = '2022-seeds'
gdrive_doc += ' - '

puts
Rails.logger.debug 'Seeding Database...'
puts

Rails.logger.debug '  Organizations'

csv_text = Rails.root.join('lib', 'seeds', "#{gdrive_doc}organizations.csv").read
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  organization_category ||= OrganizationCategory.find_by(name: row['organization_category'].strip)
  organization_category ||= OrganizationCategory.create(name: row['organization_category'].strip,
                                                        is_building: row['is_building'] == 'TRUE')
  if organization_category.is_building != (row['is_building'] == 'TRUE')
    Rails.logger.debug 'OrganizationCategory is_building inconsistent'
    raise
  end
  Organization.create(name: row['name'].strip, organization_category:,
                      short_name: row['short_name'])
end

Rails.logger.debug '  Participants'

csv_text = Rails.root.join('lib', 'seeds', "#{gdrive_doc}participants.csv").read
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  organization = Organization.find_by(name: row['organization'].strip)
  unless organization
    Rails.logger.debug { "    Organization (#{row['organization'].strip}) does not exist error" }
    raise
  end

  participant = Participant.find_by(andrewid: row['andrewid'].strip)
  unless participant
    user = User.find_by(email: "#{row['andrewid'].strip}@andrew.cmu.edu")
    user ||= User.create(email: "#{row['andrewid'].strip}@andrew.cmu.edu")

    user.add_role :admin if row['admin'] == 'TRUE'
    participant = Participant.create(andrewid: row['andrewid'], user:)
  end

  Membership.create(organization:, participant:, title: row['title'],
                    is_booth_chair: row['booth_chair'] == 'TRUE')
end

Rails.logger.debug '  Organization Status Types'

csv_text = Rails.root.join('lib', 'seeds', "#{gdrive_doc}organization_status_types.csv").read
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  OrganizationStatusType.create(name: row['name'].strip, display: row['display'] == 'TRUE')
end

Rails.logger.debug '  Charge Types'

csv_text = Rails.root.join('lib', 'seeds', "#{gdrive_doc}charge_types.csv").read
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  ChargeType.create(name: row['name'].strip, description: row['description'] || '',
                    default_amount: Integer(row['default_amount'] || '0'))
end

Rails.logger.debug '  Event Types'

csv_text = Rails.root.join('lib', 'seeds', "#{gdrive_doc}event_types.csv").read
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  EventType.create(name: row['name'].strip, display: row['display'] == 'TRUE')
end

Rails.logger.debug '  FAQs'

csv_text = Rails.root.join('lib', 'seeds', "#{gdrive_doc}faqs.csv").read
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  Faq.create(question: row['question'].strip, answer: row['answer'].strip)
end

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

Rails.logger.debug '  Store'

csv_text = Rails.root.join('lib', 'seeds', "#{gdrive_doc}store.csv").read
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  StoreItem.create(name: row['name'].strip, price: Integer(row['price'] || '0'),
                   quantity: Integer(row['quantity'] || '0'))
end

Rails.logger.debug '  Tools'

csv_text = Rails.root.join('lib', 'seeds', "#{gdrive_doc}tools.csv").read
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  tool_type ||= ToolType.find_by(name: row['tool_type'].strip)
  tool_type ||= ToolType.create(name: row['tool_type'].strip)
  Tool.create(barcode: Integer(row['barcode']), tool_type:, description: row['description'])
rescue StandardError
  Rails.logger.debug row['barcode']
end

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
