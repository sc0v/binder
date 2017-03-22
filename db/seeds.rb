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
fms_org = Organization.create({ name: 'Facilities Management Services', organization_category: staff, short_name: 'FMS' })
sa_org = Organization.create({ name: 'Student Affairs', organization_category: staff, short_name: 'DOSA' })
  OrganizationAlias.create({ organization: sa_org, name: 'Division of Student Affairs' })
  OrganizationAlias.create({ organization: sa_org, name: 'Student Activities' })
  OrganizationAlias.create({ organization: sa_org, name: 'Student Life' })

puts '  Consessions'
aphio_org = Organization.create({ name: 'Alpha Phi Omega', organization_category: concessions, short_name: 'APhiO' })

puts '  Fraternity'
aepi_org = Organization.create({ name: 'Alpha Epsilon Pi', organization_category: fraternity, short_name: 'AEPi' })
asig_org = Organization.create({ name: 'Alpha Sigma Phi', organization_category: fraternity, short_name: 'Alpha Sig' })
dtd_org = Organization.create({ name: 'Delta Tau Delta', organization_category: fraternity, short_name: 'DTD' })
  OrganizationAlias.create({ organization: dtd_org, name: 'Delt' })
kapsig_org = Organization.create({ name: 'Kappa Sigma', organization_category: fraternity, short_name: 'KapSig' })
phidelt_org = Organization.create({ name: 'Phi Delta Theta', organization_category: fraternity, short_name: 'Phi Delt' })
sae_org = Organization.create({ name: 'Sigma Alpha Epsilon', organization_category: fraternity, short_name: 'SAE' })
sigep_org = Organization.create({ name: 'Sigma Phi Epsilon', organization_category: fraternity, short_name: 'SigEp' })

puts '  Sorority'
aphi_org = Organization.create({ name: 'Alpha Phi', organization_category: sorority })
  OrganizationAlias.create({ organization: aphi_org, name: 'APhi' })
axo_org = Organization.create({ name: 'Alpha Chi Omega', organization_category: sorority, short_name: 'AXO' })
  OrganizationAlias.create({ organization: axo_org, name: 'Alpha Chi' })
ddd_org = Organization.create({ name: 'Delta Delta Delta', organization_category: sorority, short_name: 'Tri Delt' })
  OrganizationAlias.create({ organization: ddd_org, name: 'DDD' })
dg_org = Organization.create({ name: 'Delta Gamma', organization_category: sorority, short_name: 'DG' })
kat_org = Organization.create({ name: 'Kappa Alpha Theta', organization_category: sorority, short_name: 'Theta' })
  OrganizationAlias.create({ organization: kat_org, name: 'KAT' })
kkg_org = Organization.create({ name: 'Kappa Kappa Gamma', organization_category: sorority, short_name: 'Kappa' })
  OrganizationAlias.create({ organization: kkg_org, name: 'KKG' })

puts '  Independent'
asa_org = Organization.create({ name: 'Asian Students Association', organization_category: independent, short_name: 'ASA' })
fringe_org = Organization.create({ name: 'Fringe', organization_category: independent })
kgb_org = Organization.create({ name: 'KGB', organization_category: independent, short_name: 'KGB' })
tsa_org = Organization.create({ name: 'Taiwanese Students Association', organization_category: independent, short_name: 'TSA' })

puts '  Blitz'
astro_org = Organization.create({ name: 'Astronomy Club', organization_category: blitz, short_name: 'Astro' })
math_org = Organization.create({ name: 'Math Club', organization_category: blitz, short_name: 'Math' })
mayur_org = Organization.create({ name: 'Mayur SASA', organization_category: blitz, short_name: 'Mayur' })
mcs_org = Organization.create({ name: 'Mellon College of Science', organization_category: blitz, short_name: 'MCS' })
sdc_org = Organization.create({ name: 'Student Dormitory Council', organization_category: blitz, short_name: 'SDC' })
sigchi_org = Organization.create({ name: 'Sigma Chi', organization_category: blitz, short_name: 'SigChi' })
  OrganizationAlias.create({ organization: sigchi_org, name: 'SX' })
spirit_org = Organization.create({ name: 'Spirit', organization_category: blitz })

puts '  Non-Building'
ems_org = Organization.create({ name: 'Emergency Medical Service', organization_category: non_building, short_name: 'EMS' })
habitat_org = Organization.create({ name: 'Habitat for Humanity', organization_category: non_building, short_name: 'Habitat' })
juntos_org = Organization.create({ name: 'Juntos', organization_category: non_building })
quidditch_org = Organization.create({ name: 'Quidditch Club', organization_category: non_building, short_name: 'Quidditch' })
rowing_org = Organization.create({ name: 'Rowing Club', organization_category: non_building, short_name: 'Rowing' })
  OrganizationAlias.create({ organization: rowing_org, name: 'Crew' })
rowing_org = Organization.create({ name: 'Student Senate', organization_category: non_building, short_name: 'Senate' })
originals_org = Organization.create({ name: 'The Originals', organization_category: non_building })
treblemakers_org = Organization.create({ name: 'The Treblemakers', organization_category: non_building })

# Cell phone carriers ---------------------------------------------------------
puts 'Phone Carriers'

['Verizon Wireless','Sprint','AT&T','T-Mobile','Metro PCS','US Cellular','Cricket','Virgin Mobile','Boost Mobile'].each do |name|
  PhoneCarrier.create({ name: name})
end

# SCC Members -----------------------------------------------------------------
puts 'SCC Members'

chair_andrewid = 'phkoenig'
treasurer_andrewid = 'arakla'
head_booth_andrewid = 'rwolfing'
advisor_andrewid = 'asgreen'
meg_andrewid = 'meribyte'

chair_user = User.create({ email: "#{chair_andrewid}@andrew.cmu.edu"})
chair_user.add_role :admin
chair = Participant.create({ andrewid: chair_andrewid, user: chair_user })
Membership.create({ organization: scc_org, participant: chair, title: 'Carnival Chair', is_booth_chair: true })

treasurer_user = User.create({ email: "#{treasurer_andrewid}@andrew.cmu.edu"})
treasurer_user.add_role :admin
treasurer = Participant.create({ andrewid: treasurer_andrewid, user: treasurer_user })
Membership.create({ organization: scc_org, participant: treasurer, title: 'Treasurer', is_booth_chair: true })

head_booth_user = User.create({ email: "#{head_booth_andrewid}@andrew.cmu.edu"})
head_booth_user.add_role :admin
head_booth = Participant.create({ andrewid: head_booth_andrewid, user: head_booth_user })
Membership.create({ organization: scc_org, participant: head_booth, title: 'Head of Booth', is_booth_chair: true })

advisor_user = User.create({ email: "#{advisor_andrewid}@andrew.cmu.edu"})
advisor_user.add_role :admin
advisor = Participant.create({ andrewid: advisor_andrewid, user: advisor_user })
Membership.create({ organization: scc_org, participant: advisor, title: 'Advisor', is_booth_chair: true })
Membership.create({ organization: sa_org, participant: advisor, title: 'Spring Carnival Advisor', is_booth_chair: true })

meg_user = User.new({email: "#{meg_andrewid}@andrew.cmu.edu" })
meg_user.add_role :admin
meg = Participant.create({ andrewid: meg_andrewid })
Membership.create({ organization: scc_org, participant: meg })

Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'aborie' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'afmeyer' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'agotsis' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'agurvich' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'amartine' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'amoran' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'bbzhang' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'bhunttob' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'cbanuelo' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'chenhaoy' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'clohman' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'cmorin' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'cssmith' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'dmiele' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'egarbade' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'hkoschme' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'jcmertz' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'jcp' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'jiyunkwo' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'jlareau' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'jwesson' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'jzak' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'lawrencx' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'mreager' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'msingal' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'ncoauett' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'nehull' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'nhoran' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'nkawakam' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'prheinhe' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'rahsan' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'saclark' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'sasikalm' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'sromero' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'tan' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'tmedirat' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'yuanyua1' }) })
Membership.create({ organization: scc_org, participant: Participant.create({ andrewid: 'zileig' }) })

# Booth Chairs ----------------------------------------------------------------
puts 'Booth Chairs'

Membership.create({ organization: aepi_org, participant: Participant.create({ andrewid: 'enumbers'}), is_booth_chair: true })
Membership.create({ organization: aepi_org, participant: Participant.create({ andrewid: 'ihaberma'}), is_booth_chair: true })
Membership.create({ organization: aepi_org, participant: Participant.create({ andrewid: 'kjhernan'}), is_booth_chair: true })
Membership.create({ organization: aphi_org, participant: Participant.create({ andrewid: 'arutt'}), is_booth_chair: true })
Membership.create({ organization: aphi_org, participant: Participant.create({ andrewid: 'caseywon'}), is_booth_chair: true })
Membership.create({ organization: aphi_org, participant: Participant.create({ andrewid: 'khofmann'}), is_booth_chair: true })
Membership.create({ organization: aphi_org, participant: Participant.create({ andrewid: 'rza'}), is_booth_chair: true })
Membership.create({ organization: aphi_org, participant: Participant.create({ andrewid: 'swl'}), is_booth_chair: true })
Membership.create({ organization: aphio_org, participant: Participant.create({ andrewid: 'mwuebben'}), is_booth_chair: true })
Membership.create({ organization: aphio_org, participant: Participant.create({ andrewid: 'mgraesse'}), is_booth_chair: true })
Membership.create({ organization: asa_org, participant: Participant.create({ andrewid: 'ayu1'}), is_booth_chair: true })
Membership.create({ organization: asa_org, participant: Participant.create({ andrewid: 'ichow'}), is_booth_chair: true })
Membership.create({ organization: asig_org, participant: Participant.create({ andrewid: 'lcervena '}), is_booth_chair: true })
Membership.create({ organization: asig_org, participant: Participant.create({ andrewid: 'sheldons'}), is_booth_chair: true })
Membership.create({ organization: astro_org, participant: Participant.create({ andrewid: 'bhaas'}), is_booth_chair: true })
Membership.create({ organization: astro_org, participant: Participant.create({ andrewid: 'mspoerl'}), is_booth_chair: true })
Membership.create({ organization: axo_org, participant: Participant.create({ andrewid: 'edolinar'}), is_booth_chair: true })
Membership.create({ organization: axo_org, participant: Participant.create({ andrewid: 'nbaltzer'}), is_booth_chair: true })
Membership.create({ organization: axo_org, participant: Participant.create({ andrewid: 'pranjalb'}), is_booth_chair: true })
Membership.create({ organization: axo_org, participant: Participant.create({ andrewid: 'vsivakum'}), is_booth_chair: true })
Membership.create({ organization: ddd_org, participant: Participant.create({ andrewid: 'nhb'}), is_booth_chair: true })
Membership.create({ organization: ddd_org, participant: Participant.create({ andrewid: 'smosshor'}), is_booth_chair: true })
Membership.create({ organization: ddd_org, participant: Participant.create({ andrewid: 'tbipat'}), is_booth_chair: true })
Membership.create({ organization: dg_org, participant: Participant.create({ andrewid: 'elawlis'}), is_booth_chair: true })
Membership.create({ organization: dg_org, participant: Participant.create({ andrewid: 'imartins'}), is_booth_chair: true })
Membership.create({ organization: dg_org, participant: Participant.create({ andrewid: 'lgoldste'}), is_booth_chair: true })
Membership.create({ organization: dg_org, participant: Participant.create({ andrewid: 'mbanks'}), is_booth_chair: true })
Membership.create({ organization: dg_org, participant: Participant.create({ andrewid: 'rlahmad'}), is_booth_chair: true })
Membership.create({ organization: dtd_org, participant: Participant.create({ andrewid: 'aperley'}), is_booth_chair: true })
Membership.create({ organization: dtd_org, participant: Participant.create({ andrewid: 'asekar'}), is_booth_chair: true })
Membership.create({ organization: dtd_org, participant: Participant.create({ andrewid: 'lfj'}), is_booth_chair: true })
Membership.create({ organization: dtd_org, participant: Participant.create({ andrewid: 'lgary'}), is_booth_chair: true })
Membership.create({ organization: dtd_org, participant: Participant.create({ andrewid: 'ldamasco'}), is_booth_chair: true })
Membership.create({ organization: dtd_org, participant: Participant.create({ andrewid: 'rmckinne'}), is_booth_chair: true })
Membership.create({ organization: dtd_org, participant: Participant.create({ andrewid: 'tfs'}), is_booth_chair: true })
Membership.create({ organization: fringe_org, participant: Participant.create({ andrewid: 'bphodge'}), is_booth_chair: true })
Membership.create({ organization: fringe_org, participant: Participant.create({ andrewid: 'lcody'}), is_booth_chair: true })
Membership.create({ organization: kapsig_org, participant: Participant.create({ andrewid: 'dkkoopma'}), is_booth_chair: true })
Membership.create({ organization: kapsig_org, participant: Participant.create({ andrewid: 'efiedore'}), is_booth_chair: true })
Membership.create({ organization: kapsig_org, participant: Participant.create({ andrewid: 'tmi'}), is_booth_chair: true })
Membership.create({ organization: kat_org, participant: Participant.create({ andrewid: 'acicozi'}), is_booth_chair: true })
Membership.create({ organization: kat_org, participant: Participant.create({ andrewid: 'edonohue'}), is_booth_chair: true })
Membership.create({ organization: kat_org, participant: Participant.create({ andrewid: 'lolno'}), is_booth_chair: true })
Membership.create({ organization: kat_org, participant: Participant.create({ andrewid: 'hholton'}), is_booth_chair: true })
Membership.create({ organization: kat_org, participant: Participant.create({ andrewid: 'ihlee'}), is_booth_chair: true })
Membership.create({ organization: kat_org, participant: Participant.create({ andrewid: 'urn '}), is_booth_chair: true })
Membership.create({ organization: kgb_org, participant: Participant.create({ andrewid: 'cmorey'}), is_booth_chair: true })
Membership.create({ organization: kgb_org, participant: Participant.create({ andrewid: 'dtv'}), is_booth_chair: true })
Membership.create({ organization: kgb_org, participant: Participant.create({ andrewid: 'mvarner'}), is_booth_chair: true })
Membership.create({ organization: kgb_org, participant: Participant.create({ andrewid: 'sctoor'}), is_booth_chair: true })
Membership.create({ organization: kkg_org, participant: Participant.create({ andrewid: 'alechner'}), is_booth_chair: true })
Membership.create({ organization: kkg_org, participant: Participant.create({ andrewid: 'eswanson'}), is_booth_chair: true })
Membership.create({ organization: kkg_org, participant: Participant.create({ andrewid: 'hnmcdona'}), is_booth_chair: true })
Membership.create({ organization: kkg_org, participant: Participant.create({ andrewid: 'kmg'}), is_booth_chair: true })
Membership.create({ organization: math_org, participant: Participant.create({ andrewid: 'kborst'}), is_booth_chair: true })
Membership.create({ organization: math_org, participant: Participant.create({ andrewid: 'khanson'}), is_booth_chair: true })
Membership.create({ organization: math_org, participant: Participant.create({ andrewid: 'kkuzemch'}), is_booth_chair: true })
Membership.create({ organization: mayur_org, participant: Participant.create({ andrewid: 'ksanghav'}), is_booth_chair: true })
Membership.create({ organization: mayur_org, participant: Participant.create({ andrewid: 'schordia'}), is_booth_chair: true })
Membership.create({ organization: mcs_org, participant: Participant.create({ andrewid: 'kschulz'}), is_booth_chair: true })
Membership.create({ organization: mcs_org, participant: Participant.create({ andrewid: 'lparrell'}), is_booth_chair: true })
Membership.create({ organization: phidelt_org, participant: Participant.create({ andrewid: 'resposit'}), is_booth_chair: true })
Membership.create({ organization: sae_org, participant: Participant.create({ andrewid: 'ahimmelr'}), is_booth_chair: true })
Membership.create({ organization: sae_org, participant: Participant.create({ andrewid: 'msofia'}), is_booth_chair: true })
Membership.create({ organization: sdc_org, participant: Participant.create({ andrewid: 'colinkel'}), is_booth_chair: true })
Membership.create({ organization: sdc_org, participant: Participant.create({ andrewid: 'djfranci'}), is_booth_chair: true })
Membership.create({ organization: sdc_org, participant: Participant.create({ andrewid: 'dcascava'}), is_booth_chair: true })
Membership.create({ organization: sdc_org, participant: Participant.create({ andrewid: 'dbperry'}), is_booth_chair: true })
Membership.create({ organization: sdc_org, participant: Participant.create({ andrewid: 'nehull'}), is_booth_chair: true })
Membership.create({ organization: sigchi_org, participant: Participant.create({ andrewid: 'progozen'}), is_booth_chair: true })
Membership.create({ organization: sigchi_org, participant: Participant.create({ andrewid: 'pdominic'}), is_booth_chair: true })
Membership.create({ organization: sigep_org, participant: Participant.create({ andrewid: 'balper'}), is_booth_chair: true })
Membership.create({ organization: sigep_org, participant: Participant.create({ andrewid: 'cdively'}), is_booth_chair: true })
Membership.create({ organization: sigep_org, participant: Participant.create({ andrewid: 'sjstark'}), is_booth_chair: true })
Membership.create({ organization: spirit_org, participant: Participant.create({ andrewid: 'jccox'}), is_booth_chair: true })
Membership.create({ organization: tsa_org, participant: Participant.create({ andrewid: 'cjwei'}), is_booth_chair: true })
Membership.create({ organization: tsa_org, participant: Participant.create({ andrewid: 'joyces'}), is_booth_chair: true })
Membership.create({ organization: tsa_org, participant: Participant.create({ andrewid: 'ppan'}), is_booth_chair: true })
Membership.create({ organization: tsa_org, participant: Participant.create({ andrewid: 'pchao '}), is_booth_chair: true })

# Certification Types --------------------------------------------------------
puts 'Certification Types'

golf_cart_cert = CertificationType.new({ name: 'Golf Cart' })
scissor_lift_cert = CertificationType.new({ name: 'Scissor Lift' })
Certification.create({ participant: chair, certification_type: golf_cart_cert })
Certification.create({ participant: chair, certification_type: scissor_lift_cert })

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
  { name: 'Building - Impeding fire lane or spillover space', description: "Impeding designated fire lanes or other organizations spill-over space.", default_amount: 25 },
  { name: 'Building - Spilled paint', description: "Paint spilled on the parking lot while painting a booth..", default_amount: 50 },
  { name: 'Building - Missing hardhat, wristband, and/or safety glasses', description: 'Being on Midway without a wristband, hardhat, and/or safety glasses.', default_amount: 15 },
  { name: 'Building - Non-builders helping build', description: 'Non-builders helping with the construction of a booth.', default_amount: 15 },
  { name: 'Building - Quiet hours', description: "Making noise during quiet hours that can be heard more than 20 feet from a booth.", default_amount: 25 },
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
  { question: "What if I don't know how to answer a question?",
    answer: "Look at the FAQs on binder. Ask someone else in the trailer or contact someone on exec. Don't just make something up." },
  { question: "What should I bring to my coordinator shift?",
    answer: "Your blue hard hat and SCC jacket, this will give you the position of authority. If you are acting as an SCC member on midway you must wear your SCC hard hat." },
  { question: "What is required to be on Midway?",
    answer: "Hardhat, wristband, closed toed shoes, safety glasses (regular glasses are not enough)." },
  { question: "What is the first thing I should do as a coordinator?",
    answer: "Sign in on Binder. Ask the previous coordinator if there is anything you should be aware of.  Check to see if there are notes or upcoming tasks on Binder." },
  { question: "Can I leave midway during my coordinator shift?",
    answer: "No, someone must be in the trailer at all times. If you have to leave, you must get an SCC member to cover while you are out." },
  { question: "Who is allowed in the trailer?",
    answer: "Only SCC members are allowed in the trailer. No one else should be in the trailer without permission from an SCC member." },
  { question: "The next coordinator doesn't show up. What do I do?",
    answer: "Call them repeatedly. If that fails, call the Carnival Chair." },
  { question: "The phone is rigning. What do I do? ",
    answer: "Be polite and respectful. Answer their questions if you can, or tell them we will call them back with an answer. Log the phone call in Binder." },
  { question: "What are the different radio channels?",
    answer: "Channel 1 is for the watch shifts. Channel 2 is for SCC." },
  { question: "I am having problems with the radio. What do I do?",
    answer: "Check to make sure it is on and that the volume is high enough. Make sure that you are on Channel 2 and are not pressing down on the talk button. Press the button to talk and release when you are done to hear a response." },
  { question: "When do dumpsters need to be taken out?",
    answer: "Dumpsters must be taken to entrance of the parking lot at the corner of Tech Street and Margaret Morrison before 2am." },
  { question: "What do the different wristbands mean?",
    answer: "Red is Building, Blue is Non-Building, and Checkered is CFA access." },
  { question: "Someone wants a wristband, What do I do?",
    answer: "Have them sign the waiver on binder, fill out what org they need it for, and give them the correct colored wristband." },
  { question: "What's the difference between a security and watch shift?",
    answer: "Security is paid, watch is not. Watch shifts are booth orgs, while security are non-building orgs." },
  { question: "A watch shift just showed up to the trailer, what should I do?",
    answer: "Sign in the shift members on Binder, hand them each jackets, and check out a radio to one of them. Briefly teach them how to use the radio and tell them to check in with you every 15 minutes. Review their responsibilities and have them look over the cheat sheet." },
  { question: "Booth watch shift doesn't show up. What do I do?",
    answer: "Do not let previous watch shift leave. Call booth chairs of that org in order until someone answers. Fine them accordingly in Binder. If no one can show up and old watch shift has to leave, split the other watch shift." },
  { question: "What do I do with my drunk watch/security shift that just showed up?",
    answer: "Send them home, call their booth chair, and inform them of what happened and that they are getting fined unless they supply new, sober people." },
  { question: "Drunk people won't listen. What do I do?",
    answer: "Call the police." },  
  { question: "What is Booth?",
    answer:  "Booth is one of the biggest traditions of Spring Carnival. Student organizations build multi-story structures around our annual theme , hosting interactive games and elaborate decorations. The booths will be located on the CFA Lot." },
  { question: "Booth chair is asking questions I don't understand. What do I do?",
    answer: "Add them to the Structural queue." },
  { question: "A booth chair is freaking out, sad, angry, etc. What do I do?",
    answer: "Call the Head of Booth." },
  { question: "What is downtime?",
    answer: "When a booth takes time to close their booth and have it not manned during Carnival. They must register the start of their downtime (you should track this) and put caution tape up to close off the doorways. They should also tell you when they are ending their downtime." },
  { question: "How much downtime does an org get?",
    answer: "4 hours." },
  { question: "How do I check how much downtime an org has left?",
    answer: "Remaining downtime is shown in Binder" },
  { question: "A booth tripped a breaker. What do I do?",
    answer: "Add them to the Electrical queue. Mark the fine in Binder if applicable." },
  { question: "Someone has a minor injury (splinter, small cut, dust in eye, etc.).",
    answer: "Give them equipment from the medical kit in the trailer. Tell them they can call EMS if they want. DO NOT ADMINISTER MEDICAL ASSISTANCE." },
  { question: "EMS is closed. What do I do?",
    answer: "Call them." },
  { question: "I saw an ambulance take someone to the hospital. What do I do?",
    answer: "Call the Carnival Chair, Head of Booth, and/or Head of Operations immediately." },
  { question: "Golf cart problem?",
    answer: "Call Meg Richards." },
  { question: "University official wants to borrow something. What do I do?",
    answer: "Let them. They do not need to sign a waiver. Check it out to the Carnival Chair in Binder." },
  { question: "Madelyn Miller calls. What do I do?",
    answer: "Listen to her. Then call the Head of Booth and relay the message." },
  { question: "Alumni needs something.",
    answer: "Call the Head of Operations or Head of Marketing." },
  { question: "Taylor Rental or TriBoro Trailer needs something.",
    answer: "Call the Head of Operations." },
  { question: "What do I do if something catches on fire?",
    answer: "There are fire extinguishers located at every booth. Take one and follow the instructions listed on the can." },
  { question: "It's raining and people are losing electricity.",
    answer: "Tell them to wait until the rain stops, then we will deal with it." },
  { question: "It's super windy. Things are flying off of booths.",
    answer: "Check weather on trailer computer. Call the Carnival Chair and Head of Booth with that information." },
  { question: "What are the hours of booths?",
    answer: "Thursday: 3PM-10PM, Friday: 11AM-10PM, Saturday: 11AM-10PM" },
  { question: "What are the hours of rides?",
    answer: "Thursday: 3PM-11PM, Friday: 10AM-11PM, Saturday: 10AM-11PM" },
  { question: "How much are rides tickets?",
    answer: "$1 per ride or $20 for 24 rides. Tickets are available at the ticket booth located on Midway." },
  { question: "Are there group rates for rides tickets?",
    answer: "No." },
  { question: "Can I get a wristband for the comedian?",
    answer: "Spring Carnival does not deal with the comedian. Talk to AB Comedy." },
  { question: "Can I get a wristband for the concert?",
    answer: "Spring Carnival does not deal with the concert. Talk to AB Concerts." },
  { question: "Where does CMU get money for Carnival?",
    answer: "Carnegie Mellon University's Spring Carnival is funded in part by your Student Activities Fee." }
])

# Tasks ------------------------------------------------------------------------
puts 'Tasks'

move_on = DateTime.rfc3339('2016-04-08T00:00:00-04:00')
build_saturday = move_on + 1.day
build_sunday = move_on + 2.days
monday = move_on + 3.days
tuesday = move_on + 4.days
wednesday = move_on + 5.days
operations = move_on + 6.days
ops_friday = move_on + 7.days
ops_saturday = move_on + 8.days
teardown = move_on + 9.days

puts '  One-Time Tasks'
Task.create([
  { name: "Move On Begins", description: "Orgs start moving on to Midway.", due_at: move_on + 18.hours },
  { name: "Construction Begins", description: "Orgs may begin building their booth.", due_at: move_on + 21.hours },
  { name: "Blitz Booth Move On Begins", description: "Blitz orgs move on to Midway.", due_at: build_saturday + 10.hours },
  { name: "Final Booth Inspections", description: "University staff will arrive on Midway. Direct them to the Head of Booth so they can inspect the booths.", due_at: wednesday + 12.hours },
  { name: "Construction Ends", description: "All but 4 members (full-size) or 2 members (blitz) of each org must clear Midway.", due_at: operations + 1.hours },
  { name: "Cleanup Begins", description: "Each org must send 2 members to the trailer to assist with Midway cleanup.", due_at: operations + 1.hours },
  { name: "Final Fixes Ends", description: "All members of each org must clear Midway", due_at: operations + 14.hours },
  { name: "Opening Ceremony", description: "Speeches, ribbon cutting, and Midway officially opens to the public.", due_at: operations + 15.hours },
  { name: "Judging Begins", description: "Judges will arrive on Midway. Direct them to the Carnival Chair or Head of Booth so they can begin judging.", due_at: ops_friday + 13.hours },
  { name: "Night Judging Begins", description: "Alumni judges will arrive on Midway. Direct them to the Carnival Chair or Head of Booth so they can begin judging.", due_at: ops_friday + 20.hours },
  { name: "Awards Ceremony", description: "Orgs may take close their booths without taking downtime for the Awards Ceremony.", due_at: ops_saturday + 16.hours + 30.minutes },
  { name: "Teardown Begins", description: "Orgs may begin to teardown.", due_at: teardown + 8.hours },
  { name: "Teardown Required Start", description: "All orgs must have begun to teardown.", due_at: teardown + 10.hours },
  { name: "Teardown Ends", description: "All orgs should have completely cleared Midway. If they have not, note when they finish so we can determine fines.", due_at: teardown + 5.hours }
])

puts '  Recurring Tasks'
 Task.create([
  { name: "Quiet Hours Start", description: "No loud noise on Midway. If you can hear something outside a booth it is too loud.", due_at: move_on + 22.hours },
  { name: "Quiet Hours Start", description: "No loud noise on Midway. If you can hear something outside a booth it is too loud.", due_at: build_saturday + 22.hours },
  { name: "Quiet Hours Start", description: "No loud noise on Midway. If you can hear something outside a booth it is too loud.", due_at: build_sunday + 22.hours },
  { name: "Quiet Hours Start", description: "No loud noise on Midway. If you can hear something outside a booth it is too loud.", due_at: monday + 22.hours },
  { name: "Quiet Hours Start", description: "No loud noise on Midway. If you can hear something outside a booth it is too loud.", due_at: tuesday + 22.hours },
  { name: "Quiet Hours Start", description: "No loud noise on Midway. If you can hear something outside a booth it is too loud.", due_at: wednesday + 22.hours },
  { name: "Quiet Hours End", description: "Noise is allowed on Midway.  Loud music that you can hear outside a booth are not allowed.", due_at: build_saturday + 7.hours },
  { name: "Quiet Hours End", description: "Noise is allowed on Midway.  Loud music that you can hear outside a booth are not allowed.", due_at: build_sunday + 7.hours },
  { name: "Quiet Hours End", description: "Noise is allowed on Midway.  Loud music that you can hear outside a booth are not allowed.", due_at: monday + 7.hours },
  { name: "Quiet Hours End", description: "Noise is allowed on Midway.  Loud music that you can hear outside a booth are not allowed.", due_at: tuesday + 7.hours },
  { name: "Quiet Hours End", description: "Noise is allowed on Midway.  Loud music that you can hear outside a booth are not allowed.", due_at: wednesday + 7.hours },
  { name: "Quiet Hours End", description: "Noise is allowed on Midway.", due_at: operations + 7.hours },
  { name: "No Loud Music Allowed", description: "Loud music is allowed on Midway.", due_at: monday + 8.hours },
  { name: "No Loud Music Allowed", description: "Loud music is allowed on Midway.", due_at: tuesday + 8.hours },
  { name: "No Loud Music Allowed", description: "Loud music is allowed on Midway.", due_at: wednesday + 8.hours },
  { name: "Loud Music Allowed", description: "Loud music is allowed on Midway.", due_at: monday + 18.hours },
  { name: "Loud Music Allowed", description: "Loud music is allowed on Midway.", due_at: tuesday + 18.hours },
  { name: "Loud Music Allowed", description: "Loud music is allowed on Midway.", due_at: wednesday + 18.hours },
  { name: "Move Dumpsters", description: "Have a watch shift move dumpsters to the entrance of the parking lot by corner of Tech St. and Margaret Morrison St.", due_at: build_saturday + 1.hours },
  { name: "Move Dumpsters", description: "Have a watch shift move dumpsters to the entrance of the parking lot by corner of Tech St. and Margaret Morrison St.", due_at: build_sunday + 1.hours },
  { name: "Move Dumpsters", description: "Have a watch shift move dumpsters to the entrance of the parking lot by corner of Tech St. and Margaret Morrison St.", due_at: monday + 1.hours },
  { name: "Move Dumpsters", description: "Have a watch shift move dumpsters to the entrance of the parking lot by corner of Tech St. and Margaret Morrison St.", due_at: tuesday + 1.hours },
  { name: "Move Dumpsters", description: "Have a watch shift move dumpsters to the entrance of the parking lot by corner of Tech St. and Margaret Morrison St.", due_at: wednesday + 1.hours },
  { name: "Move Dumpsters", description: "Have a watch shift move dumpsters to the entrance of the parking lot by corner of Tech St. and Margaret Morrison St.", due_at: operations + 1.hours },
  { name: "Move Dumpsters", description: "Have a watch shift move dumpsters to the entrance of the parking lot by corner of Tech St. and Margaret Morrison St.", due_at: ops_friday + 1.hours },
  { name: "Move Dumpsters", description: "Have a watch shift move dumpsters to the entrance of the parking lot by corner of Tech St. and Margaret Morrison St.", due_at: ops_saturday + 1.hours },
  { name: "Midway Opens", description: "Each org must have 2 members staffing their booth.", due_at: operations + 15.hours },
  { name: "Midway Closes", description: "Everyone must clear Midway.", due_at: operations + 22.hours },
  { name: "Midway Opens", description: "Each org must have 2 members staffing their booth.", due_at: ops_friday + 11.hours },
  { name: "Midway Closes", description: "Everyone must clear Midway.", due_at: ops_friday + 22.hours },
  { name: "Midway Opens", description: "Each org must have 2 members staffing their booth.", due_at: ops_saturday + 11.hours },
  { name: "Midway Closes", description: "Everyone must clear Midway.", due_at: ops_saturday + 22.hours }
 ])

# Shift Types ----------------------------------------------------------------
puts 'Shift Types'

watch_shift = ShiftType.create({ name: 'Watch Shift' })
security_shift = ShiftType.create({ name: 'Security Shift' })
coordinator_shift = ShiftType.create({ name: 'Coordinator Shift' })

# Shifts ---------------------------------------------------------------------
puts 'Shifts'

# Coordinator Shifts
puts '  Coordinator Shifts'
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 0.hours , ends_at: move_on + 16.hours + 4.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('arakla'), clocked_in_at: move_on + 16.hours + 0.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 4.hours , ends_at: move_on + 16.hours + 8.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('jcmertz'), clocked_in_at: move_on + 16.hours + 4.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 8.hours , ends_at: move_on + 16.hours + 12.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('nhoran'), clocked_in_at: move_on + 16.hours + 8.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 12.hours , ends_at: move_on + 16.hours + 16.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('nkawakam'), clocked_in_at: move_on + 16.hours + 12.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 16.hours , ends_at: move_on + 16.hours + 20.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('mreager'), clocked_in_at: move_on + 16.hours + 16.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 20.hours , ends_at: move_on + 16.hours + 24.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('bhunttob'), clocked_in_at: move_on + 16.hours + 20.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 24.hours , ends_at: move_on + 16.hours + 28.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('sasikalm'), clocked_in_at: move_on + 16.hours + 24.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 28.hours , ends_at: move_on + 16.hours + 32.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('zileig'), clocked_in_at: move_on + 16.hours + 28.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 32.hours , ends_at: move_on + 16.hours + 36.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('clohman'), clocked_in_at: move_on + 16.hours + 32.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 36.hours , ends_at: move_on + 16.hours + 40.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('agotsis'), clocked_in_at: move_on + 16.hours + 36.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 40.hours , ends_at: move_on + 16.hours + 44.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('jzak'), clocked_in_at: move_on + 16.hours + 40.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 44.hours , ends_at: move_on + 16.hours + 48.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('rahsan'), clocked_in_at: move_on + 16.hours + 44.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 48.hours , ends_at: move_on + 16.hours + 52.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('egarbade'), clocked_in_at: move_on + 16.hours + 48.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 52.hours , ends_at: move_on + 16.hours + 56.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('tan'), clocked_in_at: move_on + 16.hours + 52.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 56.hours , ends_at: move_on + 16.hours + 60.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('bbzhang'), clocked_in_at: move_on + 16.hours + 56.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 60.hours , ends_at: move_on + 16.hours + 64.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('chenhaoy'), clocked_in_at: move_on + 16.hours + 60.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 64.hours , ends_at: move_on + 16.hours + 68.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('prheinhe'), clocked_in_at: move_on + 16.hours + 64.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 68.hours , ends_at: move_on + 16.hours + 72.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('jlareau'), clocked_in_at: move_on + 16.hours + 68.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 72.hours , ends_at: move_on + 16.hours + 76.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('jiyunkwo'), clocked_in_at: move_on + 16.hours + 72.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 76.hours , ends_at: move_on + 16.hours + 80.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('cbanuelo'), clocked_in_at: move_on + 16.hours + 76.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 80.hours , ends_at: move_on + 16.hours + 84.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('jcmertz'), clocked_in_at: move_on + 16.hours + 80.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 84.hours , ends_at: move_on + 16.hours + 88.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('tan'), clocked_in_at: move_on + 16.hours + 84.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 88.hours , ends_at: move_on + 16.hours + 92.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('amartine'), clocked_in_at: move_on + 16.hours + 88.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 92.hours , ends_at: move_on + 16.hours + 96.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('sasikalm'), clocked_in_at: move_on + 16.hours + 92.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 96.hours , ends_at: move_on + 16.hours + 100.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('yuanyua1'), clocked_in_at: move_on + 16.hours + 96.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 100.hours , ends_at: move_on + 16.hours + 104.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('nehull'), clocked_in_at: move_on + 16.hours + 100.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 104.hours , ends_at: move_on + 16.hours + 108.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('cmorin'), clocked_in_at: move_on + 16.hours + 104.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 108.hours , ends_at: move_on + 16.hours + 112.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('lawrencx'), clocked_in_at: move_on + 16.hours + 108.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 112.hours , ends_at: move_on + 16.hours + 116.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('agurvich'), clocked_in_at: move_on + 16.hours + 112.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 116.hours , ends_at: move_on + 16.hours + 120.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('amoran'), clocked_in_at: move_on + 16.hours + 116.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 120.hours , ends_at: move_on + 16.hours + 124.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('jcp'), clocked_in_at: move_on + 16.hours + 120.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 124.hours , ends_at: move_on + 16.hours + 128.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('cmorin'), clocked_in_at: move_on + 16.hours + 124.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 128.hours , ends_at: move_on + 16.hours + 132.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('saclark'), clocked_in_at: move_on + 16.hours + 128.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 132.hours , ends_at: move_on + 16.hours + 136.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('mreager'), clocked_in_at: move_on + 16.hours + 132.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 136.hours , ends_at: move_on + 16.hours + 140.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('cbanuelo'), clocked_in_at: move_on + 16.hours + 136.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 140.hours , ends_at: move_on + 16.hours + 144.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('amartine'), clocked_in_at: move_on + 16.hours + 140.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 144.hours , ends_at: move_on + 16.hours + 148.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('yuanyua1'), clocked_in_at: move_on + 16.hours + 144.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 148.hours , ends_at: move_on + 16.hours + 152.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('jcp'), clocked_in_at: move_on + 16.hours + 148.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 152.hours , ends_at: move_on + 16.hours + 156.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('zileig'), clocked_in_at: move_on + 16.hours + 152.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 156.hours , ends_at: move_on + 16.hours + 160.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('amoran'), clocked_in_at: move_on + 16.hours + 156.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 160.hours , ends_at: move_on + 16.hours + 164.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('msingal'), clocked_in_at: move_on + 16.hours + 160.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 164.hours , ends_at: move_on + 16.hours + 168.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('chenhaoy'), clocked_in_at: move_on + 16.hours + 164.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 168.hours , ends_at: move_on + 16.hours + 172.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('tmedirat'), clocked_in_at: move_on + 16.hours + 168.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 172.hours , ends_at: move_on + 16.hours + 176.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('hkoschme'), clocked_in_at: move_on + 16.hours + 172.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 176.hours , ends_at: move_on + 16.hours + 180.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('jwesson'), clocked_in_at: move_on + 16.hours + 176.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 180.hours , ends_at: move_on + 16.hours + 184.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('meribyte'), clocked_in_at: move_on + 16.hours + 180.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 184.hours , ends_at: move_on + 16.hours + 188.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('nkawakam'), clocked_in_at: move_on + 16.hours + 184.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 188.hours , ends_at: move_on + 16.hours + 192.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('lawrencx'), clocked_in_at: move_on + 16.hours + 188.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 192.hours , ends_at: move_on + 16.hours + 196.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('saclark'), clocked_in_at: move_on + 16.hours + 192.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 196.hours , ends_at: move_on + 16.hours + 200.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('msingal'), clocked_in_at: move_on + 16.hours + 196.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 200.hours , ends_at: move_on + 16.hours + 204.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('nehull'), clocked_in_at: move_on + 16.hours + 200.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 204.hours , ends_at: move_on + 16.hours + 208.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('rahsan'), clocked_in_at: move_on + 16.hours + 204.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 208.hours , ends_at: move_on + 16.hours + 212.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('nhoran'), clocked_in_at: move_on + 16.hours + 208.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 212.hours , ends_at: move_on + 16.hours + 216.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('agotsis'), clocked_in_at: move_on + 16.hours + 212.hours })
ShiftParticipant.create({ shift: Shift.create({ shift_type: coordinator_shift, organization: scc_org, starts_at: move_on + 16.hours + 216.hours , ends_at: move_on + 16.hours + 220.hours, required_number_of_participants: 1 }), participant: Participant.find_by_andrewid('arakla'), clocked_in_at: move_on + 16.hours + 216.hours })

# Watch Shifts
puts '  Watch Shifts'
Shift.create({ shift_type: watch_shift, organization: aepi_org, starts_at: move_on + 21.hours + 166.hours , ends_at: move_on + 21.hours + 168.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: aepi_org, starts_at: move_on + 21.hours + 164.hours , ends_at: move_on + 21.hours + 166.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: aepi_org, starts_at: move_on + 21.hours + 158.hours , ends_at: move_on + 21.hours + 160.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: aepi_org, starts_at: move_on + 21.hours + 48.hours , ends_at: move_on + 21.hours + 50.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: aepi_org, starts_at: move_on + 21.hours + 48.hours , ends_at: move_on + 21.hours + 50.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: aepi_org, starts_at: move_on + 21.hours + 18.hours , ends_at: move_on + 21.hours + 20.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: aphi_org, starts_at: move_on + 21.hours + 188.hours , ends_at: move_on + 21.hours + 190.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: aphi_org, starts_at: move_on + 21.hours + 186.hours , ends_at: move_on + 21.hours + 188.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: aphi_org, starts_at: move_on + 21.hours + 182.hours , ends_at: move_on + 21.hours + 184.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: aphi_org, starts_at: move_on + 21.hours + 22.hours , ends_at: move_on + 21.hours + 24.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: aphi_org, starts_at: move_on + 21.hours + 46.hours , ends_at: move_on + 21.hours + 48.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: aphi_org, starts_at: move_on + 21.hours + 38.hours , ends_at: move_on + 21.hours + 40.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: aphio_org, starts_at: move_on + 21.hours + 200.hours , ends_at: move_on + 21.hours + 202.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: aphio_org, starts_at: move_on + 21.hours + 102.hours , ends_at: move_on + 21.hours + 104.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: aphio_org, starts_at: move_on + 21.hours + 56.hours , ends_at: move_on + 21.hours + 58.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: aphio_org, starts_at: move_on + 21.hours + 6.hours , ends_at: move_on + 21.hours + 8.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: aphio_org, starts_at: move_on + 21.hours + 174.hours , ends_at: move_on + 21.hours + 176.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: aphio_org, starts_at: move_on + 21.hours + 28.hours , ends_at: move_on + 21.hours + 30.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: asa_org, starts_at: move_on + 21.hours + 148.hours , ends_at: move_on + 21.hours + 150.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: asa_org, starts_at: move_on + 21.hours + 148.hours , ends_at: move_on + 21.hours + 150.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: asa_org, starts_at: move_on + 21.hours + 196.hours , ends_at: move_on + 21.hours + 198.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: asa_org, starts_at: move_on + 21.hours + 196.hours , ends_at: move_on + 21.hours + 198.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: asa_org, starts_at: move_on + 21.hours + 172.hours , ends_at: move_on + 21.hours + 174.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: asa_org, starts_at: move_on + 21.hours + 170.hours , ends_at: move_on + 21.hours + 172.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: asig_org, starts_at: move_on + 21.hours + 54.hours , ends_at: move_on + 21.hours + 56.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: asig_org, starts_at: move_on + 21.hours + 78.hours , ends_at: move_on + 21.hours + 80.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: asig_org, starts_at: move_on + 21.hours + 32.hours , ends_at: move_on + 21.hours + 34.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: asig_org, starts_at: move_on + 21.hours + 58.hours , ends_at: move_on + 21.hours + 60.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: asig_org, starts_at: move_on + 21.hours + 82.hours , ends_at: move_on + 21.hours + 84.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: astro_org, starts_at: move_on + 21.hours + 134.hours , ends_at: move_on + 21.hours + 136.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: astro_org, starts_at: move_on + 21.hours + 206.hours , ends_at: move_on + 21.hours + 208.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: astro_org, starts_at: move_on + 21.hours + 86.hours , ends_at: move_on + 21.hours + 88.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: axo_org, starts_at: move_on + 21.hours + 122.hours , ends_at: move_on + 21.hours + 124.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: axo_org, starts_at: move_on + 21.hours + 50.hours , ends_at: move_on + 21.hours + 52.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: axo_org, starts_at: move_on + 21.hours + 50.hours , ends_at: move_on + 21.hours + 52.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: axo_org, starts_at: move_on + 21.hours + 146.hours , ends_at: move_on + 21.hours + 148.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: axo_org, starts_at: move_on + 21.hours + 26.hours , ends_at: move_on + 21.hours + 28.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: axo_org, starts_at: move_on + 21.hours + 26.hours , ends_at: move_on + 21.hours + 28.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: ddd_org, starts_at: move_on + 21.hours + 34.hours , ends_at: move_on + 21.hours + 36.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: ddd_org, starts_at: move_on + 21.hours + 12.hours , ends_at: move_on + 21.hours + 14.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: ddd_org, starts_at: move_on + 21.hours + 36.hours , ends_at: move_on + 21.hours + 38.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: ddd_org, starts_at: move_on + 21.hours + 24.hours , ends_at: move_on + 21.hours + 26.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: ddd_org, starts_at: move_on + 21.hours + 90.hours , ends_at: move_on + 21.hours + 92.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: ddd_org, starts_at: move_on + 21.hours + 72.hours , ends_at: move_on + 21.hours + 74.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: dg_org, starts_at: move_on + 21.hours + 2.hours , ends_at: move_on + 21.hours + 4.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: dg_org, starts_at: move_on + 21.hours + 98.hours , ends_at: move_on + 21.hours + 100.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: dg_org, starts_at: move_on + 21.hours + 74.hours , ends_at: move_on + 21.hours + 76.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: dg_org, starts_at: move_on + 21.hours + 74.hours , ends_at: move_on + 21.hours + 76.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: dg_org, starts_at: move_on + 21.hours + 72.hours , ends_at: move_on + 21.hours + 74.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: dg_org, starts_at: move_on + 21.hours + 116.hours , ends_at: move_on + 21.hours + 118.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: dtd_org, starts_at: move_on + 21.hours + 0.hours , ends_at: move_on + 21.hours + 2.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: dtd_org, starts_at: move_on + 21.hours + 96.hours , ends_at: move_on + 21.hours + 98.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: dtd_org, starts_at: move_on + 21.hours + 92.hours , ends_at: move_on + 21.hours + 94.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: dtd_org, starts_at: move_on + 21.hours + 94.hours , ends_at: move_on + 21.hours + 96.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: dtd_org, starts_at: move_on + 21.hours + 30.hours , ends_at: move_on + 21.hours + 32.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: dtd_org, starts_at: move_on + 21.hours + 4.hours , ends_at: move_on + 21.hours + 6.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: fringe_org, starts_at: move_on + 21.hours + 190.hours , ends_at: move_on + 21.hours + 192.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: fringe_org, starts_at: move_on + 21.hours + 210.hours , ends_at: move_on + 21.hours + 212.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: fringe_org, starts_at: move_on + 21.hours + 208.hours , ends_at: move_on + 21.hours + 210.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: fringe_org, starts_at: move_on + 21.hours + 138.hours , ends_at: move_on + 21.hours + 140.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: fringe_org, starts_at: move_on + 21.hours + 64.hours , ends_at: move_on + 21.hours + 66.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: fringe_org, starts_at: move_on + 21.hours + 66.hours , ends_at: move_on + 21.hours + 68.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kapsig_org, starts_at: move_on + 21.hours + 180.hours , ends_at: move_on + 21.hours + 182.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kapsig_org, starts_at: move_on + 21.hours + 204.hours , ends_at: move_on + 21.hours + 206.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kapsig_org, starts_at: move_on + 21.hours + 132.hours , ends_at: move_on + 21.hours + 134.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kapsig_org, starts_at: move_on + 21.hours + 132.hours , ends_at: move_on + 21.hours + 134.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kapsig_org, starts_at: move_on + 21.hours + 156.hours , ends_at: move_on + 21.hours + 158.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kapsig_org, starts_at: move_on + 21.hours + 142.hours , ends_at: move_on + 21.hours + 144.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kat_org, starts_at: move_on + 21.hours + 128.hours , ends_at: move_on + 21.hours + 130.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kat_org, starts_at: move_on + 21.hours + 198.hours , ends_at: move_on + 21.hours + 200.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kat_org, starts_at: move_on + 21.hours + 150.hours , ends_at: move_on + 21.hours + 152.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kat_org, starts_at: move_on + 21.hours + 154.hours , ends_at: move_on + 21.hours + 156.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kat_org, starts_at: move_on + 21.hours + 172.hours , ends_at: move_on + 21.hours + 174.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kat_org, starts_at: move_on + 21.hours + 170.hours , ends_at: move_on + 21.hours + 172.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kgb_org, starts_at: move_on + 21.hours + 192.hours , ends_at: move_on + 21.hours + 194.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kgb_org, starts_at: move_on + 21.hours + 136.hours , ends_at: move_on + 21.hours + 138.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kgb_org, starts_at: move_on + 21.hours + 184.hours , ends_at: move_on + 21.hours + 186.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kgb_org, starts_at: move_on + 21.hours + 138.hours , ends_at: move_on + 21.hours + 140.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kgb_org, starts_at: move_on + 21.hours + 144.hours , ends_at: move_on + 21.hours + 146.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kgb_org, starts_at: move_on + 21.hours + 118.hours , ends_at: move_on + 21.hours + 120.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kkg_org, starts_at: move_on + 21.hours + 202.hours , ends_at: move_on + 21.hours + 204.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kkg_org, starts_at: move_on + 21.hours + 204.hours , ends_at: move_on + 21.hours + 206.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kkg_org, starts_at: move_on + 21.hours + 60.hours , ends_at: move_on + 21.hours + 62.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kkg_org, starts_at: move_on + 21.hours + 108.hours , ends_at: move_on + 21.hours + 110.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kkg_org, starts_at: move_on + 21.hours + 84.hours , ends_at: move_on + 21.hours + 86.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: kkg_org, starts_at: move_on + 21.hours + 68.hours , ends_at: move_on + 21.hours + 70.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: math_org, starts_at: move_on + 21.hours + 134.hours , ends_at: move_on + 21.hours + 136.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: math_org, starts_at: move_on + 21.hours + 136.hours , ends_at: move_on + 21.hours + 138.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: math_org, starts_at: move_on + 21.hours + 62.hours , ends_at: move_on + 21.hours + 64.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: mayur_org, starts_at: move_on + 21.hours + 8.hours , ends_at: move_on + 21.hours + 10.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: mayur_org, starts_at: move_on + 21.hours + 194.hours , ends_at: move_on + 21.hours + 196.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: mayur_org, starts_at: move_on + 21.hours + 194.hours , ends_at: move_on + 21.hours + 196.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: mcs_org, starts_at: move_on + 21.hours + 126.hours , ends_at: move_on + 21.hours + 128.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: mcs_org, starts_at: move_on + 21.hours + 152.hours , ends_at: move_on + 21.hours + 154.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: mcs_org, starts_at: move_on + 21.hours + 52.hours , ends_at: move_on + 21.hours + 54.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: phidelt_org, starts_at: move_on + 21.hours + 212.hours , ends_at: move_on + 21.hours + 214.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: phidelt_org, starts_at: move_on + 21.hours + 210.hours , ends_at: move_on + 21.hours + 212.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: phidelt_org, starts_at: move_on + 21.hours + 206.hours , ends_at: move_on + 21.hours + 208.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: phidelt_org, starts_at: move_on + 21.hours + 208.hours , ends_at: move_on + 21.hours + 210.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: phidelt_org, starts_at: move_on + 21.hours + 88.hours , ends_at: move_on + 21.hours + 90.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: phidelt_org, starts_at: move_on + 21.hours + 70.hours , ends_at: move_on + 21.hours + 72.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: sae_org, starts_at: move_on + 21.hours + 100.hours , ends_at: move_on + 21.hours + 102.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: sae_org, starts_at: move_on + 21.hours + 76.hours , ends_at: move_on + 21.hours + 78.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: sae_org, starts_at: move_on + 21.hours + 168.hours , ends_at: move_on + 21.hours + 170.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: sae_org, starts_at: move_on + 21.hours + 146.hours , ends_at: move_on + 21.hours + 148.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: sae_org, starts_at: move_on + 21.hours + 140.hours , ends_at: move_on + 21.hours + 142.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: sae_org, starts_at: move_on + 21.hours + 44.hours , ends_at: move_on + 21.hours + 46.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: sdc_org, starts_at: move_on + 21.hours + 178.hours , ends_at: move_on + 21.hours + 180.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: sdc_org, starts_at: move_on + 21.hours + 10.hours , ends_at: move_on + 21.hours + 12.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: sdc_org, starts_at: move_on + 21.hours + 106.hours , ends_at: move_on + 21.hours + 108.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: sigchi_org, starts_at: move_on + 21.hours + 176.hours , ends_at: move_on + 21.hours + 178.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: sigchi_org, starts_at: move_on + 21.hours + 80.hours , ends_at: move_on + 21.hours + 82.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: sigchi_org, starts_at: move_on + 21.hours + 104.hours , ends_at: move_on + 21.hours + 106.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: sigep_org, starts_at: move_on + 21.hours + 120.hours , ends_at: move_on + 21.hours + 122.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: sigep_org, starts_at: move_on + 21.hours + 110.hours , ends_at: move_on + 21.hours + 112.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: sigep_org, starts_at: move_on + 21.hours + 112.hours , ends_at: move_on + 21.hours + 114.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: sigep_org, starts_at: move_on + 21.hours + 24.hours , ends_at: move_on + 21.hours + 26.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: sigep_org, starts_at: move_on + 21.hours + 114.hours , ends_at: move_on + 21.hours + 116.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: sigep_org, starts_at: move_on + 21.hours + 40.hours , ends_at: move_on + 21.hours + 42.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: spirit_org, starts_at: move_on + 21.hours + 124.hours , ends_at: move_on + 21.hours + 126.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: spirit_org, starts_at: move_on + 21.hours + 130.hours , ends_at: move_on + 21.hours + 132.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: tsa_org, starts_at: move_on + 21.hours + 160.hours , ends_at: move_on + 21.hours + 162.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: tsa_org, starts_at: move_on + 21.hours + 162.hours , ends_at: move_on + 21.hours + 164.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: tsa_org, starts_at: move_on + 21.hours + 14.hours , ends_at: move_on + 21.hours + 16.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: tsa_org, starts_at: move_on + 21.hours + 16.hours , ends_at: move_on + 21.hours + 18.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: tsa_org, starts_at: move_on + 21.hours + 20.hours , ends_at: move_on + 21.hours + 22.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: watch_shift, organization: tsa_org, starts_at: move_on + 21.hours + 42.hours , ends_at: move_on + 21.hours + 44.hours, required_number_of_participants: 2 })

# Security Shifts
puts '  Security Shifts'
Shift.create({ shift_type: security_shift, description: 'Midway Setup', organization: quidditch_org, starts_at: move_on + 21.hours, ends_at: move_on + 23.hours, required_number_of_participants: 4 })
Shift.create({ shift_type: security_shift, description: 'Midway Cleanup', organization: juntos_org, starts_at: operations + 11.hours, ends_at: operations + 15.hours, required_number_of_participants: 4 })
Shift.create({ shift_type: security_shift, description: 'Midway Setup', organization: rowing_org, starts_at: operations + 11.hours, ends_at: operations + 15.hours, required_number_of_participants: 4 })
Shift.create({ shift_type: security_shift, description: 'Award Ceremony Setup', organization: juntos_org, starts_at: ops_saturday + 14.hours, ends_at: ops_saturday + 16.hours, required_number_of_participants: 4 })
Shift.create({ shift_type: security_shift, description: 'Award Ceremony', organization: juntos_org, starts_at: ops_saturday + 16.hours, ends_at: ops_saturday + 18.hours, required_number_of_participants: 4 })
Shift.create({ shift_type: security_shift, description: 'Teardown Setup', organization: treblemakers_org, starts_at: teardown + 16.hours, ends_at: teardown + 18.hours, required_number_of_participants: 4 })
Shift.create({ shift_type: security_shift, description: 'Tent Setup', organization: originals_org, starts_at: operations + 21.hours, ends_at: operations + 21.hours, required_number_of_participants: 4 })
Shift.create({ shift_type: security_shift, description: 'Green Room', organization: originals_org, starts_at: ops_friday + 13.hours, ends_at: ops_friday + 16.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: security_shift, description: 'Green Room', organization: originals_org, starts_at: ops_saturday + 13.hours, ends_at: ops_saturday + 16.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: security_shift, description: 'Off-Night Event', organization: originals_org, starts_at: ops_saturday + 13.hours, ends_at: ops_saturday + 16.hours, required_number_of_participants: 4 })
Shift.create({ shift_type: security_shift, description: 'CFA Security', organization: rowing_org, starts_at: operations + 15.hours, ends_at: operations + 17.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: security_shift, description: 'CFA Security', organization: rowing_org, starts_at: operations + 17.hours, ends_at: operations + 19.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: security_shift, description: 'CFA Security', organization: juntos_org, starts_at: operations + 19.hours, ends_at: operations + 21.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: security_shift, description: 'CFA Security', organization: juntos_org, starts_at: operations + 12.hours, ends_at: operations + 23.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: security_shift, description: 'CFA Security', organization: treblemakers_org, starts_at: ops_friday + 10.hours, ends_at: ops_friday + 13.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: security_shift, description: 'CFA Security', organization: treblemakers_org, starts_at: ops_friday + 13.hours, ends_at: ops_friday + 15.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: security_shift, description: 'CFA Security', organization: juntos_org, starts_at: ops_friday + 15.hours, ends_at: ops_friday + 17.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: security_shift, description: 'CFA Security', organization: juntos_org, starts_at: ops_friday + 17.hours, ends_at: ops_friday + 19.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: security_shift, description: 'CFA Security', organization: quidditch_org, starts_at: ops_friday + 19.hours, ends_at: ops_friday + 21.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: security_shift, description: 'CFA Security', organization: originals_org, starts_at: ops_friday + 21.hours, ends_at: ops_friday + 23.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: security_shift, description: 'CFA Security', organization: rowing_org, starts_at: ops_saturday + 10.hours, ends_at: ops_saturday + 13.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: security_shift, description: 'CFA Security', organization: rowing_org, starts_at: ops_saturday + 13.hours, ends_at: ops_saturday + 15.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: security_shift, description: 'CFA Security', organization: quidditch_org, starts_at: ops_saturday + 15.hours, ends_at: ops_saturday + 17.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: security_shift, description: 'CFA Security', organization: quidditch_org, starts_at: ops_saturday + 17.hours, ends_at: ops_saturday + 19.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: security_shift, description: 'CFA Security', organization: originals_org, starts_at: ops_saturday + 19.hours, ends_at: ops_saturday + 21.hours, required_number_of_participants: 2 })
Shift.create({ shift_type: security_shift, description: 'CFA Security', organization: originals_org, starts_at: ops_saturday + 21.hours, ends_at: ops_saturday + 23.hours, required_number_of_participants: 2 })

# Tools -------------------------------------------------------------------------
puts 'Tools'

generate_tools

ToolTypeCertification.create({ tool_type: ToolType.find_by_name("Golf Cart"), certification_type: golf_cart_cert })
ToolTypeCertification.create({ tool_type: ToolType.find_by_name("Scissor Lift"), certification_type: scissor_lift_cert })

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
StoreItem.create({ name: 'Spade Bit - 3/4""', price: 5, quantity: 1000})
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
