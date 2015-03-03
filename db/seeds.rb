# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require_relative 'tool_seed.rb'

puts 'Seeding Database...'
puts
puts 'Seeding:'

# Organization Categories -----------------------------------------------------
puts 'Organization Categories'
frat = OrganizationCategory.create({ name: 'Fraternity'})
soro = OrganizationCategory.create({ name: 'Sorority'})
indie = OrganizationCategory.create({ name: 'Independent'})
blitz = OrganizationCategory.create({ name: 'Blitz'})
concessions = OrganizationCategory.create({ name: 'Concessions'})
non_building = OrganizationCategory.create({ name: 'Non-Building' })
university = OrganizationCategory.create({ name: 'Staff' })
scc = OrganizationCategory.create({ name: 'SCC'})

# Organizations ---------------------------------------------------------------
puts 'Organizations'
scc_org = Organization.create({ name: 'Spring Carnival Committee', organization_category: scc, short_name: 'SCC' })

puts '  University'
ehs_org = Organization.create({ name: 'Environmental Health and Safety', organization_category: university, short_name: 'EH&S' })
  OrganizationAlias.create({ organization: ehs_org, name: 'EHS' })
fms_org = Organization.create({ name: 'Facilities Management Services', organization_category: university, short_name: 'FMS' })
dosa_org = Organization.create({ name: 'Student Affairs', organization_category: university, short_name: 'DOSA' })
  OrganizationAlias.create({ organization: dosa_org, name: 'Division of Student Affairs' })
  OrganizationAlias.create({ organization: dosa_org, name: 'DOSA' })
  OrganizationAlias.create({ organization: dosa_org, name: 'Student Activities' })
  OrganizationAlias.create({ organization: dosa_org, name: 'SOA' })
  OrganizationAlias.create({ organization: dosa_org, name: 'Student Life' })
  OrganizationAlias.create({ organization: dosa_org, name: 'SLO' })

puts '  Consessions'
kapsig_org = Organization.create({ name: 'Kappa Sigma', organization_category: concessions, short_name: 'KapSig' })
aphio_org = Organization.create({ name: 'Alpha Phi Omega', organization_category: concessions, short_name: 'APhiO' })

puts '  Fraternity'
aepi_org = Organization.create({ name: 'Alpha Epsilon Pi', organization_category: frat, short_name: 'AEPi' })
dtd_org = Organization.create({ name: 'Delta Tau Delta', organization_category: frat, short_name: 'DTD' })
  OrganizationAlias.create({ organization: dtd_org, name: 'Delt' })
du_org = Organization.create({ name: 'Delta Upsilon', organization_category: frat, short_name: 'DU' })
phidelt_org = Organization.create({ name: 'Phi Delta Theta', organization_category: frat, short_name: 'PhiDelt' })
sae_org = Organization.create({ name: 'Sigma Alpha Epsilon', organization_category: frat, short_name: 'SAE' })
sigep_org = Organization.create({ name: 'Sigma Phi Epsilon', organization_category: frat, short_name: 'SigEp' })
  OrganizationAlias.create({ organization: sigep_org, name: 'SPE' })

puts '  Sorority'
aphi_org = Organization.create({ name: 'Alpha Phi', organization_category: soro, short_name: 'Alpha Phi' })
  OrganizationAlias.create({ organization: aphi_org, name: 'APhi' })
axo_org = Organization.create({ name: 'Alpha Chi Omega', organization_category: soro, short_name: 'AXO' })
  OrganizationAlias.create({ organization: axo_org, name: 'AXO' })
  OrganizationAlias.create({ organization: axo_org, name: 'Alpha Chi' })
ddd_org = Organization.create({ name: 'Delta Delta Delta', organization_category: soro, short_name: 'Tri Delt' })
  OrganizationAlias.create({ organization: ddd_org, name: 'DDD' })
  OrganizationAlias.create({ organization: ddd_org, name: 'TriDelta' })
dg_org = Organization.create({ name: 'Delta Gamma', organization_category: soro, short_name: 'DG' })
kat_org = Organization.create({ name: 'Kappa Alpha Theta', organization_category: soro, short_name: 'Theta' })
  OrganizationAlias.create({ organization: kat_org, name: 'KAT' })
kkg_org = Organization.create({ name: 'Kappa Kappa Gamma', organization_category: soro, short_name: 'Kappa' })
  OrganizationAlias.create({ organization: kkg_org, name: 'KKG' })

puts '  Independent'
asa_org = Organization.create({ name: 'Asian Student Association', organization_category: indie, short_name: 'ASA' })
fringe_org = Organization.create({ name: 'Fringe', organization_category: indie, short_name: 'Fringe' })
kgb_org = Organization.create({ name: 'KGB', organization_category: indie, short_name: 'KGB' })
sdc_org = Organization.create({ name: 'Student Dormitory Council', organization_category: indie, short_name: 'SDC' })
ssa_org = Organization.create({ name: 'Singapore Student Association', organization_category: indie, short_name: 'SSA' })
tsa_org = Organization.create({ name: 'Taiwanese Student Association', organization_category: indie, short_name: 'TSA' })

puts '  Blitz'
astro_org = Organization.create({ name: 'Astronomy Club', organization_category: blitz, short_name: 'Astro' })
#akpsi_org = Organization.create({ name: 'Alpha Kappa Psi', organization_category: blitz })
#  OrganizationAlias.create({ organization: akpsi_org, name: 'AKPsi' })
math_org = Organization.create({ name: 'Math Club', organization_category: blitz })
mayur_org = Organization.create({ name: 'Mayur SASA', organization_category: blitz, short_name: 'Mayur' })
  OrganizationAlias.create({ organization: mayur_org, name: 'SASA' })
mcs_org = Organization.create({ name: 'Mellon College of Science', organization_category: blitz, short_name: 'MCS' })
#mudge_org = Organization.create({ name: 'Mudge', organization_category: blitz })
spirit_org = Organization.create({ name: 'Spirit', organization_category: blitz })
earth_org = Organization.create({ name: 'Sustainable Earth', organization_category: blitz, short_name: 'Sust. Earth' })
#lambda_org = Organization.create({ name: 'Lambda Phi Epsilon', organization_category: blitz, short_name: 'Lambda' })
#stever_org = Organization.create({ name: 'Stever', organization_category: blitz })
sigchi_org = Organization.create({ name: 'Sigma Chi', organization_category: blitz, short_name: 'SigChi' })
  OrganizationAlias.create({ organization: sigchi_org, name: 'SX' })

puts '  Non-Building'
crew_org = Organization.create({ name: 'Crew', organization_category: non_building })
  OrganizationAlias.create({ organization: crew_org, name: 'Rowing' })
the_os_org = Organization.create({ name: 'The Originals', organization_category: non_building, short_name: 'The O\'s' })
pike_org = Organization.create({ name: 'Pi Kappa Alpha', organization_category: non_building, short_name: 'Pike' })
  OrganizationAlias.create({ organization: pike_org, name: 'Pika' })
polo_org = Organization.create({ name: 'Water Polo', organization_category: non_building, short_name: 'Polo' })
habitat_org = Organization.create({ name: 'Habitat for Humanity', organization_category: non_building, short_name: 'Habitat' })
lg_org = Organization.create({ name: 'Lunar Gala', organization_category: non_building, short_name: 'LG' })

# Judging ---------------------------------------------------------------------

puts 'Judging Categories'
JudgementCategory.create([
  { name: 'Overall Quality', grouping: 'design', max_value: 30, description: 'Is the booth well constructed and is there good attention to detail.' },
])

# SCC Members -----------------------------------------------------------------
puts 'SCC Members (not exhaustive)'
carrie_user = User.new({ email: 'cweintra@andrew.cmu.edu', name: 'Carrie Weintraub'})
carrie_user.add_role :admin
carrie_user.save!
carrie = Participant.create({ andrewid: 'cweintra', phone_number: 2038309156, user: carrie_user })
Membership.create({ organization: scc_org, participant: carrie, title: 'Carnival Chair', is_booth_chair: true })
Membership.create({ organization: kkg_org, participant: carrie })

hannelie_user = User.new({ email: 'hmostert@andrew.cmu.edu', name: 'Hannelie Mostert'})
hannelie_user.add_role :admin
hannelie_user.save!
hannelie = Participant.create({ andrewid: 'hmostert', phone_number: 1234567890, user: hannelie_user })
Membership.create({ organization: scc_org, participant: hannelie, title: 'Head of Booth', is_booth_chair: true })
Membership.create({ organization: axo_org, participant: hannelie})

rachel_user = User.new({ email: 'rcrown@andrew.cmu.edu', name: 'Rachel Crown'})
rachel_user.add_role :admin
rachel_user.save!
rachel = Participant.create({ andrewid: 'rcrown', phone_number: 6178617669, user: rachel_user })
Membership.create({ organization: scc_org, participant: rachel, is_booth_chair: true })
Membership.create({ organization: kat_org, participant: rachel })

tim_user = User.new({ email: 'leonardt@andrew.cmu.edu', name: 'Tim Leonard'})
tim_user.add_role :admin
tim_user.save!
tim = Participant.create({ andrewid: 'leonardt', phone_number: 4122688704, user: tim_user })
Membership.create({ organization: scc_org, participant: tim, title: 'Coordinator of Student Activities', is_booth_chair: true })
Membership.create({ organization: dosa_org, participant: tim, title: 'Coordinator of Student Activities', is_booth_chair: true })

chase_user = User.new({ email: 'cbrownel@andrew.cmu.edu', name: 'Chase'})
chase_user.add_role :admin
chase_user.save!
chase = Participant.create({ andrewid: 'cbrownel', phone_number: 1713435788, user: chase_user })
Membership.create({ organization: scc_org, participant: chase, title: 'Alumni Webmaster' })
Membership.create({ organization: dtd_org, participant: chase })

merichar_user = User.new({email: "meribyte@andrew.cmu.edu", name: "Meg" })
merichar_user.add_role :admin
merichar_user.save!
merichar = Participant.create({ andrewid: 'meribyte', phone_number: 8456424549, user: merichar_user })
Membership.create({ organization: scc_org, participant: merichar, title: 'Asst. Operations - Golf Carts & Webmaster' })

Participant.create([
  { andrewid: 'ngasbarr', phone_number: 9255777645 }
])

Membership.create([
  { participant: Participant.find_by_andrewid('ngasbarr'), organization: scc_org}
])

Membership.create([
  { participant: Participant.find_by_andrewid('ngasbarr'), organization: dtd_org }
])

# Booth Chairs ----------------------------------------------------------------
puts 'Booth Chairs'

Membership.create({ organization: aepi_org, participant: Participant.create({ andrewid: 'bgardine', phone_number: 7039948442}), is_booth_chair: true })
Membership.create({ organization: aepi_org, participant: Participant.create({ andrewid: 'gya'}), is_booth_chair: true })
Membership.create({ organization: aepi_org, participant: Participant.create({ andrewid: 'ssharea'}), is_booth_chair: true })
Membership.create({ organization: axo_org, participant: Participant.create({ andrewid: 'bhunttob', phone_number: 2246009586}), is_booth_chair: true })
Membership.create({ organization: axo_org, participant: Participant.create({ andrewid: 'seanders', phone_number: 6107374187}), is_booth_chair: true })
Membership.create({ organization: axo_org, participant: Participant.create({ andrewid: 'vsivakum', phone_number: 9172444241}), is_booth_chair: true })
Membership.create({ organization: aphi_org, participant: Participant.create({ andrewid: 'kndu', phone_number: 7133444667}), is_booth_chair: true })
Membership.create({ organization: aphi_org, participant: Participant.create({ andrewid: 'lcody', phone_number: 3144485994}), is_booth_chair: true })
Membership.create({ organization: aphi_org, participant: Participant.create({ andrewid: 'nflorman', phone_number: 6199522671}), is_booth_chair: true })
Membership.create({ organization: aphi_org, participant: Participant.create({ andrewid: 'vpereira'}), is_booth_chair: true })
Membership.create({ organization: aphi_org, participant: Participant.create({ andrewid: 'zhangw'}), is_booth_chair: true })
Membership.create({ organization: aphio_org, participant: Participant.create({ andrewid: 'fla', phone_number: 8143312119}), is_booth_chair: true })
Membership.create({ organization: asa_org, participant: Participant.create({ andrewid: 'bjli', phone_number: 9785057460}), is_booth_chair: true })
Membership.create({ organization: asa_org, participant: Participant.create({ andrewid: 'jylu', phone_number: 6095329694}), is_booth_chair: true })
Membership.create({ organization: astro_org, participant: Participant.create({ andrewid: 'amarano', phone_number: 9144209281}), is_booth_chair: true })
Membership.create({ organization: astro_org, participant: Participant.create({ andrewid: 'oce', phone_number: 2675950677}), is_booth_chair: true })
Membership.create({ organization: ddd_org, participant: Participant.create({ andrewid: 'gjackson', phone_number: 4124207887}), is_booth_chair: true })
Membership.create({ organization: ddd_org, participant: Participant.create({ andrewid: 'csharkey', phone_number: 6142579397}), is_booth_chair: true })
Membership.create({ organization: ddd_org, participant: Participant.create({ andrewid: 'smosshor'}), is_booth_chair: true })
Membership.create({ organization: dg_org, participant: Participant.create({ andrewid: 'atjones', phone_number: 4438444424}), is_booth_chair: true })
Membership.create({ organization: dg_org, participant: Participant.create({ andrewid: 'casantil', phone_number: 6104208343}), is_booth_chair: true })
Membership.create({ organization: dg_org, participant: Participant.create({ andrewid: 'elawlis', phone_number: 8326930740}), is_booth_chair: true })
Membership.create({ organization: dg_org, participant: Participant.create({ andrewid: 'lcwillia', phone_number: 2677461544}), is_booth_chair: true })
Membership.create({ organization: dg_org, participant: Participant.create({ andrewid: 'tyv', phone_number: 6469431119}), is_booth_chair: true })
Membership.create({ organization: dtd_org, participant: Participant.create({ andrewid: 'aperley', phone_number: 7202522781}), is_booth_chair: true })
Membership.create({ organization: dtd_org, participant: Participant.create({ andrewid: 'achisolm', phone_number: 6315468835}), is_booth_chair: true })
Membership.create({ organization: dtd_org, participant: Participant.create({ andrewid: 'haozheg', phone_number: 9084034261}), is_booth_chair: true })
Membership.create({ organization: dtd_org, participant: Participant.create({ andrewid: 'rmckinne', phone_number: 9419141174}), is_booth_chair: true })
Membership.create({ organization: dtd_org, participant: Participant.create({ andrewid: 'tfs', phone_number: 7173195528}), is_booth_chair: true })
Membership.create({ organization: fringe_org, participant: Participant.create({ andrewid: 'jacobbro', phone_number: 5037479771}), is_booth_chair: true })
Membership.create({ organization: fringe_org, participant: Participant.create({ andrewid: 'jzak', phone_number: 4127351981}), is_booth_chair: true })
Membership.create({ organization: fringe_org, participant: Participant.create({ andrewid: 'kkwilkin', phone_number: 7077380375}), is_booth_chair: true })
Membership.create({ organization: kat_org, participant: Participant.create({ andrewid: 'aritchie', phone_number: 2155108559}), is_booth_chair: true })
Membership.create({ organization: kat_org, participant: Participant.create({ andrewid: 'ihlee', phone_number: 9713408528}), is_booth_chair: true })
Membership.create({ organization: kat_org, participant: Participant.create({ andrewid: 'rwolfing', phone_number: 9259897941}), is_booth_chair: true })
Membership.create({ organization: kat_org, participant: Participant.create({ andrewid: 'snarburg', phone_number: 6094770540}), is_booth_chair: true })
Membership.create({ organization: kkg_org, participant: Participant.create({ andrewid: 'amcnulty', phone_number: 7816904444}), is_booth_chair: true })
Membership.create({ organization: kkg_org, participant: Participant.create({ andrewid: 'acrigler', phone_number: 2038324033}), is_booth_chair: true })
Membership.create({ organization: kkg_org, participant: Participant.create({ andrewid: 'clohman', phone_number: 3109717909}), is_booth_chair: true })
Membership.create({ organization: kkg_org, participant: Participant.create({ andrewid: 'jry', phone_number: 6107376024}), is_booth_chair: true })
Membership.create({ organization: kapsig_org, participant: Participant.create({ andrewid: 'efiedore', phone_number: 7138066105}), is_booth_chair: true })
Membership.create({ organization: kapsig_org, participant: Participant.create({ andrewid: 'jbarry', phone_number: 2403837698}), is_booth_chair: true })
Membership.create({ organization: kapsig_org, participant: Participant.create({ andrewid: 'ajcollin'}), is_booth_chair: true })
Membership.create({ organization: kgb_org, participant: Participant.create({ andrewid: 'sctoor', phone_number: 7033029956}), is_booth_chair: true })
Membership.create({ organization: kgb_org, participant: Participant.create({ andrewid: 'sguertin', phone_number: 8029893063}), is_booth_chair: true })
Membership.create({ organization: math_org, participant: Participant.create({ andrewid: 'anqiwang', phone_number: 4123706158}), is_booth_chair: true })
Membership.create({ organization: math_org, participant: Participant.create({ andrewid: 'colinkel', phone_number: 5714490561}), is_booth_chair: true })
Membership.create({ organization: math_org, participant: Participant.create({ andrewid: 'dmehrle', phone_number: 6144588176}), is_booth_chair: true })
Membership.create({ organization: math_org, participant: Participant.create({ andrewid: 'kborst', phone_number: 9143299391}), is_booth_chair: true })
Membership.create({ organization: math_org, participant: Participant.create({ andrewid: 'zng', phone_number: 4434735523}), is_booth_chair: true })
Membership.create({ organization: mayur_org, participant: Participant.create({ andrewid: 'gauryn', phone_number: 4123200623}), is_booth_chair: true })
Membership.create({ organization: mcs_org, participant: Participant.create({ andrewid: 'kaitlinh', phone_number: 9142153025}), is_booth_chair: true })
Membership.create({ organization: mcs_org, participant: Participant.create({ andrewid: 'jiyunkwo', phone_number: 4128633273}), is_booth_chair: true })
Membership.create({ organization: phidelt_org, participant: Participant.create({ andrewid: 'resposit'}), is_booth_chair: true })
Membership.create({ organization: sdc_org, participant: Participant.create({ andrewid: 'kswarts', phone_number: 5702491340}), is_booth_chair: true })
Membership.create({ organization: sae_org, participant: Participant.create({ andrewid: 'ambaker', phone_number: 4125267380}), is_booth_chair: true })
Membership.create({ organization: sae_org, participant: Participant.create({ andrewid: 'kschin', phone_number: 6319884058}), is_booth_chair: true })
Membership.create({ organization: sae_org, participant: Participant.create({ andrewid: 'drmorale'}), is_booth_chair: true })
Membership.create({ organization: sigchi_org, participant: Participant.create({ andrewid: 'pdominic', phone_number: 9788534116}), is_booth_chair: true })
Membership.create({ organization: sigep_org, participant: Participant.create({ andrewid: 'bsiegel', phone_number: 2074752240}), is_booth_chair: true })
Membership.create({ organization: sigep_org, participant: Participant.create({ andrewid: 'sjstark', phone_number: 9049622490}), is_booth_chair: true })
Membership.create({ organization: spirit_org, participant: Participant.create({ andrewid: 'jmonroe', phone_number: 2035814082}), is_booth_chair: true })
Membership.create({ organization: ssa_org, participant: Participant.create({ andrewid: 'zunyibrt', phone_number: 4125195516}), is_booth_chair: true })
Membership.create({ organization: ssa_org, participant: Participant.create({ andrewid: 'jechua', phone_number: 4126239206}), is_booth_chair: true })
Membership.create({ organization: earth_org, participant: Participant.create({ andrewid: 'alexchen', phone_number: 6308095728}), is_booth_chair: true })
Membership.create({ organization: earth_org, participant: Participant.create({ andrewid: 'htomio', phone_number: 3126622539}), is_booth_chair: true })
Membership.create({ organization: tsa_org, participant: Participant.create({ andrewid: 'kywang1', phone_number: 8583662883}), is_booth_chair: true })
Membership.create({ organization: tsa_org, participant: Participant.create({ andrewid: 'hsienhsi', phone_number: 4123528929}), is_booth_chair: true })

# Charge Types ----------------------------------------------------------------
puts 'Charge Types'
ChargeType.create([
  { name: 'Store Purchase' },
  { name: 'Watch Shift – Failure to comply', description: 'Watch Shift refused to complete assigned duties. Fine Per Violation', default_amount: 25 },
  { name: 'Watch Shift – Failure to remain', description: 'Watch Shift left before being dismissed. Fine Per Person', default_amount: 25 },
  { name: 'Watch Shift – Tardiness', description: 'Less than 10 mins late; Note: enter watch shift – tardiness (Pending Approval) with a $0 fine and enter if one or both people were late in the description' },
  { name: 'Watch Shift – Missed', description: 'Greater than 10 mins late or sent home because drunk; Note: enter as “missed watch shift (pending approval)” with a $0 fine and how many people in the description; If they show up 10-45 mins late but complete their obligations, fine will be cut in half' },
  { name: 'Clean Up Hours', description: '6 man-hours to clean up Midway pre-opening by each org. Fine Per Hour', default_amount: 50 },
  { name: 'Hardhat, Waiver, or Wristband Missing', description: 'Any member found on Midway not wearing a hardhat, without a signed waiver, or not wearing a wristband. Fine Per Person', default_amount: 15 },
  { name: 'Failure to comply with SCC/SOC', description: 'Failure to comply with a request by SCC or Structural Oversight Committee to structurally alter a booth.', default_amount: 100 },
  { name: 'Deviation from plans', description: 'Changing of building or structural plans without approval. Fine to be determined by Rules Committee' },
  { name: 'Vehicle assisted demolition' },
  { name: 'Teardown' },
  { name: 'Broken or Lost Tool/Hardhat' },
  { name: 'Post-Teardown Cage Cleanup' },
  { name: 'Unapproved electrical plug in', description: 'Connecting wired booth to power supply without approval', default_amount: 100 },
  { name: 'Unsafe electrical practice', description: 'At the discretion of SCC electrical committee. May be appealed to Rules Committee.', default_amount: 200 },
  { name: 'Tripped Breaker', description: 'Circuit breaker tripped. Determined by Electrical Committee.', default_amount: 25 },
  { name: 'Unauthorized person on Midway', description: 'Person found during closed hours of Midway potentially altering a booth, for example. Fine Per Person', default_amount: 25 },
  { name: 'Booth Staffing Fine', description: 'Intoxicated person staffing a booth' },
  { name: 'Failure to Clean Plot', description: 'Org fails to clean plot as directed by SCC or fails to confirm with SCC that plot is clean before leaving', default_amount: 25 },
  { name: 'Vehicle on Midway', description: 'Unauthorized vehicle of an org on Midway. Fine to be determined by Rules Committee' },
  { name: 'Late Plans' },
  { name: 'Missed Training or Meeting' },
  { name: 'Other', description: 'Other violation as determined by the coordinator, please document extensively and inform the Midway Chair incase any problems arise.', requires_booth_chair_approval: true }
])

# FAQs ------------------------------------------------------------------------
puts "FAQs"

Faq.create([
  { question: "What is Booth?",
    answer:  "Booth is one of the biggest showpieces of Spring Carnival. Student organizations build multi-story structures around our annual theme (2014: Best of the Best), hosting interactive games and elaborate decorations. The booths will be placed on Midway, which is located in the Morewood Gardens Parking Lot." },
  { question: "What do I do if something catches on fire?",
    answer: "There are fire extinguishers located at every booth. Take one and follow the instructions listed on the can." },
  { question: "Where does CMU get money for Carnival?",
    answer: "Carnegie Mellon University's Spring Carnival is funded in part by your Student Activities Fee." },
  { question: "What are the hours of rides?",
    answer: "TBD" },
  { question: "How much are rides tickets?",
    answer: "TBD" },
  { question: "Are there group rates for rides tickets?",
    answer: "No." },
  { question: "Where do you pick up presale tickets?",
    answer: "UC Info Desk" },
  { question: "Can I get a wristband for the comedian?",
    answer: "Spring Carnival does not deal with the comedian. Talk to AB." },
  { question: "Where do I go for the green room security shift?",
    answer: "Morewood multipurpose room. You need a radio and jackets. And no, you cannot eat the food." },
  { question: "What do I do if the comedian shows up?",
    answer: "Call student activities (Tim)." },
  { question: "Alumni is complaining about their tent.",
    answer: "Call the Head of Operations." },
  { question: "Alumni needs something special.",
    answer: "Call the Head of Operations." },
  { question: "When do dumpsters go out?",
    answer: "They must be by the back of Morewood lot by 5am." },
  { question: "What is downtime?",
    answer: "When a booth takes time to close their booth and have it not manned during operations. They must register the start of their downtime (you should track this) and put caution tape up to close off the doorways. They should also tell you when they are ending their downtime." },
  { question: "How much downtime does an org get?",
    answer: "4 hours." },
  { question: "How do I check how much downtime an org has left?",
    answer: "TBD" },
  { question: "A booth tripped a breaker. What do I do?",
    answer: "Add them to the Electrical queue. Mark the fine in app if applicable." },
  { question: "Someone has a minor injury (splinter, small cut, dust in eye, etc.).",
    answer: "Give them equipment from the medical kit in the trailer. Tell them they can call EMS if they want. DO NOT ADMINISTER MEDICAL ASSISTANCE." },
  { question: "EMS is closed. What do I do?",
    answer: "Call them." },
  { question: "I saw an ambulance take someone to the hospital. What do I do?",
    answer: "Call the Carnival Chairi, Head of Booth, and/or Head of Operations immediately." },
  { question: "Someone wants to drop off in the firelane. Can they do that?",
    answer: "No, unless they are Cyert, food delivery for Underground, fire, police, EMS, FMS, people with passes, or an approved delivery (Rachel, Emily, or Jackson says it's OK)." },
  { question: "Golf cart problem?",
    answer: "Call Meg." },
  { question: "Missing golf cart.",
    answer: "Call Meg." },
  { question: "If someone legitimately needs a golf cart...",
    answer: "...radio for golfcart." },
  { question: "A booth chair is freaking out, sad, angry, etc. What do I do?",
    answer: "Call the Head of Booth." },
  { question: "University official wants to borrow something. What do I do?",
    answer: "Let them. They do not need to sign a waiver. Ideally, check it out to Jackson, Emily, or Rachel to track it in the app." },
  { question: "The next coordinator doesn't show up. What do I do?",
    answer: "Call them repeatedly. If that fails, call the Head of Operations." },
  { question: "Booth watch shift doesn't show up. What do I do?",
    answer: "Do not let previous watch shift leave. Call booth chairs of that org in order until someone answers. Fine them accordingly in the app. If no one can show up and old watch shift has to leave, split the other watch shift." },
  { question: "Drunk people won't listen. What do I do?",
    answer: "Call the police." },
  { question: "Booth chair is asking questions I don't understand. What do I do?",
    answer: "Put them in Rachel's queue. Leave a note if necessary." },
  { question: "Parking complains about Asian row. What do I do?",
    answer: "Tell Asian row to clear their stuff out. If they won't listen, call Rachel." },
  { question: "What should the 12am-4am watch shifts do?",
    answer: "MOVE THE DUMPSTERS TO THE FIRELANE BY THE TENT. Check the radio station parking lot. Make sure no one is doing anything stupid (climbing on roofs, having sex in booths, etc.)." },
  { question: "What's the difference between a security and watch shift?",
    answer: "Security is paid, watch is not. Watch shifts are booth orgs, while security are non-building orgs." },
  { question: "What do I do with my drunk watch/security shift that just showed up?",
    answer: "Send them home, call their booth chair, and inform them of what happened and that they are getting fined unless they supply new, sober people." },
  { question: "AB tech asks for the keys to the scissor lift.",
    answer: "Call the Head of Operations." },
  { question: "Taylor Rental needs something.",
    answer: "Call the Head of Operations." },
  { question: "Where do I find the midway layout?",
    answer: "In the app, under documents!" },
  { question: "Madelyn Miller calls. What do I do?",
    answer: "Listen to her. Then call Emily/Jackson/Rachel and relay the message." },
  { question: "It's raining and people are losing electricity.",
    answer: "Wait until the rain stops, then tell them to suck it up and we'll deal with it." },
  { question: "It's super windy. Things are flying off of booths.",
    answer: "Check weather on trailer computer. Call the Head of Booth and the Carnival Chair with that information." }
])

# Organization Status Types --------------------------------------------------
puts 'Organization Status Types'
OrganizationStatusType.create([
  { name: "Note", display: false },
  { name: "Electrical Partly Inspected", display: true },
  { name: "Electrical Approved", display: true },
  { name: "Wednesday Inspection Completed", display: true },
  { name: "Final Inspection Passed", display: true }
])

# Shift Types ----------------------------------------------------------------
puts 'Shift Types'
watch_shift = ShiftType.create({ name: 'Watch Shift' })
sec_shift = ShiftType.create({ name: 'Security Shift' })
coord_shift = ShiftType.create({ name: 'Coordinator Shift' })

# Shifts ---------------------------------------------------------------------
puts 'Shifts'

move_on = DateTime.rfc3339('2015-04-10T00:00:00-04:00')
build_saturday = move_on + 1.day
build_sunday = move_on + 2.days
monday = move_on + 2.days
tuesday = move_on + 3.days
wednesday = move_on + 4.days
operations = move_on + 5.days
ops_friday = move_on + 6.days
ops_saturday = move_on + 7.days
teardown = move_on + 8.days

# Coordinator Shifts
puts '  Coordinator Shifts'
#shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2015-04-11T16:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-04T16:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
#ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('arakla'), clocked_in_at: Time.now })

# Watch Shifts
puts '  Watch Shifts'
#Shift.create([
#  { shift_type: watch_shift, starts_at: DateTime.strptime('4/13/2015 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/13/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:ssa_org, required_number_of_participants: 2 }
#])

# Security Shifts
#puts '  Security Shifts'

puts 'Tasks'
puts '  One-Time Tasks'
Task.create([
  { name: 'Towing for Move On Begins', description: 'Any cars remaining on Morewood Lot after 5pm will be towed.', due_at: move_on + 14.hours },
  { name: 'Move On Begins', description: 'Orgs start moving on to Midway', due_at: move_on + 18.hours },
  { name: 'Final Booth Inspections', description: 'The University will show up to Midway. Help them find the Head of Booth so that they can inspect the state of the booths.', due_at: wednesday + 12.hours },
  { name: 'Construction Ends', description: 'All but 4 members (full-size) or 2 members (blitz) of each org must clear Midway.', due_at: operations + 13.hours },
  { name: 'Call for Cleaning Helpers', description: 'Each org must send 2 members at 1pm to the trailer to assist with Midway clean-up', due_at: operations + 13.hours },
  { name: 'Final Fixes End', description: '4 members (full-size) or 2 members (blitz) of each org may stay to make final fixes between 1pm and 2:30pm. Everyone must be gone from Midway at 2:30pm.', due_at: operations + 14.hours + 30.minutes },
  { name: 'Opening Ceremony', description: 'Speeches, ribbon cutting, and Midway officially opens to the public.', due_at: operations + 15.hours },
  { name: 'Judging Begins', description: 'Judges will arrive with Rachel and will judge each booth. No, we do not have a schedule of which booths will be judged when. Sorry.', due_at: ops_friday + 13.hours },
  { name: 'Concert', description: 'The Concert! On the mall. Rain location: Wiegand Gym. Student opener at 7:30pm.', due_at: ops_friday + 19.hours + 30.minutes },
  { name: 'Night Judging Ends', description: 'Judges will wander around Midway to judge booths after dusk and will return their packets/tablets after. Put them in the box, The Head of Booth or someone else will come get them later.', due_at: ops_friday + 20.hours },
  { name: 'Fireworks', description: 'Following the concert, pretty things go boom in the sky. Also on the mall. Cancelled in the case of rain.', due_at: ops_friday + 22.hours },
  { name: 'Move Chairs for Awards', description: 'Send shifts to clear the chairs from the main tent to prepare for awards', due_at: ops_saturday + 16.hours + 15.minutes },
  { name: 'Awards', description: 'Orgs will rush the main tent to find out who won. Awards involve both buggy and booth.', due_at: ops_saturday + 17.hours },
  { name: 'Dumpsters for Teardown Arrive', description: 'Company should have layout and should drop dumpsters into place. Dumpster layout is in the documents section, if you need to reference it.', due_at: teardown + 6.hours },
  { name: 'Start of Teardown', description: 'Orgs may begin to teardown no earlier than 8am. They must begin by 10am.', due_at: ops_saturday + 8.hours },
  { name: 'End of Teardown', description: 'At this time, all orgs should be completed cleared from Midway. If they are not, fining begins at a rate of $1/hr until 5:30, $5 until 6pm, and $10 after 6pm.', due_at: teardown + 17.hours }
])

puts '  Recurring Tasks'
 Task.create([
  { name: 'Move dumpsters', description: 'Have a watch shift move dumpsters to the gate by the tent by 6am', due_at: build_saturday + 6.hours},
  { name: 'Move dumpsters', description: 'Have a watch shift move dumpsters to the gate by the tent by 6am', due_at: build_sunday + 6.hours },
  { name: 'Move dumpsters', description: 'Have a watch shift move dumpsters to the gate by the tent by 6am', due_at: monday + 6.hours},
  { name: 'Move dumpsters', description: 'Have a watch shift move dumpsters to the gate by the tent by 6am', due_at: tuesday + 6.hours},
  { name: 'Move dumpsters', description: 'Have a watch shift move dumpsters to the gate by the tent by 6am', due_at: wednesday + 6.hours},
  { name: 'Move dumpsters', description: 'Have a watch shift move dumpsters to the gate by the tent by 6am', due_at: operations +6.hours },
  { name: 'Check Perimeter', description: 'Make sure that Asian Row +AEPI is not out in the lot and that no one is building in the WQED Parking Lot. Also fix snow fencing.', due_at: build_saturday + 1.hour },
  { name: 'Check Perimeter', description: 'Make sure that Asian Row +AEPI is not out in the lot and that no one is building in the WQED Parking Lot. Also fix snow fencing.', due_at: build_sunday + 1.hour },
  { name: 'Check Perimeter', description: 'Make sure that Asian Row +AEPI is not out in the lot and that no one is building in the WQED Parking Lot. Also fix snow fencing.', due_at: monday + 1.hour},
  { name: 'Check Perimeter', description: 'Make sure that Asian Row +AEPI is not out in the lot and that no one is building in the WQED Parking Lot. Also fix snow fencing.', due_at: tuesday + 1.hour},
  { name: 'Check Perimeter', description: 'Make sure that Asian Row +AEPI is not out in the lot and that no one is building in the WQED Parking Lot. Also fix snow fencing.', due_at: wednesday + 1.hour},
  { name: 'Check Perimeter', description: 'Make sure that Asian Row +AEPI is not out in the lot and that no one is building in the WQED Parking Lot. Also fix snow fencing.', due_at: operations + 1.hour},
  { name: 'Check Perimeter', description: 'Make sure that Asian Row +AEPI is not out in the lot and that no one is building in the WQED Parking Lot. Also fix snow fencing.', due_at: ops_friday + 1.hour},
  { name: 'Check Perimeter', description: 'Make sure that Asian Row +AEPI is not out in the lot and that no one is building in the WQED Parking Lot. Also fix snow fencing.', due_at: ops_saturday + 1.hour},
  { name: 'Check Perimeter', description: 'Make sure that Asian Row +AEPI is not out in the lot and that no one is building in the WQED Parking Lot. Also fix snow fencing.', due_at: teardown + 1.hour},
  { name: 'Midway Opens', description: '2 members from each org are allowed on Midway 15 mins before opening, but that is it.', due_at: operations + 15.hours},
  { name: 'Midway Opens', description: '2 members from each org are allowed on Midway 15 mins before opening, but that is it.', due_at: ops_friday + 11.hours},
  { name: 'Midway Opens', description: '2 members from each org are allowed on Midway 15 mins before opening, but that is it.', due_at: ops_saturday + 11.hours},
  { name: 'Midway Closes', description: '2 members from each org are allowed on Midway up until 15 mins after closing, but everyone else must clear out.', due_at: operations + 23.hours},
  { name: 'Midway Closes', description: '2 members from each org are allowed on Midway up until 15 mins after closing, but everyone else must clear out.', due_at: ops_friday + 23.hours},
  { name: 'Midway Closes', description: '2 members from each org are allowed on Midway up until 15 mins after closing, but everyone else must clear out.', due_at: ops_saturday + 23.hours },
  { name: 'Quiet Hours Start', description: 'No more loud noise on Midway. If you can hear something outside a booth it\'s probably too loud, if you can hear it at the trailer then it\'s WAY too loud. Don\'t want to wake the neighbors. Tell booth orgs, "Shh, time to go to bed..."', due_at: move_on + 22.hours},
  { name: 'Quiet Hours Start', description: 'No more loud noise on Midway. If you can hear something outside a booth it\'s probably too loud, if you can hear it at the trailer then it\'s WAY too loud. Don\'t want to wake the neighbors. Tell booth orgs, "Shh, time to go to bed..."', due_at: build_saturday + 22.hours },
  { name: 'Quiet Hours Start', description: 'No more loud noise on Midway. If you can hear something outside a booth it\'s probably too loud, if you can hear it at the trailer then it\'s WAY too loud. Don\'t want to wake the neighbors. Tell booth orgs, "Shh, time to go to bed..."', due_at: build_sunday + 22.hours },
  { name: 'Quiet Hours Start', description: 'No more loud noise on Midway. If you can hear something outside a booth it\'s probably too loud, if you can hear it at the trailer then it\'s WAY too loud. Don\'t want to wake the neighbors. Tell booth orgs, "Shh, time to go to bed..."', due_at: monday + 22.hours},
  { name: 'Quiet Hours Start', description: 'No more loud noise on Midway. If you can hear something outside a booth it\'s probably too loud, if you can hear it at the trailer then it\'s WAY too loud. Don\'t want to wake the neighbors. Tell booth orgs, "Shh, time to go to bed..."', due_at: tuesday + 22.hours },
  { name: 'Quiet Hours Start', description: 'No more loud noise on Midway. If you can hear something outside a booth it\'s probably too loud, if you can hear it at the trailer then it\'s WAY too loud. Don\'t want to wake the neighbors. Tell booth orgs, "Shh, time to go to bed..."', due_at: wednesday + 22.hours},
  { name: 'Quiet Hours End', description: 'Noise is allowed again. Hooray Power Tools!', due_at: build_saturday + 7.hours },
  { name: 'Quiet Hours End', description: 'Noise is allowed again. Hooray Power Tools!', due_at: build_sunday + 7.hours },
  { name: 'Quiet Hours End', description: 'Noise is allowed again. Hooray Power Tools!', due_at: monday + 7.hours },
  { name: 'Quiet Hours End', description: 'Noise is allowed again. Hooray Power Tools!', due_at: tuesday + 7.hours },
  { name: 'Quiet Hours End', description: 'Noise is allowed again. Hooray Power Tools!', due_at: wednesday + 7.hours },
  { name: 'Quiet Hours End', description: 'Noise is allowed again. Hooray Power Tools!', due_at: operations + 7.hours }
 ])


case Rails.env
when 'production'
  puts 'Tools'
  # Tools -----------------------------------------------------------------------
  generate_tools
when 'development'
  puts
  puts 'Extra Dev Goodness:'
  puts


  pat_user = User.new({ email: 'rpwhite@andrew.cmu.edu', name: 'Pat'})
  pat_user.save!
  pat = Participant.create({ andrewid: 'rpwhite', phone_number: 1713435788, user: pat_user })
  Membership.create({ organization: dtd_org, participant: pat, is_booth_chair: true })

  chase_user.remove_role :admin
  chase_user.save!

  nick_user = User.new({ email: 'nharper@andrew.cmu.edu', name: 'Nick'})
  nick_user.save!
  nick = Participant.create({ andrewid: 'nharper', phone_number: 1713435788, user: nick_user })
  Membership.create({ organization: dtd_org, participant: nick })

  puts 'Old Stuff...'
 tool = Tool.create({ name: 'Hammer', barcode: 7, description: 'it\'s a hammer' })
  Tool.create([
    {name: 'Hardhat', barcode: 111, description: 'Org Hardhat (White)'},
    {name: 'SCC Hardhat', barcode: 112, description: 'SCC Hardhat (Blue)'},
    {name: 'EH&S Hardhat', barcode: 115, description: 'Environmental Health and Safety Hardhat (Bright Yellow/Green)'},
    {name: 'Chair Hardhat', barcode: 113, description: 'Booth Chair Hardhat (Orange)'}])
  Checkout.create({ tool: Tool.find(2), participant: chase, organization: dtd_org, checked_out_at: Time.now - 5.hours })
  Checkout.create({ tool: Tool.find(2), participant: chase, organization: dtd_org, checked_out_at: Time.now - 8.hours, checked_in_at: Time.now - 7.hours })
 shift = Shift.create({ shift_type: ShiftType.find_by_name('Watch Shift'), organization: dtd_org, starts_at: Time.now - 1.hours, ends_at: Time.now + 1.hours, required_number_of_participants: 1 })
  Shift.create({ shift_type: ShiftType.find_by_name('Watch Shift'), organization: dtd_org, starts_at: Time.now - 3.hours, ends_at: Time.now - 1.hour, required_number_of_participants: 1 })
  Shift.create({ shift_type: ShiftType.find_by_name('Watch Shift'), organization: dtd_org, starts_at: Time.now + 1.hours, ends_at: Time.now + 15.hours, required_number_of_participants: 1 })
  ShiftParticipant.create({ shift: shift, participant: chase, clocked_in_at: Time.now - 50.minutes })

  Charge.create({ charge_type: ChargeType.find_by_name('Blown Breaker'), amount: 25, description: 'Delt blew their breaker all over midway', issuing_participant: merichar, receiving_participant: chase, organization: dtd_org, charged_at: Time.now })

  # Tasks ---
  Task.create([{ name: "todo", due_at: Time.now + 1.hour, description: "Many things" },
    {name: "done0", due_at: Time.now, completed_by: chase, is_completed: true },
    {name: "done1", due_at: Time.now, completed_by: chase, is_completed: true },
    {name: "done2", due_at: Time.now, completed_by: chase, is_completed: true },
    {name: "not done1", due_at: Time.now + 1.hour, completed_by: chase, is_completed: true },
    {name: "not done2", due_at: Time.now + 1.hour, completed_by: chase, is_completed: true },
    {name: "not done3", due_at: Time.now + 1.hour, completed_by: chase, is_completed: true },
    {name: "late1", due_at: Time.now - 30.minutes },
    {name: "late2", due_at: Time.now - 30.minutes },
    {name: "late3", due_at: Time.now - 30.minutes }
  ])
end
