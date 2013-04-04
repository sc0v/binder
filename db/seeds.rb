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
  
  tool = Tool.create({ name: 'Hammer', barcode: 7, description: 'it\'s a fucking hammer' })
  Tool.create([{name: 'Hardhat', barcode: 111, description: 'Org Hardhat (White)'},
    {name: 'SCC Hardhat', barcode: 112, description: 'SCC Hardhat (Blue)'},
    {name: 'EH&S Hardhat', barcode: 115, description: 'Environmental Health and Safety Hardhat (Bright Yellow/Green)'},
    {name: 'Chair Hardhat', barcode: 113, description: 'Booth Chair Hardhat (Orange)'}])
  Checkout.create({ tool: tool, membership: chase_in_dtd, checked_out_at: Time.now - 5.hours })
  Checkout.create({ tool: tool, membership: chase_in_dtd, checked_out_at: Time.now - 8.hours, checked_in_at: Time.now - 7.hours })
  
  shift = Shift.create({ shift_type: ShiftType.find_by_name('Watch Shift'), organization: dtd_org, starts_at: Time.now - 1.hours, ends_at: Time.now + 10.hours, required_number_of_participants: 1 })
  Shift.create({ shift_type: ShiftType.find_by_name('Watch Shift'), organization: dtd_org, starts_at: Time.now - 3.hours, ends_at: Time.now - 1.hours, required_number_of_participants: 1 })
  ShiftParticipant.create({ shift: shift, participant: chase, clocked_in_at: Time.now - 50.minutes })

  Charge.create({ charge_type: ChargeType.find_by_name('Blown Breaker'), amount: 25, description: 'Delt blew their breaker all over midway', issuing_participant: chase, receiving_participant: chase, organization: dtd_org })
when 'production'
  #blah
end

