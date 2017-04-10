# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require_relative 'tool_seed.rb'

puts
puts 'Seeding Databse...'
puts

# Organization Categories -----------------------------------------------------
puts 'Organization Categories'

fraternity = OrganizationCategory.create({ name: 'Fraternity'})
sorority = OrganizationCategory.create({ name: 'Sorority'})
independent = OrganizationCategory.create({ name: 'Independent'})
blitz = OrganizationCategory.create({ name: 'Blitz'})
concessions = OrganizationCategory.create({ name: 'Concessions'})
non_building = OrganizationCategory.create({ name: 'Non-Building' })
scc = OrganizationCategory.create({ name: 'SCC'})
staff = OrganizationCategory.create({ name: 'Staff' })


# Organizations ---------------------------------------------------------------
puts 'Organizations'
scc_org = Organization.create({ name: 'Spring Carnival Committee', organization_category: scc, short_name: 'SCC' })

puts '  University'
ehs_org = Organization.create({ name: 'Environmental Health and Safety', organization_category: staff, short_name: 'EH&S' })
  OrganizationAlias.create({ organization: ehs_org, name: 'EHS' })
fmcs_org = Organization.create({ name: 'Facilities Management and Campus Services', organization_category: staff, short_name: 'FMCS' })
  OrganizationAlias.create({ organization: fmcs_org, name: 'Facilities Management Services' })
  OrganizationAlias.create({ organization: fmcs_org, name: 'FMS' })
slice_org = Organization.create({ name: 'Student Leadership, Involvement, and Civic Engagement', organization_category: staff, short_name: 'SLICE' })
  OrganizationAlias.create({ organization: slice_org, name: 'Student Affairs' })
  OrganizationAlias.create({ organization: slice_org, name: 'DOSA' })
  OrganizationAlias.create({ organization: slice_org, name: 'Division of Student Affairs' })
  OrganizationAlias.create({ organization: slice_org, name: 'Student Activities' })
  OrganizationAlias.create({ organization: slice_org, name: 'Student Life' })

puts '  Consessions'
aphio_org = Organization.create({ name: 'Alpha Phi Omega', organization_category: concessions, short_name: 'APhiO' })

puts '  Fraternity'
dtd_org = Organization.create({ name: 'Delta Tau Delta', organization_category: fraternity, short_name: 'DTD' })
  OrganizationAlias.create({ organization: dtd_org, name: 'Delt' })
phidelt_org = Organization.create({ name: 'Phi Delta Theta', organization_category: fraternity, short_name: 'Phi Delt' })
asig_org = Organization.create({ name: 'Alpha Sigma Phi', organization_category: fraternity, short_name: 'Alpha Sig' })
aepi_org = Organization.create({ name: 'Alpha Epsilon Pi', organization_category: fraternity, short_name: 'AEPi' })
sigep_org = Organization.create({ name: 'Sigma Phi Epsilon', organization_category: fraternity, short_name: 'SigEp' })

puts '  Sorority'
kat_org = Organization.create({ name: 'Kappa Alpha Theta', organization_category: sorority, short_name: 'Theta' })
  OrganizationAlias.create({ organization: kat_org, name: 'KAT' })
kkg_org = Organization.create({ name: 'Kappa Kappa Gamma', organization_category: sorority, short_name: 'Kappa' })
  OrganizationAlias.create({ organization: kkg_org, name: 'KKG' })
aphi_org = Organization.create({ name: 'Alpha Phi', organization_category: sorority })
  OrganizationAlias.create({ organization: aphi_org, name: 'APhi' })
axo_org = Organization.create({ name: 'Alpha Chi Omega', organization_category: sorority, short_name: 'AXO' })
  OrganizationAlias.create({ organization: axo_org, name: 'Alpha Chi' })
ddd_org = Organization.create({ name: 'Delta Delta Delta', organization_category: sorority, short_name: 'Tri Delt' })
  OrganizationAlias.create({ organization: ddd_org, name: 'DDD' })
dg_org = Organization.create({ name: 'Delta Gamma', organization_category: sorority, short_name: 'DG' })

puts '  Independent'
fringe_org = Organization.create({ name: 'Fringe', organization_category: independent })
kgb_org = Organization.create({ name: 'KGB', organization_category: independent, short_name: 'KGB' })
tsa_org = Organization.create({ name: 'Taiwanese Students Association', organization_category: independent, short_name: 'TSA' })
asa_org = Organization.create({ name: 'Asian Students Association', organization_category: independent, short_name: 'ASA' })

puts '  Blitz'
csa_org = Organization.create({ name: 'Chinese Student Association', organization_category: blitz, short_name: 'CSA' })
sigchi_org = Organization.create({ name: 'Sigma Chi', organization_category: blitz, short_name: 'SigChi' })
  OrganizationAlias.create({ organization: sigchi_org, name: 'SX' })
math_org = Organization.create({ name: 'Math Club', organization_category: blitz, short_name: 'Math' })
akpsi_org = Organization.create({ name: 'Alpha Kappa Psi Professional Business Fraternity', organization_category: blitz, short_name: 'AKPsi' })
  OrganizationAlias.create({ organization: akpsi_org, name: 'Alpha Kappa Psi' })
asce_org = Organization.create({ name: 'American Society of Civil Engineers', organization_category: blitz, short_name: 'ASCE' })
astro_org = Organization.create({ name: 'Astronomy Club', organization_category: blitz, short_name: 'Astro' })
kapsig_org = Organization.create({ name: 'Kappa Sigma', organization_category: blitz, short_name: 'KapSig' })
sdc_org = Organization.create({ name: 'Student Dormitory Council', organization_category: blitz, short_name: 'SDC' })

puts '  Non-Building'
ems_org = Organization.create({ name: 'Emergency Medical Service', organization_category: non_building, short_name: 'EMS' })
originals_org = Organization.create({ name: 'The Originals', organization_category: non_building, short_name: 'Originals' })
cheme_org = Organization.create({ name: 'CMU ChemE Car', organization_category: non_building, short_name: 'ChemE' })
rowing_org  = Organization.create({ name: 'Rowing Club', organization_category: non_building, short_name: 'Rowing' })
  OrganizationAlias.create({ organization: rowing_org, name: 'Crew' })
moot_org = Organization.create({ name: 'Moot Court', organization_category: non_building, short_name: 'Moot' })
quidditch_org = Organization.create({ name: 'Quidditch Club', organization_category: non_building, short_name: 'Quidditch' })
juntos_org = Organization.create({ name: 'Juntos', organization_category: non_building, short_name: 'Juntos' })


# Cell phone carriers ---------------------------------------------------------
puts 'Phone Carriers'

['Verizon Wireless','Sprint','AT&T','T-Mobile','Metro PCS','US Cellular','Cricket','Virgin Mobile','Boost Mobile'].each do |name|
  PhoneCarrier.create({ name: name })
end


# SCC Members -----------------------------------------------------------------
puts 'SCC Members'
scc_members = [
  { andrewid: 'amartine', title: 'Carnival Chair', binder_admin: true, exec_board: true },
  { andrewid: 'asgreen', title: 'Advisor', binder_admin: true },
  { andrewid: 'grickstr', title: 'Head of Marketing', exec_board: true },
  { andrewid: 'hkoschme', title: 'Head of Entertainment', exec_board: true },
  { andrewid: 'jcmertz', title: 'Head of Operations', exec_board: true },
  { andrewid: 'jzak', title: 'Head of Booth', binder_admin: true, exec_board: true },
  { andrewid: 'mreager', title: 'Assistant Head of Operations', exec_board: true },
  { andrewid: 'ncoauett', title: 'Head of Booth Operations', exec_board: true },
  { andrewid: 'saclark', title: 'Assistant Head of Operations', binder_admin: true, exec_board: true },
  { andrewid: 'zileig', title: 'Treasurer', binder_admin: true, exec_board: true },
  { andrewid: 'meribyte', binder_admin: true },
  { andrewid: 'agotsis' },
  { andrewid: 'awhyte' },
  { andrewid: 'ayang1' },
  { andrewid: 'zhenghaj' },
  { andrewid: 'cmorin' },
  { andrewid: 'clairec1' },
  { andrewid: 'dkaushal' },
  { andrewid: 'jlareau' },
  { andrewid: 'egarbade' },
  { andrewid: 'epnewman' },
  { andrewid: 'jacobbro' },
  { andrewid: 'jlliang' },
  { andrewid: 'jbz' },
  { andrewid: 'jcp' },
  { andrewid: 'jsatvoll' },
  { andrewid: 'kmg' },
  { andrewid: 'kborst' },
  { andrewid: 'kmquinn' },
  { andrewid: 'lbressle' },
  { andrewid: 'lgmiller' },
  { andrewid: 'lawrencx' },
  { andrewid: 'madedjou' },
  { andrewid: 'mjvultag' },
  { andrewid: 'nehull' },
  { andrewid: 'ryerzhan' },
  { andrewid: 'swu1' },
  { andrewid: 'stacycha' },
  { andrewid: 'tford' },
  { andrewid: 'wlowe' },
  { andrewid: 'zsolan' }
]

scc_members.each do |member|
  user = User.create({ email: "#{member[:andrewid]}@andrew.cmu.edu" })
  if !!member[:binder_admin]
    user.add_role :admin
  end
  participant = Participant.create({ andrewid: member[:andrewid], user: user })
  Membership.create({ organization: scc_org, participant: participant, title: member[:title], is_booth_chair: !!member[:exec_board] })
end


# Booth Chairs ----------------------------------------------------------------
puts 'Booth Chairs'

Membership.create({ organization: axo_org, participant: Participant.create({ andrewid: 'zihuiy' }), is_booth_chair: true })
Membership.create({ organization: axo_org, participant: Participant.create({ andrewid: 'jennywan' }), is_booth_chair: true })
Membership.create({ organization: axo_org, participant: Participant.create({ andrewid: 'rchowdhu' }), is_booth_chair: true })
Membership.create({ organization: aepi_org, participant: Participant.create({ andrewid: 'enumbers' }), is_booth_chair: true })
Membership.create({ organization: aepi_org, participant: Participant.create({ andrewid: 'sjplatt' }), is_booth_chair: true })
Membership.create({ organization: aepi_org, participant: Participant.create({ andrewid: 'aadler' }), is_booth_chair: true })
Membership.create({ organization: aphi_org, participant: Participant.create({ andrewid: 'ajwu' }), is_booth_chair: true })
Membership.create({ organization: aphio_org, participant: Participant.create({ andrewid: 'jennyw' }), is_booth_chair: true })
Membership.create({ organization: aphio_org, participant: Participant.create({ andrewid: 'euniceo' }), is_booth_chair: true })
Membership.create({ organization: aphio_org, participant: Participant.create({ andrewid: 'stevengu' }), is_booth_chair: true })
Membership.create({ organization: asig_org, participant: Participant.create({ andrewid: 'eda' }), is_booth_chair: true })
Membership.create({ organization: asig_org, participant: Participant.create({ andrewid: 'mfaith' }), is_booth_chair: true })
Membership.create({ organization: asa_org, participant: Participant.create({ andrewid: 'shenghah' }), is_booth_chair: true })
Membership.create({ organization: asa_org, participant: Participant.create({ andrewid: 'rhkim' }), is_booth_chair: true })
Membership.create({ organization: asa_org, participant: Participant.create({ andrewid: 'munsungk' }), is_booth_chair: true })
Membership.create({ organization: astro_org, participant: Participant.create({ andrewid: 'mspoerl' }), is_booth_chair: true })
Membership.create({ organization: astro_org, participant: Participant.create({ andrewid: 'cbostanc' }), is_booth_chair: true })
Membership.create({ organization: astro_org, participant: Participant.create({ andrewid: 'lkastel' }), is_booth_chair: true })
Membership.create({ organization: csa_org, participant: Participant.create({ andrewid: 'jiangxul' }), is_booth_chair: true })
Membership.create({ organization: csa_org, participant: Participant.create({ andrewid: 'kaiz1' }), is_booth_chair: true })
Membership.create({ organization: csa_org, participant: Participant.create({ andrewid: 'dingkunw' }), is_booth_chair: true })
Membership.create({ organization: dg_org, participant: Participant.create({ andrewid: 'pmckeefr' }), is_booth_chair: true })
Membership.create({ organization: dg_org, participant: Participant.create({ andrewid: 'abranson' }), is_booth_chair: true })
Membership.create({ organization: dtd_org, participant: Participant.create({ andrewid: 'aperley' }), is_booth_chair: true })
Membership.create({ organization: dtd_org, participant: Participant.create({ andrewid: 'ldamasco' }), is_booth_chair: true })
Membership.create({ organization: dtd_org, participant: Participant.create({ andrewid: 'achmykh' }), is_booth_chair: true })
Membership.create({ organization: fringe_org, participant: Participant.create({ andrewid: 'lcody' }), is_booth_chair: true })
Membership.create({ organization: fringe_org, participant: Participant.create({ andrewid: 'khelmy' }), is_booth_chair: true })
Membership.create({ organization: fringe_org, participant: Participant.create({ andrewid: 'descando' }), is_booth_chair: true })
Membership.create({ organization: kat_org, participant: Participant.create({ andrewid: 'nwinegar' }), is_booth_chair: true })
Membership.create({ organization: kat_org, participant: Participant.create({ andrewid: 'mahiggin' }), is_booth_chair: true })
Membership.create({ organization: kat_org, participant: Participant.create({ andrewid: 'sfarber' }), is_booth_chair: true })
Membership.create({ organization: kapsig_org, participant: Participant.create({ andrewid: 'efiedore' }), is_booth_chair: true })
Membership.create({ organization: kgb_org, participant: Participant.create({ andrewid: 'dtv' }), is_booth_chair: true })
Membership.create({ organization: kgb_org, participant: Participant.create({ andrewid: 'kfair' }), is_booth_chair: true })
Membership.create({ organization: kgb_org, participant: Participant.create({ andrewid: 'shempton' }), is_booth_chair: true })
Membership.create({ organization: kkg_org, participant: Participant.create({ andrewid: 'ptai' }), is_booth_chair: true })
Membership.create({ organization: kkg_org, participant: Participant.create({ andrewid: 'amayor' }), is_booth_chair: true })
Membership.create({ organization: kkg_org, participant: Participant.create({ andrewid: 'mmwagner' }), is_booth_chair: true })
Membership.create({ organization: math_org, participant: Participant.create({ andrewid: 'jaz' }), is_booth_chair: true })
Membership.create({ organization: math_org, participant: Participant.create({ andrewid: 'ehaney' }), is_booth_chair: true })
#Membership.create({ organization: mcs_org, participant: Participant.create({ andrewid: 'dduenas' }), is_booth_chair: true })
#Membership.create({ organization: mcs_org, participant: Participant.create({ andrewid: 'mbedell' }), is_booth_chair: true })
Membership.create({ organization: phidelt_org, participant: Participant.create({ andrewid: 'aoneill' }), is_booth_chair: true })
Membership.create({ organization: sdc_org, participant: Participant.create({ andrewid: 'dbperry' }), is_booth_chair: true })
Membership.create({ organization: sdc_org, participant: Participant.create({ andrewid: 'mgarrett' }), is_booth_chair: true })
Membership.create({ organization: sigchi_org, participant: Participant.create({ andrewid: 'ahunt' }), is_booth_chair: true })
Membership.create({ organization: sigep_org, participant: Participant.create({ andrewid: 'bswalsh' }), is_booth_chair: true })
Membership.create({ organization: sigep_org, participant: Participant.create({ andrewid: 'jgualte' }), is_booth_chair: true })
Membership.create({ organization: ddd_org, participant: Participant.create({ andrewid: 'achoffma' }), is_booth_chair: true })
Membership.create({ organization: ddd_org, participant: Participant.create({ andrewid: 'jzois' }), is_booth_chair: true })
Membership.create({ organization: ddd_org, participant: Participant.create({ andrewid: 'anniez' }), is_booth_chair: true })
Membership.create({ organization: tsa_org, participant: Participant.create({ andrewid: 'jjlin' }), is_booth_chair: true })
Membership.create({ organization: tsa_org, participant: Participant.create({ andrewid: 'mlbaek' }), is_booth_chair: true })
Membership.create({ organization: tsa_org, participant: Participant.create({ andrewid: 'tchiang' }), is_booth_chair: true })


# Organization Status Types --------------------------------------------------
puts 'Organization Status Types'

OrganizationStatusType.create([
  { name: 'Authorized for Plan Deviation', display: false },
  { name: 'Structural Inspection', display: true },
  { name: 'First Floor Level', display: true },
  { name: 'First Floor Walls Approved', display: true },
  { name: 'Stairs Approved', display: true },
  { name: 'Second Floor Level', display: true },
  { name: 'Second Floor Walls Approved', display: true },
  { name: 'Roof Approved', display: true },
  { name: 'Electrical Inspection', display: true },
  { name: 'Electrical Approved', display: true },
  { name: 'Final Inspection Passed', display: true },
  { name: 'Teardown Plot Clean', display: true },
  { name: 'Note', display: false }
])


# Charge Types ----------------------------------------------------------------
puts 'Charge Types'

ChargeType.create([
  { name: 'Store Purchase' },
  { name: 'Watch Shift - Failure to comply', description: 'Watch Shift refused to follow the orders of the coordinator.', default_amount: 25 },
  { name: 'Watch Shift - Failure to remain', description: 'Watch Shift left before being dismissed by the coordinator. Fine per person.', default_amount: 25 },
  { name: 'Watch Shift - Late 1st time', description: 'Watch shift was less than 15 mins late for the 1st time. Fine per person', default_amount: 10 },
  { name: 'Watch Shift - Late 2nd time', description: 'Watch shift was less than 15 mins late for the 2nd time. Fine per person', default_amount: 20 },
  { name: 'Watch Shift - Late 3rd time', description: 'Watch shift was less than 15 mins late for the 3rd time. Fine per person', default_amount: 40 },
  { name: 'Watch Shift - Late 4th+ time', description: 'Watch shift was less than 15 mins late for the 4th or more time. Fine determined by Rules Committee.' },
  { name: 'Watch Shift - Missed 1st time', description: 'Watch shift was more than 15 minutes late for the 1st time. Fine per person. If they show up 15-45 mins late and complete their obligationsthe fine will be halved.', default_amount: 50 },
  { name: 'Watch Shift - Missed 2nd time', description: 'Watch shift was more than 15 minutes late for the 2nd time. Fine per person. If they show up 15-45 mins late and complete their obligationsthe fine will be halved.', default_amount: 100 },
  { name: 'Watch Shift - Missed 3rd+ time', description: 'Watch shift was more than 15 minutes late for the 3rd or more time.  Fine determined by Rules Committee.  If they show up 15-45 mins late and complete their obligationsthe fine will be halved.' },
  { name: 'Building - Impeding fire lane or spillover space', description: 'Impeding designated fire lanes or other organizations spill-over space.', default_amount: 25 },
  { name: 'Building - Spilled paint', description: 'Paint spilled on the parking lot while painting a booth..', default_amount: 50 },
  { name: 'Building - Missing hardhat, wristband, and/or safety glasses', description: 'Being on Midway without a wristband, hardhat, and/or safety glasses.', default_amount: 15 },
  { name: 'Building - Non-builders helping build', description: 'Non-builders helping with the construction of a booth.', default_amount: 15 },
  { name: 'Building - Quiet hours', description: 'Making noise during quiet hours that can be heard more than 20 feet from a booth.', default_amount: 25 },
  { name: 'Building - Failure to comply with SCC', description: 'Failure to comply with a request by SCC or Structural Oversight Committee to structurally alter a booth.', default_amount: 100 },
  { name: 'Building - Unauthorized plan deviation', description: 'Changing building or structural plans without approval. Fine to be determined by Rules Committee.', default_amount: 100 },
  { name: 'Electrical - Circuit breaker trip', description: 'Causing a circuit breaker to trip.', default_amount: 25 },
  { name: 'Electrical - Unauthorized electical connection', description: 'Connecting wiring to power that has not been approved.', default_amount: 100 },
  { name: 'Electrical - Unsafe electical condition', description: 'Taking actions resulting in an unsafe electrical condition.', default_amount: 200 },
  { name: 'Operations - Failure to clean plot', description: 'Failure to clean plot daily as directed by SCC.', default_amount: 25 },
  { name: 'Operations - Clean-up hours', description: 'Failure to supply 6 man-hours of work for overall cleanup prior to opening. Fine per man-hour.', default_amount: 50 },
  { name: 'Operations - On Midway when closed', description: 'Being on Midway without permission during the closed hours. Fine per person.', default_amount: 25 },
  { name: 'Operations - Unauthorized vehicle', description: 'In a vehicle on Midway without permission. Fine determined by Rules Committee', default_amount: 0 },
  { name: 'Staffing Booth - Intoxicated 1st time', description: 'Staffing a booth while intoxicated for the 1st time.', default_amount: 50 },
  { name: 'Staffing Booth - Intoxicated 2nd time', description: 'Staffing a booth while intoxicated for the 2nd time.', default_amount: 100 },
  { name: 'Staffing Booth - Intoxicated 3rd+ time', description: 'Staffing a booth while intoxicated for the 3rd or more time. Fine determined by Rules Committee.', default_amount: 100 },
  { name: 'Teardown - On Midway 5:00-5:30pm', description: 'Tearing down 5:00-5:30pm. Fine per minute.', default_amount: 1 },
  { name: 'Teardown - On Midway 5:30-6:00pm', description: 'Tearing down 5:30-6:00pm. Fine per minute.', default_amount: 5 },
  { name: 'Teardown - On Midway after 6:00pm', description: 'Tearing down after 6:00pm. Fine per minute.', default_amount: 10 },
  { name: 'Teardown - Vehicle assisted teardown', description: 'Using a vehicle to demolish a booth.', default_amount: 1000 },
  { name: 'Booth - Missed meeting', description: 'Failure to attend a regularly scheduled meeting. Fine per meeting.', default_amount: 25 },
  { name: 'Booth - Missed training', description: 'Failure to attend a training session. Fine per person per session', default_amount: 50 },
  { name: 'Booth - Missed deadline', description: 'Missing a deadline set by Booth Committee.  Fine per day.', default_amount: 5 },
  { name: 'Booth - Fine credit', description: 'Credit towards fines.'},
  { name: 'Other', description: 'Any other violation. Please document extensively and inform the Spring Carnival Chair.' }
])


# Event Types --------------------------------------------------
puts 'Event Types'

EventType.create([
  { name: 'Note', display: true },
  { name: 'Phone Call', display: false }
])


# FAQs ------------------------------------------------------------------------
puts 'FAQs'

Faq.create([
  { question: 'What if I don\'t know how to answer a question?',
    answer: 'Look at the FAQs on binder. Ask someone else in the trailer or contact someone on exec. Don\'t just make something up.' },
  { question: 'What should I bring to my coordinator shift?',
    answer: 'Your blue hard hat and SCC jacket, this will give you the position of authority. If you are acting as an SCC member on midway you must wear your SCC hard hat.' },
  { question: 'What is required to be on Midway?',
    answer: 'Hardhat, wristband, closed toed shoes, safety glasses (regular glasses are not enough).' },
  { question: 'What is the first thing I should do as a coordinator?',
    answer: 'Sign in on Binder. Ask the previous coordinator if there is anything you should be aware of.  Check to see if there are notes or upcoming tasks on Binder.' },
  { question: 'Can I leave midway during my coordinator shift?',
    answer: 'No, someone must be in the trailer at all times. If you have to leave, you must get an SCC member to cover while you are out.' },
  { question: 'Who is allowed in the trailer?',
    answer: 'Only SCC members are allowed in the trailer. No one else should be in the trailer without permission from an SCC member.' },
  { question: 'The next coordinator doesn\'t show up. What do I do?',
    answer: 'Call them repeatedly. If that fails, call the Carnival Chair.' },
  { question: 'The phone is rigning. What do I do? ',
    answer: 'Be polite and respectful. Answer their questions if you can, or tell them we will call them back with an answer. Log the phone call in Binder.' },
  { question: 'What are the different radio channels?',
    answer: 'Channel 1 is for the watch shifts. Channel 2 is for SCC.' },
  { question: 'I am having problems with the radio. What do I do?',
    answer: 'Check to make sure it is on and that the volume is high enough. Make sure that you are on Channel 2 and are not pressing down on the talk button. Press the button to talk and release when you are done to hear a response.' },
  { question: 'When do dumpsters need to be taken out?',
    answer: 'Dumpsters must be taken to entrance of the parking lot at the corner of Tech Street and Margaret Morrison before 2am.' },
  { question: 'What do the different wristbands mean?',
    answer: 'Red is Building, Blue is Non-Building, and Checkered is CFA access.' },
  { question: 'Someone wants a wristband, What do I do?',
    answer: 'Have them sign the waiver on binder, fill out what org they need it for, and give them the correct colored wristband.' },
  { question: 'What\'s the difference between a security and watch shift?',
    answer: 'Security is paid, watch is not. Watch shifts are booth orgs, while security are non-building orgs.' },
  { question: 'A watch shift just showed up to the trailer, what should I do?',
    answer: 'Sign in the shift members on Binder, hand them each jackets, and check out a radio to one of them. Briefly teach them how to use the radio and tell them to check in with you every 15 minutes. Review their responsibilities and have them look over the cheat sheet.' },
  { question: 'Booth watch shift doesn\'t show up. What do I do?',
    answer: 'Do not let previous watch shift leave. Call booth chairs of that org in order until someone answers. Fine them accordingly in Binder. If no one can show up and old watch shift has to leave, split the other watch shift.' },
  { question: 'What do I do with my drunk watch/security shift that just showed up?',
    answer: 'Send them home, call their booth chair, and inform them of what happened and that they are getting fined unless they supply new, sober people.' },
  { question: 'Drunk people won\'t listen. What do I do?',
    answer: 'Call the police.' },
  { question: 'What is Booth?',
    answer:  'Booth is one of the biggest traditions of Spring Carnival. Student organizations build multi-story structures around our annual theme , hosting interactive games and elaborate decorations. The booths will be located on the CFA Lot.' },
  { question: 'Booth chair is asking questions I don\'t understand. What do I do?',
    answer: 'Add them to the Structural queue.' },
  { question: 'A booth chair is freaking out, sad, angry, etc. What do I do?',
    answer: 'Call the Head of Booth.' },
  { question: 'What is downtime?',
    answer: 'When a booth takes time to close their booth and have it not manned during Carnival. They must register the start of their downtime (you should track this) and put caution tape up to close off the doorways. They should also tell you when they are ending their downtime.' },
  { question: 'How much downtime does an org get?',
    answer: '4 hours.' },
  { question: 'How do I check how much downtime an org has left?',
    answer: 'Remaining downtime is shown in Binder' },
  { question: 'A booth tripped a breaker. What do I do?',
    answer: 'Add them to the Electrical queue. Mark the fine in Binder if applicable.' },
  { question: 'Someone has a minor injury (splinter, small cut, dust in eye, etc.).',
    answer: 'Give them equipment from the medical kit in the trailer. Tell them they can call EMS if they want. DO NOT ADMINISTER MEDICAL ASSISTANCE.' },
  { question: 'EMS is closed. What do I do?',
    answer: 'Call them.' },
  { question: 'I saw an ambulance take someone to the hospital. What do I do?',
    answer: 'Call the Carnival Chair, Head of Booth, and/or Head of Operations immediately.' },
  { question: 'Golf cart problem?',
    answer: 'Call Meg Richards.' },
  { question: 'University official wants to borrow something. What do I do?',
    answer: 'Let them. They do not need to sign a waiver. Check it out to the Carnival Chair in Binder.' },
  { question: 'Madelyn Miller calls. What do I do?',
    answer: 'Listen to her. Then call the Head of Booth and relay the message.' },
  { question: 'Alumni needs something.',
    answer: 'Call the Head of Operations or Head of Marketing.' },
  { question: 'Taylor Rental or TriBoro Trailer needs something.',
    answer: 'Call the Head of Operations.' },
  { question: 'What do I do if something catches on fire?',
    answer: 'There are fire extinguishers located at every booth. Take one and follow the instructions listed on the can.' },
  { question: 'It\'s raining and people are losing electricity.',
    answer: 'Tell them to wait until the rain stops, then we will deal with it.' },
  { question: 'It\'s super windy. Things are flying off of booths.',
    answer: 'Check weather on trailer computer. Call the Carnival Chair and Head of Booth with that information.' },
  { question: 'What are the hours of booths?',
    answer: 'Thursday: 3PM-10PM, Friday: 11AM-10PM, Saturday: 11AM-10PM' },
  { question: 'What are the hours of rides?',
    answer: 'Thursday: 3PM-11PM, Friday: 10AM-11PM, Saturday: 10AM-11PM' },
  { question: 'How much are rides tickets?',
    answer: '$1 per ride or $20 for 24 rides. Tickets are available at the ticket booth located on Midway.' },
  { question: 'Are there group rates for rides tickets?',
    answer: 'No.' },
  { question: 'Can I get a wristband for the comedian?',
    answer: 'Spring Carnival does not deal with the comedian. Talk to AB Comedy.' },
  { question: 'Can I get a wristband for the concert?',
    answer: 'Spring Carnival does not deal with the concert. Talk to AB Concerts.' },
  { question: 'Where does CMU get money for Carnival?',
    answer: 'Carnegie Mellon University\'s Spring Carnival is funded in part by your Student Activities Fee.' }
])


# Tasks ------------------------------------------------------------------------
puts 'Tasks'

move_on = DateTime.rfc3339('2017-04-14T00:00:00-04:00')
saturday = move_on + 1.day
sunday = move_on + 2.days
monday = move_on + 3.days
tuesday = move_on + 4.days
wednesday = move_on + 5.days
carnival_thursday = move_on + 6.days
carnival_friday = move_on + 7.days
carnival_saturday = move_on + 8.days
teardown = move_on + 9.days

start_date = move_on + 16.hours
end_date = teardown + 20.hours

puts '  One-Time Tasks'
Task.create([
  { name: 'Move On Begins', description: 'Orgs start moving on to Midway.', due_at: move_on + 18.hours },
  { name: 'Construction Begins', description: 'Orgs may begin building their booth.', due_at: move_on + 21.hours },
  { name: 'Blitz Booth Move On Begins', description: 'Blitz orgs move on to Midway.', due_at: saturday + 10.hours },
  { name: 'Final Booth Inspections', description: 'University staff will arrive on Midway. Direct them to the Head of Booth so they can inspect the booths.', due_at: wednesday + 12.hours },
  { name: 'Construction Ends', description: 'All but 4 members (full-size) or 2 members (blitz) of each org must clear Midway.', due_at: carnival_thursday + 1.hours },
  { name: 'Cleanup Begins', description: 'Each org must send 2 members to the trailer to assist with Midway cleanup.', due_at: carnival_thursday + 1.hours },
  { name: 'Final Fixes Ends', description: 'All members of each org must clear Midway', due_at: carnival_thursday + 14.hours },
  { name: 'Opening Ceremony', description: 'Speeches, ribbon cutting, and Midway officially opens to the public.', due_at: carnival_thursday + 15.hours },
  { name: 'Judging Begins', description: 'Judges will arrive on Midway. Direct them to the Carnival Chair or Head of Booth so they can begin judging.', due_at: carnival_friday + 13.hours },
  { name: 'Night Judging Begins', description: 'Alumni judges will arrive on Midway. Direct them to the Carnival Chair or Head of Booth so they can begin judging.', due_at: carnival_friday + 20.hours },
  { name: 'Awards Ceremony', description: 'Orgs may take close their booths without taking downtime for the Awards Ceremony.', due_at: carnival_saturday + 16.hours + 30.minutes },
  { name: 'Teardown Begins', description: 'Orgs may begin to teardown.', due_at: teardown + 8.hours },
  { name: 'Teardown Required Start', description: 'All orgs must have begun to teardown.', due_at: teardown + 10.hours },
  { name: 'Teardown Ends', description: 'All orgs should have completely cleared Midway. If they have not, note when they finish so we can determine fines.', due_at: teardown + 5.hours }
])

puts '  Recurring Tasks'
 Task.create([
  { name: 'Quiet Hours Start', description: 'No loud noise on Midway. If you can hear something outside a booth it is too loud.', due_at: move_on + 22.hours },
  { name: 'Quiet Hours Start', description: 'No loud noise on Midway. If you can hear something outside a booth it is too loud.', due_at: saturday + 22.hours },
  { name: 'Quiet Hours Start', description: 'No loud noise on Midway. If you can hear something outside a booth it is too loud.', due_at: sunday + 22.hours },
  { name: 'Quiet Hours Start', description: 'No loud noise on Midway. If you can hear something outside a booth it is too loud.', due_at: monday + 22.hours },
  { name: 'Quiet Hours Start', description: 'No loud noise on Midway. If you can hear something outside a booth it is too loud.', due_at: tuesday + 22.hours },
  { name: 'Quiet Hours Start', description: 'No loud noise on Midway. If you can hear something outside a booth it is too loud.', due_at: wednesday + 22.hours },
  { name: 'Quiet Hours End', description: 'Noise is allowed on Midway.  Loud music that you can hear outside a booth are not allowed.', due_at: saturday + 7.hours },
  { name: 'Quiet Hours End', description: 'Noise is allowed on Midway.  Loud music that you can hear outside a booth are not allowed.', due_at: sunday + 7.hours },
  { name: 'Quiet Hours End', description: 'Noise is allowed on Midway.  Loud music that you can hear outside a booth are not allowed.', due_at: monday + 7.hours },
  { name: 'Quiet Hours End', description: 'Noise is allowed on Midway.  Loud music that you can hear outside a booth are not allowed.', due_at: tuesday + 7.hours },
  { name: 'Quiet Hours End', description: 'Noise is allowed on Midway.  Loud music that you can hear outside a booth are not allowed.', due_at: wednesday + 7.hours },
  { name: 'Quiet Hours End', description: 'Noise is allowed on Midway.', due_at: carnival_thursday + 7.hours },
  { name: 'No Loud Music Allowed', description: 'Loud music is allowed on Midway.', due_at: monday + 8.hours },
  { name: 'No Loud Music Allowed', description: 'Loud music is allowed on Midway.', due_at: tuesday + 8.hours },
  { name: 'No Loud Music Allowed', description: 'Loud music is allowed on Midway.', due_at: wednesday + 8.hours },
  { name: 'Loud Music Allowed', description: 'Loud music is allowed on Midway.', due_at: monday + 18.hours },
  { name: 'Loud Music Allowed', description: 'Loud music is allowed on Midway.', due_at: tuesday + 18.hours },
  { name: 'Loud Music Allowed', description: 'Loud music is allowed on Midway.', due_at: wednesday + 18.hours },
  { name: 'Move Dumpsters', description: 'Have a watch shift move dumpsters to the entrance of the parking lot by corner of Tech St. and Margaret Morrison St.', due_at: saturday + 1.hours },
  { name: 'Move Dumpsters', description: 'Have a watch shift move dumpsters to the entrance of the parking lot by corner of Tech St. and Margaret Morrison St.', due_at: sunday + 1.hours },
  { name: 'Move Dumpsters', description: 'Have a watch shift move dumpsters to the entrance of the parking lot by corner of Tech St. and Margaret Morrison St.', due_at: monday + 1.hours },
  { name: 'Move Dumpsters', description: 'Have a watch shift move dumpsters to the entrance of the parking lot by corner of Tech St. and Margaret Morrison St.', due_at: tuesday + 1.hours },
  { name: 'Move Dumpsters', description: 'Have a watch shift move dumpsters to the entrance of the parking lot by corner of Tech St. and Margaret Morrison St.', due_at: wednesday + 1.hours },
  { name: 'Move Dumpsters', description: 'Have a watch shift move dumpsters to the entrance of the parking lot by corner of Tech St. and Margaret Morrison St.', due_at: carnival_thursday + 1.hours },
  { name: 'Move Dumpsters', description: 'Have a watch shift move dumpsters to the entrance of the parking lot by corner of Tech St. and Margaret Morrison St.', due_at: carnival_friday + 1.hours },
  { name: 'Move Dumpsters', description: 'Have a watch shift move dumpsters to the entrance of the parking lot by corner of Tech St. and Margaret Morrison St.', due_at: carnival_saturday + 1.hours },
  { name: 'Midway Opens', description: 'Each org must have 2 members staffing their booth.', due_at: carnival_thursday + 15.hours },
  { name: 'Midway Closes', description: 'Everyone must clear Midway.', due_at: carnival_thursday + 22.hours },
  { name: 'Midway Opens', description: 'Each org must have 2 members staffing their booth.', due_at: carnival_friday + 11.hours },
  { name: 'Midway Closes', description: 'Everyone must clear Midway.', due_at: carnival_friday + 22.hours },
  { name: 'Midway Opens', description: 'Each org must have 2 members staffing their booth.', due_at: carnival_saturday + 11.hours },
  { name: 'Midway Closes', description: 'Everyone must clear Midway.', due_at: carnival_saturday + 22.hours }
 ])


# Shifts ---------------------------------------------------------------------
puts 'Shifts'

WATCH_SHIFTS = [
  'DTD',
  'Math',
  'DG',
  'DTD',
  'PhiDelt',
  'AEPi',
  'SigEp',
  'Theta',
  'KGB',
  'Theta',
  'APhiO',
  'AlphaSig',
  'APhiO',
  'Theta',
  'DTD',
  'KapSig',
  'Fringe',
  'AXO',
  'CSA',
  'Theta',
  'DG',
  'Theta',
  'DG',
  'AlphaSig',
  'Theta',
  'TSA',
  'ASA',
  'SDC',
  'SigmaChi',
  'AKPsi',
  'CivE',
  'PhiDelt',
  'AEPi',
  'DG',
  'SigEp',
  'TSA',
  'KGB',
  'DTD',
  'ASA',
  'AlphaPhi',
  'Fringe',
  'AXO',
  'PhiDelt',
  'Astro',
  'AEPi',
  'Astro',
  'SigEp',
  'ASA',
  'TSA',
  'Astro',
  'APhiO',
  'CSA',
  'SigmaChi',
  'AKPsi',
  'CivE',
  'PhiDelt',
  'AEPi',
  'KapSig',
  'AlphaSig',
  'TSA',
  'APhiO',
  'SigEp',
  'AlphaSig',
  'KGB',
  'Fringe',
  'AXO',
  'PhiDelt',
  'AEPi',
  'SDC',
  'TriDelt',
  'APhiO',
  'TriDelt',
  'TSA',
  'Astro',
  'AlphaPhi',
  'KKG',
  'CSA',
  'AKPsi',
  'CivE',
  'AlphaSig',
  'Math',
  'DG',
  'TriDelt',
  'Math',
  'APhiO',
  'Math',
  'PhiDelt',
  'KKG',
  'AEPi',
  'KGB',
  'Fringe',
  'AXO',
  'Theta',
  'DG',
  'CivE',
  'TriDelt',
  'KapSig',
  'PhiDelt',
  'AEPi',
  'AlphaPhi',
  'ASA',
  'SigEp',
  'KGB',
  'Fringe',
  'DTD',
  'DG',
  'SigmaChi',
  'KKG',
  'DTD'
]

COORDINATOR_SHIFTS = [
  'Zilei Gu',
  'Meg Richards',
  'Meg Richards',
  'Alex Gotsis',
  'Annie Yang',
  'Zhuri Solan',
  'Jeremy Zhang',
  'Josh Zak',
  'Samantha Wu',
  'Lauren Miller',
  'Renata Yerzhanova',
  'Thomas Ford',
  'Allison Whyte',
  'Claire Chen',
  'Emily Newman',
  'Stephen Clark',
  'Noah Hull',
  'John Puyn',
  'Maskana Adedjouman',
  'Laura Bressler',
  'William Lowe',
  'Hannah Koschmeder',
  'Josh Zak',
  'Dillon Lareau',
  'Josh Zak',
  'Kayla Quinn',
  'Margaret Reager',
  'Lawrence Xu',
  'Gabrielle Rickstrew',
  'John Pyun',
  'Meg Richards',
  'Caroline Morin',
  'Julien Sat-Vollhardt',
  'Samantha Wu',
  'Meg Richards',
  'Zlei Gu',
  'Laura Bressler',
  'Lauren Miller',
  'Allison Whyte',
  'William Lowe',
  'Renata Yerzhanova',
  'Nicholas Coauette',
  'Mike Vultaggio',
  'Annie Yang',
  'Jeremy Zhang',
  'Julien Sat-Vollhardt',
  'Noah Hull',
  'Thomas Ford',
  'Jarrett Liang',
  'Cliare Chen',
  'Jarrett Liang',
  'Stephen Clark',
  'Josh Zak',
  'Brandon Jin',
  'Stacy Chang'
]

SPECIAL_WATCH_SHIFTS = [
  { org: 'DTD',      starts_at: saturday + 21.hours },
  { org: 'KapSig',   starts_at: saturday + 23.hours },
  { org: 'ASA',      starts_at: sunday + 21.hours },
  { org: 'SDC',      starts_at: sunday + 23.hours },
  { org: 'ASA',      starts_at: monday + 21.hours },
  { org: 'AlphaPhi', starts_at: monday + 21.hours },
  { org: 'SDC',      starts_at: carnival_thursday + 9.hours },
  { org: 'TriDelt',  starts_at: carnival_thursday + 11.hours },
  { org: 'KKG',      starts_at: carnival_thursday + 13.hours },
  { org: 'SigEp',    starts_at: carnival_thursday + 15.hours },
  { org: 'KKG',      starts_at: carnival_thursday + 23.hours },
  { org: 'SigmaChi', starts_at: carnival_friday + 1.hours },
  { org: 'KKG',      starts_at: carnival_friday + 23.hours },
  { org: 'SigEp',    starts_at: carnival_saturday + 1.hours },
  { org: 'AlphaPhi', starts_at: carnival_saturday + 23.hours },
  { org: 'ASA',      starts_at: teardown + 1.hours },
  { org: 'AXO',      starts_at: teardown + 9.hours },
  { org: 'CSA',      starts_at: teardown + 11.hours },
  { org: 'AKPsi',    starts_at: teardown + 13.hours },
  { org: 'KKG',      starts_at: teardown + 15.hours }
]

SECURITY_SHIFTS = [
  { org: 'Originals', starts_at: move_on + 21.hours,           desc: '' },
  { org: 'ChemE Car', starts_at: move_on + 21.hours,           desc: '' },
  { org: 'Originals', starts_at: saturday + 10.hours,          desc: '' },
  { org: 'Originals', starts_at: saturday + 12.hours,          desc: '' },
  { org: 'Rowing',    starts_at: saturday + 21.hours,          desc: '' },
  { org: 'Moot',      starts_at: sunday + 21.hours,            desc: '' },
  { org: 'Originals', starts_at: monday + 21.hours,            desc: '' },
  { org: 'SCC',       starts_at: tuesday + 9.hours,            desc: '' },
  { org: 'Originals', starts_at: tuesday + 9.hours,            desc: '' },
  { org: 'Originals', starts_at: tuesday + 9.hours,            desc: '' },
  { org: 'Quidditch', starts_at: tuesday + 9.hours,            desc: '' },
  { org: 'Rowing',    starts_at: tuesday + 9.hours,            desc: '' },
  { org: 'Rowing',    starts_at: tuesday + 9.hours,            desc: '' },
  { org: 'SCC',       starts_at: tuesday + 11.hours,           desc: '' },
  { org: 'SCC',       starts_at: tuesday + 11.hours,           desc: '' },
  { org: 'SCC',       starts_at: tuesday + 11.hours,           desc: '' },
  { org: 'Originals', starts_at: tuesday + 11.hours,           desc: '' },
  { org: 'Originals', starts_at: tuesday + 11.hours,           desc: '' },
  { org: 'Rowing',    starts_at: tuesday + 11.hours,           desc: '' },
  { org: 'SCC',       starts_at: tuesday + 13.hours,           desc: '' },
  { org: 'ChemE Car', starts_at: tuesday + 13.hours,           desc: '' },
  { org: 'Rowing',    starts_at: tuesday + 13.hours,           desc: '' },
  { org: 'Originals', starts_at: tuesday + 15.hours,           desc: '' },
  { org: 'Originals', starts_at: tuesday + 15.hours,           desc: '' },
  { org: 'Originals', starts_at: tuesday + 15.hours,           desc: '' },
  { org: 'ChemE Car', starts_at: tuesday + 21.hours,           desc: '' },
  { org: 'Juntos',    starts_at: wednesday + 21.hours,         desc: '' },
  { org: 'Rowing',    starts_at: carnival_thursday + 11.hours, desc: '' },
  { org: 'Rowing',    starts_at: carnival_thursday + 11.hours, desc: '' },
  { org: 'Rowing',    starts_at: carnival_thursday + 11.hours, desc: '' },
  { org: 'Juntos',    starts_at: carnival_thursday + 11.hours, desc: '' },
  { org: 'Juntos',    starts_at: carnival_thursday + 13.hours, desc: '' },
  { org: 'Rowing',    starts_at: carnival_thursday + 13.hours, desc: '' },
  { org: 'Rowing',    starts_at: carnival_thursday + 13.hours, desc: '' },
  { org: 'Moot',      starts_at: carnival_thursday + 13.hours, desc: '' },
  { org: 'Moot',      starts_at: carnival_thursday + 15.hours, desc: '' },
  { org: 'Juntos',    starts_at: carnival_thursday + 17.hours, desc: '' },
  { org: 'Rowing',    starts_at: carnival_thursday + 17.hours, desc: '' },
  { org: 'Juntos',    starts_at: carnival_thursday + 19.hours, desc: '' },
  { org: 'SCC',       starts_at: carnival_thursday + 19.hours, desc: '' },
  { org: 'SCC',       starts_at: carnival_thursday + 21.hours, desc: '' },
  { org: 'SCC',       starts_at: carnival_friday + 9.hours,    desc: '' },
  { org: 'SCC',       starts_at: carnival_friday + 11.hours,   desc: '' },
  { org: 'SCC',       starts_at: carnival_friday + 13.hours,   desc: '' },
  { org: 'Juntos',    starts_at: carnival_friday + 15.hours,   desc: '' },
  { org: 'ChemE Car', starts_at: carnival_friday + 17.hours,   desc: '' },
  { org: 'SCC',       starts_at: carnival_friday + 19.hours,   desc: '' },
  { org: 'ChemE Car', starts_at: carnival_friday + 19.hours,   desc: '' },
  { org: 'SCC',       starts_at: carnival_friday + 21.hours,   desc: '' },
  { org: 'SCC',       starts_at: carnival_friday + 21.hours,   desc: '' },
  { org: 'Juntos',    starts_at: carnival_saturday + 9.hours,  desc: '' },
  { org: 'SCC',       starts_at: carnival_saturday + 11.hours, desc: '' },
  { org: 'SCC',       starts_at: carnival_saturday + 13.hours, desc: '' },
  { org: 'SCC',       starts_at: carnival_saturday + 13.hours, desc: '' },
  { org: 'Juntos',    starts_at: carnival_saturday + 13.hours, desc: '' },
  { org: 'SCC',       starts_at: carnival_saturday + 15.hours, desc: '' },
  { org: 'SCC',       starts_at: carnival_saturday + 15.hours, desc: '' },
  { org: 'ChemE Car', starts_at: carnival_saturday + 15.hours, desc: '' },
  { org: 'SCC',       starts_at: carnival_saturday + 17.hours, desc: '' },
  { org: 'SCC',       starts_at: carnival_saturday + 17.hours, desc: '' },
  { org: 'SCC',       starts_at: carnival_saturday + 19.hours, desc: '' },
  { org: 'SCC',       starts_at: carnival_saturday + 19.hours, desc: '' },
  { org: 'SCC',       starts_at: carnival_saturday + 21.hours, desc: '' },
  { org: 'SCC',       starts_at: carnival_saturday + 21.hours, desc: '' },
  { org: 'Quidditch', starts_at: carnival_saturday + 22.hours, desc: '' },
  { org: 'ChemE Car', starts_at: carnival_saturday + 22.hours, desc: '' },
  { org: 'SCC',       starts_at: carnival_saturday + 22.hours, desc: '' },
  { org: 'SCC',       starts_at: carnival_saturday + 22.hours, desc: '' },
  { org: 'SCC',       starts_at: carnival_saturday + 22.hours, desc: '' },
  { org: 'SCC',       starts_at: teardown + 0.hours,           desc: '' },
  { org: 'SCC',       starts_at: teardown + 0.hours,           desc: '' },
  { org: 'SCC',       starts_at: teardown + 0.hours,           desc: '' },
  { org: 'SCC',       starts_at: teardown + 0.hours,           desc: '' },
  { org: 'SCC',       starts_at: teardown + 0.hours,           desc: '' },
  { org: 'Originals', starts_at: teardown + 10.hours,          desc: '' },
  { org: 'Originals', starts_at: teardown + 12.hours,          desc: '' },
  { org: 'ChemE Car', starts_at: teardown + 12.hours,          desc: '' },
  { org: 'ChemE Car', starts_at: teardown + 14.hours,          desc: '' },
  { org: 'SCC',       starts_at: teardown + 14.hours,          desc: '' }
]

watch_shift = ShiftType.create({ name: 'Watch Shift' })
security_shift = ShiftType.create({ name: 'Security Shift' })
coordinator_shift = ShiftType.create({ name: 'Coordinator Shift' })

SPECIAL_WATCH_SHIFTS.each { |shift| Shift.create({ shift_type: watch_shift, organization: Organization.find_by_short_name(shift[:org]), starts_at: shift[:starts_at], ends_at: shift[:starts_at] + 2.hours, required_number_of_participants: 2 }) }
WATCH_SHIFTS.each_with_index do |org, i|
  starts_at = move_on + 17.hours + (i * 4.hours)
  Shift.create({ shift_type: watch_shift, organization: Organization.find_by_short_name(org), starts_at: starts_at, ends_at: starts_at + 2.hours, required_number_of_participants: 2 })
end

SECURITY_SHIFTS.each { |shift| Shift.create({ shift_type: security_shift, description: shift[:desc], organization: Organization.find_by_short_name(shift[:org]), starts_at: shift[:starts_at], ends_at: shift[:starts_at] + 2.hours, required_number_of_participants: 2 }) }

COORDINATOR_SHIFTS.each_with_index do |andrewid, i|
  starts_at = move_on + 16.hours + (i * 4.hours)
  ShiftParticipant.create({
    shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: starts_at, ends_at: starts_at + 4.hours, required_number_of_participants: 1 }),
    participant: Participant.find_by_andrewid(andrewid),
    clocked_in_at: starts_at
  })
end


# Tools -------------------------------------------------------------------------
puts 'Tools'

generate_tools


# Store -------------------------------------------------------------------------
puts 'Store'

StoreItem.create({ name: '9 Volt Battery', price: 1, quantity: 1000})
StoreItem.create({ name: 'Drill Bit', price: 1, quantity: 1000})
StoreItem.create({ name: 'Drop Cloth', price: 2, quantity: 1000})
StoreItem.create({ name: 'Electrical Box - 1 Gang', price: 1, quantity: 1000})
StoreItem.create({ name: 'Electrical Box - 2 Gang', price: 1, quantity: 1000})
StoreItem.create({ name: 'Electrical Box - 4 in Round', price: 3, quantity: 1000})
StoreItem.create({ name: 'Electrical Box - 4 in Square', price: 3, quantity: 1000})
StoreItem.create({ name: 'Electrical Box Cover - 4 in Round', price: 2, quantity: 1000})
StoreItem.create({ name: 'Electrical Box Cover - 4 in Square', price: 2, quantity: 1000})
StoreItem.create({ name: 'Joist Hander - 2x6', price: 2, quantity: 1000})
StoreItem.create({ name: 'Joist Hander - 2x8', price: 2, quantity: 1000})
StoreItem.create({ name: 'Light Switch', price: 3, quantity: 1000})
StoreItem.create({ name: 'Light Switch Cover', price: 1, quantity: 1000})
StoreItem.create({ name: 'Outlet', price: 3, quantity: 1000})
StoreItem.create({ name: 'Outlet Cover - 1 Gang', price: 1, quantity: 1000})
StoreItem.create({ name: 'Outlet Cover - 2 Gang', price: 1, quantity: 1000})
StoreItem.create({ name: 'Plug - Angle', price: 12, quantity: 1000})
StoreItem.create({ name: 'Plug - Straight', price: 12, quantity: 1000})
StoreItem.create({ name: 'Romex 12/2 - 10ft', price: 5, quantity: 1000})
StoreItem.create({ name: 'Screw Bit - Phillips (x2)', price: 1, quantity: 1000})
StoreItem.create({ name: 'Screws (x10)', price: 1, quantity: 1000})
StoreItem.create({ name: 'Spade Bit - 3/4"', price: 5, quantity: 1000})
StoreItem.create({ name: 'Staple Gun Staples (x4 Rows)', price: 1, quantity: 1000})
StoreItem.create({ name: 'Tarp', price: 15, quantity: 1000})
StoreItem.create({ name: 'Wire Nuts (x10)', price: 1, quantity: 1000})
StoreItem.create({ name: 'Wire Staples (x20)', price: 1, quantity: 1000})

if  Rails.env.development?
  # Development Stuff -----------------------------------------------------------
  puts 'Development Stuff'

  admin_andrewid = 'rcrown'
  scc_andrewid = 'cbrownel'
  booth_chair_andrewid = 'rpwhite'
  participant_andrewid = 'nharper'

  admin_user = User.create({ email: "#{admin_andrewid}@andrew.cmu.edu"})
  admin_user.add_role :admin
  admin = Participant.create({ andrewid: admin_andrewid, user: admin_user })
  Membership.create({ organization: scc_org, participant: admin, title: 'Admin', is_booth_chair: true })

  scc_user = User.create({ email: "#{scc_andrewid}@andrew.cmu.edu"})
  scc = Participant.create({ andrewid: scc_andrewid, user: scc_user })
  Membership.create({ organization: scc_org, participant: scc })

  booth_chair_user = User.create({ email: "#{booth_chair_andrewid}@andrew.cmu.edu"})
  booth_chair = Participant.create({ andrewid: booth_chair_andrewid, user: booth_chair_user })
  Membership.create({ organization: dtd_org, participant: booth_chair, is_booth_chair: true })

  participant_user = User.create({ email: "#{participant_andrewid}@andrew.cmu.edu"})
  participant = Participant.create({ andrewid: participant_andrewid, user: participant_user })
  Membership.create({ organization: dtd_org, participant: participant })
end
