# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require_relative 'tool_seed.rb'

# Organization Categories -----------------
scc = OrganizationCategory.create({ name: 'SCC'})
frat = OrganizationCategory.create({ name: 'Fraternity'})
soro = OrganizationCategory.create({ name: 'Sorority'})
indie = OrganizationCategory.create({ name: 'Independent'})
blitz = OrganizationCategory.create({ name: 'Blitz'})
concessions = OrganizationCategory.create({ name: 'Concessions'})
non_building = OrganizationCategory.create({ name: 'Non-Building' })

# Organizations ---------------------------
scc_org = Organization.create({ name: 'SCC', organization_category: scc })
  OrganizationAlias.create({ organization: scc_org, name: 'Spring Carnival Committee' })

kapsig_org = Organization.create({ name: 'Kappa Sigma', organization_category: concessions })
  OrganizationAlias.create({ organization: kapsig_org, name: 'KapSig' })
aphio_org = Organization.create({ name: 'Alpha Phi Omega', organization_category: concessions })
  OrganizationAlias.create({ organization: aphio_org, name: 'APhiO' })

aepi_org = Organization.create({ name: 'Alpha Epsilon Pi', organization_category: frat })
  OrganizationAlias.create({ organization: aepi_org, name: 'AEPi' })
dtd_org = Organization.create({ name: 'Delta Tau Delta', organization_category: frat })
  OrganizationAlias.create({ organization: dtd_org, name: 'Delt' })
  OrganizationAlias.create({ organization: dtd_org, name: 'DTD' })
du_org = Organization.create({ name: 'Delta Upsilon', organization_category: frat })
  OrganizationAlias.create({ organization: du_org, name: 'DU' })
sae_org = Organization.create({ name: 'Sigma Alpha Epsilon', organization_category: frat })
  OrganizationAlias.create({ organization: sae_org, name: 'SAE' })
sigep_org = Organization.create({ name: 'Sigma Phi Epsilon', organization_category: frat })
  OrganizationAlias.create({ organization: sigep_org, name: 'SigEp' })
  OrganizationAlias.create({ organization: sigep_org, name: 'SPE' })

aphi_org = Organization.create({ name: 'Alpha Phi', organization_category: soro })
axo_org = Organization.create({ name: 'Alpha Chi Omega', organization_category: soro })
  OrganizationAlias.create({ organization: axo_org, name: 'AXO' })
  OrganizationAlias.create({ organization: axo_org, name: 'Alpha Chi' })
ddd_org = Organization.create({ name: 'Delta Delta Delta', organization_category: soro })
  OrganizationAlias.create({ organization: ddd_org, name: 'DDD' })
  OrganizationAlias.create({ organization: ddd_org, name: 'TriDelta' })
dg_org = Organization.create({ name: 'Delta Gamma', organization_category: soro })
  OrganizationAlias.create({ organization: dg_org, name: 'DG' })
kat_org = Organization.create({ name: 'Kappa Alpha Theta', organization_category: soro })
  OrganizationAlias.create({ organization: kat_org, name: 'KAT' })
  OrganizationAlias.create({ organization: kat_org, name: 'Theta' })
kkg_org = Organization.create({ name: 'Kappa Kappa Gamma', organization_category: soro })
  OrganizationAlias.create({ organization: kkg_org, name: 'KKG' })
  OrganizationAlias.create({ organization: kkg_org, name: 'Kappa' })

asa_org = Organization.create({ name: 'Asian Student Association', organization_category: indie })
  OrganizationAlias.create({ organization: asa_org, name: 'ASA' })
kgb_org = Organization.create({ name: 'KGB', organization_category: indie })
sdc_org = Organization.create({ name: 'Student Dormitory Council', organization_category: indie })
  OrganizationAlias.create({ organization: sdc_org, name: 'SDC' })
ssa_org = Organization.create({ name: 'Sigaporrean Student Association', organization_category: indie })
  OrganizationAlias.create({ organization: ssa_org, name: 'SSA' })
tsa_org = Organization.create({ name: 'Taiwanese Student Association', organization_category: indie })
  OrganizationAlias.create({ organization: tsa_org, name: 'TSA' })

akpsi_org = Organization.create({ name: 'Alpha Kappa Psi', organization_category: blitz })
  OrganizationAlias.create({ organization: akpsi_org, name: 'AKPsi' })
fringe_org = Organization.create({ name: 'Fringe', organization_category: blitz })
spirit_org = Organization.create({ name: 'Spirit', organization_category: blitz })
mudge_org = Organization.create({ name: 'Mudge', organization_category: blitz })
astro_org = Organization.create({ name: 'Astronomy Club', organization_category: blitz })
  OrganizationAlias.create({ organization: astro_org, name: 'Astro' })
mayur_org = Organization.create({ name: 'Mayur SASA', organization_category: blitz })
  OrganizationAlias.create({ organization: mayur_org, name: 'Mayur' })
  OrganizationAlias.create({ organization: mayur_org, name: 'SASA' })
stever_org = Organization.create({ name: 'Stever', organization_category: blitz })

crew_org = Organization.create({ name: 'Crew', organization_category: non_building })
the_os_org = Organization.create({ name: 'The Originals', organization_category: non_building })
  OrganizationAlias.create({ organization: the_os_org, name: 'The O\'s' })
pike_org = Organization.create({ name: 'Pi Kappa Alpha', organization_category: non_building })
  OrganizationAlias.create({ organization: pike_org, name: 'Pike' })
  OrganizationAlias.create({ organization: pike_org, name: 'Pika' })
polo_org = Organization.create({ name: 'Water Polo', organization_category: non_building })
  OrganizationAlias.create({ organization: polo_org, name: 'Polo' })
habitat_org = Organization.create({ name: 'Habitat for Humanity', organization_category: non_building })
  OrganizationAlias.create({ organization: habitat_org, name: 'Habitat' })

tartan_org = Organization.create({ name: 'The Tartan', organization_category: non_building })
thistle_org = Organization.create({ name: 'The Thistle', organization_category: non_building })
senate_org = Organization.create({ name: 'Student Senate', organization_category: non_building })
  OrganizationAlias.create({ organization: senate_org, name: 'JFC' })

ShiftType.create([
  { name: 'Watch Shift' }, 
  { name: 'Security Shift' }, 
  { name: 'Coordinator Shift' }])

ChargeType.create([
  { name: 'Other', 
    description: 'Other violation as determined by the coordinator, please document extensively and inform the Midway Chair incase any problems arise.', 
    requires_booth_chair_approval: true },
  { name: 'Vehicle on Midway', 
    description: 'Organization had a vehicle on Midway without Committee approval. Amount to be determined by Rules Committee.', 
    requires_booth_chair_approval: true },
  { name: '1st Late Shift', 
    description: 'One member was late for a watch shift. First violation. Add a separate fine for each person.', 
    default_amount: 10 },
  { name: '2nd Late Shift', description: 'One member was late for a watch shift. Second violation. Add a separate fine for each person.', 
    default_amount: 20 },
  { name: '3rd Late Shift', description: 'One member late for a watch shift. Third violation. Add a separate fine for each person.', 
    default_amount: 40 },
  { name: '4th or More Late Shift', 
    description: 'One or more members were late for a watch shift. Forth and subsequent violations. Add a separate fine for each person.' },
  { name: '1st Missed Shift', 
    description: 'One member was more than 10 minutes late for a watch shift or arrived incapable of completing the shift (i.e. drunk). First Violation only. Add a separate fine for each person and halve the fine if they arrive less than 45 minutes late.', 
    default_amount: 50 },
  { name: '2nd Missed Shift', 
    description: 'One member was more than 10 minutes late for a watch shift or arrived incapable of completing the shift (i.e. drunk). Second Violation only. Add a separate fine for each person and halve the fine if they arrive less than 45 minutes late.', 
    default_amount: 100 },
  { name: '3rd Missed Shift', 
    description: 'One member was more than 10 minutes late for a watch shift or arrived incapable of completing the shift (i.e. drunk). Third and subsequent violations. Add a separate fine for each person and halve the fine if they arrive less than 45 minutes late.' },
  { name: 'Uncooperative Shift', 
    description: 'Members working the shift failed or refused to complete tasks as assigned by the coordinator.', 
    default_amount: 25 },
  { name: 'Shift Left', description: 'Members working the shift left before being dismissed by the coordinator. Add a separate fine for each person.', 
    default_amount: 25 },
  { name: 'Teardown Shift Missed', 
    description: 'Organization failed to complete the required six man hours during teardown. Fine should be $50 per hour not completed',
    requires_booth_chair_approval: true, 
    default_amount: 50 },
  { name: 'Blown Breaker', 
    description: 'Breaker reset by Power and Safety. First one is free.', 
    requires_booth_chair_approval: true, 
    default_amount: 25.00 },
  { name: 'Unauthorized Plugin', 
    description: 'Organization pluged their booth into power before given permission by Power and Safely.', 
    requires_booth_chair_approval: true, 
    default_amount: 100 }])

# Task Statuses ----------------------------------------
uncompleted_task = TaskStatus.create({ name: "Not Completed" })
completed_task = TaskStatus.create({ name: "Completed" })
unable_to_complete_task = TaskStatus.create({ name: "Unable to Complete" })

generate_tools

case Rails.env
when 'development'
  chase = Participant.create({ andrewid: 'cbrownel', phone_number: 7173435788 })
  merichar = Participant.create({ andrewid: 'meribyte' })
  merichar_in_scc = Membership.create({ participant: merichar, organization: scc_org, is_booth_chair: true })
  chase_in_dtd = Membership.create({ participant: chase, organization: dtd_org, is_booth_chair: true })
  chase_in_scc = Membership.create({ participant: chase, organization: scc_org, title: 'Logistics'})
  
  tool = Tool.create({ name: 'Hammer', barcode: 7, description: 'it\'s a fucking hammer' })
  Tool.create([
    {name: 'Hardhat', barcode: 111, description: 'Org Hardhat (White)'},
    {name: 'SCC Hardhat', barcode: 112, description: 'SCC Hardhat (Blue)'},
    {name: 'EH&S Hardhat', barcode: 115, description: 'Environmental Health and Safety Hardhat (Bright Yellow/Green)'},
    {name: 'Chair Hardhat', barcode: 113, description: 'Booth Chair Hardhat (Orange)'}])
  Checkout.create({ tool: tool, membership: chase_in_dtd, checked_out_at: Time.now - 5.hours })
  Checkout.create({ tool: tool, membership: chase_in_dtd, checked_out_at: Time.now - 8.hours, checked_in_at: Time.now - 7.hours })
  
  shift = Shift.create({ shift_type: ShiftType.find_by_name('Watch Shift'), organization: dtd_org, starts_at: Time.now - 1.hours, ends_at: Time.now + 1.hours, required_number_of_participants: 1 })
  Shift.create({ shift_type: ShiftType.find_by_name('Watch Shift'), organization: dtd_org, starts_at: Time.now - 3.hours, ends_at: Time.now - 1.hour, required_number_of_participants: 1 })
  Shift.create({ shift_type: ShiftType.find_by_name('Watch Shift'), organization: dtd_org, starts_at: Time.now + 1.hours, ends_at: Time.now + 15.hours, required_number_of_participants: 1 })
  ShiftParticipant.create({ shift: shift, participant: chase, clocked_in_at: Time.now - 50.minutes })

  Charge.create({ charge_type: ChargeType.find_by_name('Blown Breaker'), amount: 25, description: 'Delt blew their breaker all over midway', issuing_participant: merichar, receiving_participant: chase, organization: dtd_org, charged_at: Time.now })

  # Tasks ---
  Task.create([{ name: "todo", task_status: uncompleted_task, due_at: Time.now + 1.hour, display_duration: Time.now - 3.hours, description: "Many things" },
    {name: "done", due_at: Time.now, display_duration: Time.now - 1.hours, completed_by: chase, task_status: completed_task},
    {name: "not done", due_at: Time.now, display_duration: Time.now - 1.hours, completed_by: chase, task_status: unable_to_complete_task},
    {name: "late", due_at: Time.now - 30.minutes, display_duration: Time.now - 1.hours, task_status: uncompleted_task}])
when 'production'
  #blah
end

