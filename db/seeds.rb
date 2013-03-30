# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

scc = OrganizationCategory.create({ name: 'SCC'})
frat = OrganizationCategory.create({ name: 'Fraternity'})
soro = OrganizationCategory.create({ name: 'Sorority'})
blitz = OrganizationCategory.create({ name: 'Blitz'})
noncompete = OrganizationCategory.create({ name: 'Non-Competitive' })
scc_org = Organization.create({ name: 'SCC', organization_category: scc })

ShiftType.create([{ name: 'Watch Shift'}, { name: 'Security Shift'}, { name: 'Coordinator Shift'}])

ChargeType.create([
  { name: 'Late', description: 'One or more members were late for a watch shift.', requires_booth_chair_approval: false },
  { name: 'Blown Breaker', description: 'Breaker reset by Power and Safety. First one is fre', requires_booth_chair_approval: true, default_amount: 25.00 }])

case Rails.env
when 'development'
  dtd_org = Organization.create({ name: 'Delta Tau Delta', organization_category: frat })

  chase = Participant.create({ andrewid: 'cbrownel', has_signed_waiver: true })
  chase_in_dtd = Membership.create({ participant: chase, organization: dtd_org, is_booth_chair: true })
  chase_in_scc = Membership.create({ participant: chase, organization: scc_org, title: 'Logistics'})
  
  tool = Tool.create({ name: 'hammer', barcode: 7, description: 'it\'s a fucking hammer' })
  
  shift = Shift.create({ shift_type: ShiftType.find_by_name('Watch Shift'), organization: dtd_org, starts_at: Time.now - 1.hours, ends_at: Time.now + 10.hours, required_number_of_participants: 1 })
  ShiftParticipant.create({ shift: shift, participant: chase, clocked_in_at: Time.now - 50.minutes })
when 'production'
  #blah
end
