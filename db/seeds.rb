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
sae_org = Organization.create({ name: 'Sigma Alpha Epsilon', organization_category: blitz, short_name: 'SAE' })
spirit_org = Organization.create({ name: 'Spirit', organization_category: blitz })
phidelt_org = Organization.create({ name: 'Phi Delta Theta', organization_category: blitz, short_name: 'PhiDelt' })
#lambda_org = Organization.create({ name: 'Lambda Phi Epsilon', organization_category: blitz, short_name: 'Lambda' })
mudge_org = Organization.create({ name: 'Mudge', organization_category: blitz })
#stever_org = Organization.create({ name: 'Stever', organization_category: blitz })

puts '  Non-Building'
crew_org = Organization.create({ name: 'Crew', organization_category: non_building })
  OrganizationAlias.create({ organization: crew_org, name: 'Rowing' })
the_os_org = Organization.create({ name: 'The Originals', organization_category: non_building, short_name: 'The O\'s' })
pike_org = Organization.create({ name: 'Pi Kappa Alpha', organization_category: non_building, short_name: 'Pike' })
  OrganizationAlias.create({ organization: pike_org, name: 'Pika' })
polo_org = Organization.create({ name: 'Water Polo', organization_category: non_building, short_name: 'Polo' })
habitat_org = Organization.create({ name: 'Habitat for Humanity', organization_category: non_building, short_name: 'Habitat' })

# SCC Members -----------------------------------------------------------------
puts 'SCC Members (not exhaustive)'
rachel_user = User.new({ email: 'rcrown@andrew.cmu.edu', name: 'Rachel Crown'})
rachel_user.add_role :admin
rachel_user.save!
rachel = Participant.create({ andrewid: 'rcrown', phone_number: 6178617669, user: rachel_user })
Membership.create({ organization: scc_org, participant: rachel, title: 'Midway Chair', is_booth_chair: true })
Membership.create({ organization: kat_org, participant: rachel })

emily_user = User.new({ email: 'ehrin@andrew.cmu.edu', name: 'Emily Hrin' })
emily_user.add_role :admin
emily_user.save!
emily = Participant.create({ andrewid: 'ehrin', phone_number: 7037854617, user: emily_user })
Membership.create({ organization: scc_org, participant: emily, title: 'Carnival Co-Chair', is_booth_chair: true })
Membership.create({ organization: aphi_org, participant: emily })

jackson_user = User.new({ email: 'jgallagh@andrew.cmu.edu', name: 'Jackson Gallagher' })
jackson_user.add_role :admin
jackson_user.save!
jackson = Participant.create({ andrewid: 'jgallagh', phone_number: 9376847115, user: jackson_user })
Membership.create({ organization: scc_org, participant: jackson, title: 'Carnival Co-Chair', is_booth_chair: true })
Membership.create({ organization: dtd_org, participant: jackson })

tim_user = User.new({ email: 'leonardt@andrew.cmu.edu', name: 'Tim Leonard'})
tim_user.add_role :admin
tim_user.save!
tim = Participant.create({ andrewid: 'leonardt', phone_number: 4122688704, user: tim_user })
Membership.create({ organization: scc_org, participant: tim, title: 'Coordinator of Student Activities', is_booth_chair: true })
Membership.create({ organization: dosa_org, participant: tim, title: 'Coordinator of Student Activities', is_booth_chair: true })

hank_user = User.new({ email: 'mhankows@andrew.cmu.edu', name: 'Hank'})
hank_user.add_role :admin
hank_user.save!
hank = Participant.create({ andrewid: 'mhankows', phone_number: 2159391658, user: hank_user })
Membership.create({ organization: scc_org, participant: hank, title: 'Treasurer' })
Membership.create({ organization: dtd_org, participant: hank })

chase_user = User.new({ email: 'cbrownel@andrew.cmu.edu', name: 'Chase'})
chase_user.add_role :admin
chase_user.save!
chase = Participant.create({ andrewid: 'cbrownel', phone_number: 1713435788, user: chase_user })
Membership.create({ organization: scc_org, participant: chase, title: 'Web Troll' })
Membership.create({ organization: dtd_org, participant: chase })

Participant.create([
{ andrewid: 'amartine', phone_number: 9255777645 },
{ andrewid: 'jcmertz' },
{ andrewid: 'mtai', phone_number: 5104159639 },
{ andrewid: 'ncoauett', phone_number: 8183991074 },
{ andrewid: 'prheinhe', phone_number: 7082613175 },
{ andrewid: 'rdalal', phone_number: 6097121122 },
{ andrewid: 'cssmith', phone_number: 8587364940 },
{ andrewid: 'amort' },
{ andrewid: 'cweintra', phone_number: 2038309156 },
{ andrewid: 'ejsolomo', phone_number: 2037257024 },
{ andrewid: 'laurenmi', phone_number: 9082091492 },
{ andrewid: 'nettling', phone_number: 7816087010 },
{ andrewid: 'snanda', phone_number: 6312756531 },
{ andrewid: 'tchitten', phone_number: 4252136112 },
{ andrewid: 'crockoff', phone_number: 8189174979 },
{ andrewid: 'bdshih' },
{ andrewid: 'hloo' },
{ andrewid: 'mbignell', phone_number: 8313450639 },
{ andrewid: 'mcahill', phone_number: 5703358167 },
{ andrewid: 'michell2' },
{ andrewid: 'wavil', phone_number: 7034093855 },
{ andrewid: 'arakla', phone_number: 2817692637 },
{ andrewid: 'dmiele' },
{ andrewid: 'egarbade', phone_number: 9734944492 },
{ andrewid: 'ekarras' },
{ andrewid: 'ise', phone_number: 9737967448 },
{ andrewid: 'vsivakum', phone_number: 9172444241 },
{ andrewid: 'msiko' },
{ andrewid: 'meribyte', phone_number: 8456424549 },
{ andrewid: 'rakhan' },
{ andrewid: 'dcbrout', phone_number: 9145238600 }
])

Membership.create([
{ participant: Participant.find_by_andrewid('nettling'), organization: scc_org, title: 'Operations Chair' },
{ participant: Participant.find_by_andrewid('mbignell'), organization: scc_org, title: 'Marketing Chair' },
{ participant: Participant.find_by_andrewid('msiko'), organization: scc_org, title: 'Special Ops Chair' },
{ participant: Participant.find_by_andrewid('dmiele'), organization: scc_org, title: 'Asst. Midway - Director of Electrical' },
{ participant: Participant.find_by_andrewid('wavil'), organization: scc_org, title: 'Asst. Midway - Director of Sorority' },
{ participant: Participant.find_by_andrewid('bdshih'), organization: scc_org, title: 'Asst. Midway - Director of Fraternity/Independent' },
{ participant: Participant.find_by_andrewid('mcahill'), organization: scc_org, title: 'Asst. Midway - Director of Fraternity/Independent' },
{ participant: Participant.find_by_andrewid('hloo'), organization: scc_org, title: 'Asst. Midway - Director of Blitz' },
{ participant: Participant.find_by_andrewid('cweintra'), organization: scc_org, title: 'Asst. Midway - Admin Coordinator' },
{ participant: Participant.find_by_andrewid('rdalal'), organization: scc_org, title: 'Asst. Marketing' },
{ participant: Participant.find_by_andrewid('jcmertz'), organization: scc_org, title: 'Asst. Operations - Entranceway' },
{ participant: Participant.find_by_andrewid('prheinhe'), organization: scc_org, title: 'Asst. Operations - Power' },
{ participant: Participant.find_by_andrewid('ejsolomo'), organization: scc_org, title: 'Asst. Operations - Parking' },
{ participant: Participant.find_by_andrewid('snanda'), organization: scc_org, title: 'Asst. Operations - Parking' },
{ participant: Participant.find_by_andrewid('meribyte'), organization: scc_org, title: 'Asst. Operations - Golf Carts' },
{ participant: Participant.find_by_andrewid('amort'), organization: scc_org, title: 'AB Tech Liaison' },
{ participant: Participant.find_by_andrewid('dcbrout'), organization: scc_org, title: 'EMS Liaison' },
{ participant: Participant.find_by_andrewid('ncoauett'), organization: scc_org, title: 'Asst. Operations' },
{ participant: Participant.find_by_andrewid('cssmith'), organization: scc_org, title: 'Asst. Operations' },
{ participant: Participant.find_by_andrewid('laurenmi'), organization: scc_org, title: 'Asst. Operations' },
{ participant: Participant.find_by_andrewid('tchitten'), organization: scc_org, title: 'Asst. Operations' },
{ participant: Participant.find_by_andrewid('crockoff'), organization: scc_org, title: 'Asst. Operations' },
{ participant: Participant.find_by_andrewid('arakla'), organization: scc_org, title: 'Asst. Operations' },
{ participant: Participant.find_by_andrewid('egarbade'), organization: scc_org, title: 'Asst. Operations' },
{ participant: Participant.find_by_andrewid('ekarras'), organization: scc_org, title: 'Asst. Operations' },
{ participant: Participant.find_by_andrewid('ise'), organization: scc_org, title: 'Asst. Operations' },
{ participant: Participant.find_by_andrewid('vsivakum'), organization: scc_org, title: 'Asst. Operations' },
{ participant: Participant.find_by_andrewid('michell2'), organization: scc_org },
{ participant: Participant.find_by_andrewid('amartine'), organization: scc_org },
{ participant: Participant.find_by_andrewid('mtai'), organization: scc_org },
{ participant: Participant.find_by_andrewid('rakhan'), organization: scc_org }
])

Membership.create([
{ participant: Participant.find_by_andrewid('mtai'), organization: ddd_org },
{ participant: Participant.find_by_andrewid('cweintra'), organization: kkg_org },
{ participant: Participant.find_by_andrewid('nettling'), organization: phidelt_org },
{ participant: Participant.find_by_andrewid('crockoff'), organization: kat_org },
{ participant: Participant.find_by_andrewid('bdshih'), organization: tsa_org },
{ participant: Participant.find_by_andrewid('hloo'), organization: ssa_org },
{ participant: Participant.find_by_andrewid('mbignell'), organization: kkg_org },
{ participant: Participant.find_by_andrewid('mcahill'), organization: ddd_org },
{ participant: Participant.find_by_andrewid('wavil'), organization: sigep_org },
{ participant: Participant.find_by_andrewid('arakla'), organization: sdc_org },
{ participant: Participant.find_by_andrewid('ekarras'), organization: axo_org },
{ participant: Participant.find_by_andrewid('dcbrout'), organization: dtd_org }
])

# Booth Chairs ----------------------------------------------------------------
puts 'Booth Chairs'

puts '  AXO'
Membership.create({ organization: axo_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'emadigan', phone_number: 5168497817 }), is_booth_chair: true })
Membership.create({ organization: axo_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'bflatley', phone_number: 5085665712 }), is_booth_chair: true })
Membership.create({ organization: axo_org, booth_chair_order: 3, participant: Participant.create({ andrewid: 'jteitelb', phone_number: 3038153575 }), is_booth_chair: true })

puts '  AEPi'
Membership.create({ organization: aepi_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'bgardine', phone_number: 7039948442 }), is_booth_chair: true })
Membership.create({ organization: aepi_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'bmittman', phone_number: 6263484219 }), is_booth_chair: true })

puts '  Alpha Phi'
Membership.create({ organization: aphi_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'baq', phone_number: 9732023835 }), is_booth_chair: true })
Membership.create({ organization: aphi_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'shanas', phone_number: 9737181526 }), is_booth_chair: true })

puts '  APhiO'
Membership.create({ organization: aphio_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'lghernan', phone_number: 6618478483 }), is_booth_chair: true })
Membership.create({ organization: aphio_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'judyh', phone_number: 5165074684 }), is_booth_chair: true })

puts '  ASA'
Membership.create({ organization: asa_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'yangyou', phone_number: 2012330081 }), is_booth_chair: true })
Membership.create({ organization: asa_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'jalau', phone_number: 7813544899 }), is_booth_chair: true })
Membership.create({ organization: asa_org, booth_chair_order: 3, participant: Participant.create({ andrewid: 'sanghyup' }), is_booth_chair: true })

puts '  Astro'
Membership.create({ organization: astro_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'mfinlay', phone_number: 2103108054 }), is_booth_chair: true })
Membership.create({ organization: astro_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'agurvich', phone_number: 6313581073 }), is_booth_chair: true })
Membership.create({ organization: astro_org, booth_chair_order: 3, participant: Participant.create({ andrewid: 'amarano', phone_number: 9144209281 }), is_booth_chair: true })
Membership.create({ organization: astro_org, booth_chair_order: 4, participant: Participant.create({ andrewid: 'bhaas', phone_number: 7246832352 }), is_booth_chair: true })

puts '  TriDelt'
Membership.create({ organization: ddd_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'lmilisit', phone_number: 4125278059 }), is_booth_chair: true })
Membership.create({ organization: ddd_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'pthang', phone_number: 8186219840 }), is_booth_chair: true })
Membership.create({ organization: ddd_org, booth_chair_order: 3, participant: Participant.create({ andrewid: 'cciriell', phone_number: 9086443926 }), is_booth_chair: true })

puts '  DG'
Membership.create({ organization: dg_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'ahekler', phone_number: 5712302399 }), is_booth_chair: true })
Membership.create({ organization: dg_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'sparrine', phone_number: 9735257942 }), is_booth_chair: true })
Membership.create({ organization: dg_org, booth_chair_order: 3, participant: Participant.create({ andrewid: 'slanden', phone_number: 4103001575 }), is_booth_chair: true })
Membership.create({ organization: dg_org, booth_chair_order: 4, participant: Participant.create({ andrewid: 'haejinp', phone_number: 8607032010 }), is_booth_chair: true })
Membership.create({ organization: dg_org, booth_chair_order: 5, participant: Participant.create({ andrewid: 'searnest', phone_number: 9795744929 }), is_booth_chair: true })
Membership.create({ organization: dg_org, booth_chair_order: 6, participant: Participant.create({ andrewid: 'tyv', phone_number: 6469431119 }), is_booth_chair: true })

puts '  DTD'
Membership.create({ organization: dtd_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'jdorr', phone_number: 8452831045 }), is_booth_chair: true })
Membership.create({ organization: dtd_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'haozheg', phone_number: 9084034261 }), is_booth_chair: true })
Membership.create({ organization: dtd_org, booth_chair_order: 3, participant: Participant.create({ andrewid: 'tfs', phone_number: 7173195528 }), is_booth_chair: true })
Membership.create({ organization: dtd_org, booth_chair_order: 4, participant: Participant.create({ andrewid: 'bbzhang', phone_number: 4127223696 }), is_booth_chair: true })
Membership.create({ organization: dtd_org, booth_chair_order: 5, participant: Participant.create({ andrewid: 'achisolm', phone_number: 6315468835 }), is_booth_chair: true })

puts '  DU'
Membership.create({ organization: du_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'khrivera' }), is_booth_chair: true })


puts '  Fringe'
Membership.create({ organization: fringe_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'aahiggin', phone_number: 7032970163 }), is_booth_chair: true })

puts '  Theta'
Membership.create({ organization: kat_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'asteger', phone_number: 7035851538 }), is_booth_chair: true })
Membership.create({ organization: kat_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'rwolfing', phone_number: 9259897941 }), is_booth_chair: true })
Membership.create({ organization: kat_org, booth_chair_order: 3, participant: Participant.create({ andrewid: 'kmho', phone_number: 8082226379 }), is_booth_chair: true })
Membership.create({ organization: kat_org, booth_chair_order: 4, participant: Participant.create({ andrewid: 'ihlee', phone_number: 9713408528 }), is_booth_chair: true })

puts '  Kappa'
Membership.create({ organization: kkg_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'kloisell', phone_number: 2158051921 }), is_booth_chair: true })
Membership.create({ organization: kkg_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'sedavies', phone_number: 7175079253 }), is_booth_chair: true })
Membership.create({ organization: kkg_org, booth_chair_order: 3, participant: Participant.create({ andrewid: 'remyb', phone_number: 8453251626 }), is_booth_chair: true })
Membership.create({ organization: kkg_org, booth_chair_order: 4, participant: Participant.create({ andrewid: 'jayoungy', phone_number: 2016631656 }), is_booth_chair: true })

puts '  KapSig'
Membership.create({ organization: kapsig_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'jmoldave', phone_number: 6176710774 }), is_booth_chair: true })
Membership.create({ organization: kapsig_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'tmi', phone_number: 7326723722 }), is_booth_chair: true })

puts '  KGB'
Membership.create({ organization: kgb_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'zhg', phone_number: 6085129248 }), is_booth_chair: true })
Membership.create({ organization: kgb_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'jlareau', phone_number: 2038228199 }), is_booth_chair: true })
Membership.create({ organization: kgb_org, booth_chair_order: 3, participant: Participant.create({ andrewid: 'sguertin', phone_number: 8029893063 }), is_booth_chair: true })

#puts '  Lambda'
#Membership.create({ organization: mudge_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'mgode' }), is_booth_chair: true })
#Membership.create({ organization: mudge_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'jylu' }), is_booth_chair: true })

puts '  Math'
Membership.create({ organization: math_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'dmehrle', phone_number: 6144588176 }), is_booth_chair: true })
Membership.create({ organization: math_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'zng', phone_number: 4434735523 }), is_booth_chair: true })
Membership.create({ organization: math_org, booth_chair_order: 3, participant: Participant.create({ andrewid: 'skornfel' }), is_booth_chair: true })
Membership.create({ organization: math_org, booth_chair_order: 4, participant: Participant.create({ andrewid: 'skrasner' }), is_booth_chair: true })

puts '  Mayur SASA'
Membership.create({ organization: mayur_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'varunm', phone_number: 4129966033 }), is_booth_chair: true })

puts '  MCS'
Membership.create({ organization: mcs_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'rfrancol' }), is_booth_chair: true })
Membership.create({ organization: mcs_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'meschaef', phone_number: 6312557501 }), is_booth_chair: true })
Membership.create({ organization: mcs_org, booth_chair_order: 3, participant: Participant.create({ andrewid: 'kaitlinh' }), is_booth_chair: true })
Membership.create({ organization: mcs_org, booth_chair_order: 4, participant: Participant.create({ andrewid: 'phkoenig' }), is_booth_chair: true })
Membership.create({ organization: mcs_org, booth_chair_order: 5, participant: Participant.create({ andrewid: 'jiyunkwo' }), is_booth_chair: true })

puts '  Mudge'
Membership.create({ organization: mudge_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'rkc', phone_number: 7347174593 }), is_booth_chair: true })
Membership.create({ organization: mudge_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'jmonroe' }), is_booth_chair: true })

puts '  PhiDelt'
Membership.create({ organization: phidelt_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'bferri', phone_number: 7243168810 }), is_booth_chair: true })
Membership.create({ organization: phidelt_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'sholmes', phone_number: 9253242625 }), is_booth_chair: true })
Membership.create({ organization: phidelt_org, booth_chair_order: 3, participant: Participant.create({ andrewid: 'abourai', phone_number: 4084598261 }), is_booth_chair: true })

puts '  SAE'
Membership.create({ organization: sae_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'jgreenbe', phone_number: 2014781454 }), is_booth_chair: true })
Membership.create({ organization: sae_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'daschmid', phone_number: 2674811584 }), is_booth_chair: true })
Membership.create({ organization: sae_org, booth_chair_order: 3, participant: Participant.create({ andrewid: 'kschin', phone_number: 6319884058 }), is_booth_chair: true })

puts '  SigEp'
Membership.create({ organization: sigep_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'wmisitan', phone_number: 5167216678 }), is_booth_chair: true })
Membership.create({ organization: sigep_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'rshanor', phone_number: 4046951322 }), is_booth_chair: true })
Membership.create({ organization: sigep_org, booth_chair_order: 3, participant: Participant.create({ andrewid: 'bsiegel', phone_number: 2074752240 }), is_booth_chair: true })

puts '  SSA'
Membership.create({ organization: ssa_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'nctan', phone_number: 4128011812 }), is_booth_chair: true })
Membership.create({ organization: ssa_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'fchoo', phone_number: 4126920389 }), is_booth_chair: true })
Membership.create({ organization: ssa_org, booth_chair_order: 3, participant: Participant.create({ andrewid: 'johnwenl' }), is_booth_chair: true })

puts '  Spirit'
Membership.create({ organization: spirit_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'sestudil', phone_number: 7735925502 }), is_booth_chair: true })
Membership.create({ organization: spirit_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'cchamber' }), is_booth_chair: true })
Membership.create({ organization: spirit_org, booth_chair_order: 3, participant: Participant.create({ andrewid: 'jbarnes1' }), is_booth_chair: true })

puts '  SDC'
Membership.create({ organization: sdc_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'fcsejtey', phone_number: 3304753580 }), is_booth_chair: true })
Membership.create({ organization: sdc_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'bferri', phone_number: 7243168810 }), is_booth_chair: true })

puts '  TSA'
Membership.create({ organization: tsa_org, booth_chair_order: 1, participant: Participant.create({ andrewid: 'cmcdermi', phone_number: 4129445825 }), is_booth_chair: true })
Membership.create({ organization: tsa_org, booth_chair_order: 2, participant: Participant.create({ andrewid: 'joyces', phone_number: 3025442311 }), is_booth_chair: true })
Membership.create({ organization: tsa_org, booth_chair_order: 3, participant: Participant.create({ andrewid: 'mtung', phone_number: 6462441185 }), is_booth_chair: true })
Membership.create({ organization: tsa_org, booth_chair_order: 4, participant: Participant.create({ andrewid: 'mwu2', phone_number: 4125514620 }), is_booth_chair: true })

# Charge Types ----------------------------------------------------------------
puts 'Charge Types'
ChargeType.create([
  { name: 'Other', description: 'Other violation as determined by the coordinator, please document extensively and inform the Midway Chair incase any problems arise.', requires_booth_chair_approval: true },
  { name: 'Vehicle on Midway', description: 'Organization had a vehicle on Midway without Committee approval. Amount to be determined by Rules Committee.', requires_booth_chair_approval: true },
  { name: '1st Late Shift', description: 'One member was late for a watch shift. First violation. Add a separate fine for each person.', default_amount: 10 },
  { name: '2nd Late Shift', description: 'One member was late for a watch shift. Second violation. Add a separate fine for each person.', default_amount: 20 },
  { name: '3rd Late Shift', description: 'One member late for a watch shift. Third violation. Add a separate fine for each person.', default_amount: 40 },
  { name: '4th or More Late Shift', description: 'One or more members were late for a watch shift. Forth and subsequent violations. Add a separate fine for each person.' },
  { name: '1st Missed Shift', description: 'One member was more than 10 minutes late for a watch shift or arrived incapable of completing the shift (i.e. drunk). First Violation only. Add a separate fine for each person and halve the fine if they arrive less than 45 minutes late.', default_amount: 50 },
  { name: '2nd Missed Shift', description: 'One member was more than 10 minutes late for a watch shift or arrived incapable of completing the shift (i.e. drunk). Second Violation only. Add a separate fine for each person and halve the fine if they arrive less than 45 minutes late.', default_amount: 100 },
  { name: '3rd Missed Shift', description: 'One member was more than 10 minutes late for a watch shift or arrived incapable of completing the shift (i.e. drunk). Third and subsequent violations. Add a separate fine for each person and halve the fine if they arrive less than 45 minutes late.' },
  { name: 'Uncooperative Shift', description: 'Members working the shift failed or refused to complete tasks as assigned by the coordinator.', default_amount: 25 },
  { name: 'Shift Left', description: 'Members working the shift left before being dismissed by the coordinator. Add a separate fine for each person.', default_amount: 25 },
  { name: 'Teardown Shift Missed', description: 'Organization failed to complete the required six man hours during teardown. Fine should be $50 per hour not completed',
    requires_booth_chair_approval: true, default_amount: 50 },
  { name: 'Blown Breaker', description: 'Breaker reset by Power and Safety. First one is free.', requires_booth_chair_approval: true, default_amount: 25.00 },
  { name: 'Unauthorized Plugin', description: 'Organization pluged their booth into power before given permission by Power and Safely.', requires_booth_chair_approval: true, default_amount: 100 }])

# FAQs ------------------------------------------------------------------------
puts "FAQs"

Faq.create([
  { question: "What is Booth?",
    answer:  "Booth is one of the biggest showpieces of Spring Carnival. Student organizations build multi-story structures around our annual theme (2014: Best of the Best), hosting interactive games and elaborate decorations. The booths will be placed on Midway, which is located in the Morewood Gardens Parking Lot." },
  { question: "What do I do if something catches on fire?",
    answer: "There are fire extinguishers located at every booth. Take one and follow the instructions listed on the can." },
  { question: "Where does CMU get money for Carnival?",
    answer: "Carnegie Mellon University's Spring Carnival is funded in part by your Student Activities Fee." },
  { question: "Who won booth last year (2013)?",
    answer: "Independent: ASA, Fraternity: Sigma Phi Epsilon, Sorority: Delta Gamma, Blitz: Mayur SASA, Environmental Award: Delta Gamma and Mudge, T-Shirt Award: TSA, Chairman's Choice: Alpha Phi" },
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
    answer: "Call Nick." },
  { question: "Alumni needs something special.",
    answer: "Call Jackson or Emily." },
  { question: "When do dumpsters go out?",
    answer: "They must be by the back of Morewood lot by 5am." },
  { question: "What is downtime?",
    answer: "When a booth takes time to close their booth and have it not manned during operations. They must register the start of their downtime (you should track this) and put caution tape up to close off the doorways. They should also tell you when they are ending their downtime." },
  { question: "How much downtime does an org get?",
    answer: "4 hours." },
  { question: "How do I check how much downtime an org has left?", 
    answer: "TBD" },
  { question: "A booth tripped a breaker. What do I do?",
    answer: "Add them to Dan's queue. Mark the fine in app if applicable." },
  { question: "Someone has a minor injury (splinter, small cut, dust in eye, etc.).",
    answer: "Give them equipment from the medical kit in the trailer. Tell them they can call EMS if they want. DO NOT ADMINISTER MEDICAL ASSISTANCE." },
  { question: "EMS is closed. What do I do?",
    answer: "Call them." },
  { question: "I saw an ambulance take someone to the hospital. What do I do?", 
    answer: "Call Jackson or Emily immediately." },
  { question: "Someone wants to drop off in the firelane. Can they do that?",
    answer: "No, unless they are Cyert, food delivery for Underground, fire, police, EMS, FMS, people with passes, or an approved delivery (Rachel, Emily, or Jackson says it's OK)." },
  { question: "Golf cart problem?",
    answer: "Call Meg." },
  { question: "Missing golf cart.",
    answer: "Call Meg." },
  { question: "If someone legitimately needs a golf cart...",
    answer: "...radio for golfcart." },
  { question: "A booth chair is freaking out, sad, angry, etc. What do I do?",
    answer: "Call Rachel." },
  { question: "University official wants to borrow something. What do I do?",
    answer: "Let them. They do not need to sign a waiver. Ideally, check it out to Jackson, Emily, or Rachel to track it in the app." },
  { question: "The next coordinator doesn't show up. What do I do?",
    answer: "Call them repeatedly. If that fails, call the Nicks." },
  { question: "Booth watch shift doesn't show up. What do I do?",
    answer: "Do not let previous watch shift leave. Call booth chairs of that org in order until someone answers. Fine them accordingly in the app. If no one can show up and old watch shift has to leave, split the other watch shift." },
  { question: "Drunk people won't listen. What do I do?",
    answer: "Call the police." },
  { question: "Booth chair is asking questions I don't understand. What do I do?",
    answer: "Put them in Rachel's queue. Leave a note if necessary." },
  { question: "Parking complains about Asian row. What do I do?", 
    answer: "Tell Asian row to clear their stuff out. If they won't listen, call Rachel." },
  { question: "What should the 12am-4am watch shifts do?",
    answer: "MOVE THE DUMPSTERS TO THE FIRELANE BY THE TENT. Check the radio station. Make sure no one is doing anything stupid (climbing on roofs, having sex in booths, etc.)." },
  { question: "What's the difference between a security and watch shift?",
    answer: "Security is paid, watch is not. Watch shifts are booth orgs, while security are non-building orgs." },
  { question: "What do I do with my drunk watch/security shift that just showed up?",
    answer: "Send them home, call their booth chair, and inform them of what happened and that they are getting fined unless they supply new, sober people." },
  { question: "AB tech asks for the keys to the scissor lift.",
    answer: "Call Nick." },
  { question: "Taylor Rental needs something.",
    answer: "Call Nick." },
  { question: "Where do I find the midway layout?",
    answer: "In the app, under documents!" },
  { question: "Madelyn Miller calls. What do I do?",
    answer: "Listen to her. Then call Emily/Jackson/Rachel and relay the message." },
  { question: "It's raining and people are losing electricity.",
    answer: "Wait until the rain stops, then tell them to suck it up and we'll deal with it." },
  { question: "It's super windy. Things are flying off of booths.",
    answer: "Check weather on trailer computer. Call Emily/Jackson/Rachel with that information." } 
])
    
# Organization Status Types --------------------------------------------------
puts 'Organization Status Types'
OrganizationStatusType.create([
  { name: "Note", display: false },
  { name: "Plans Submitted, Under SCC Review", display: true },
  { name: "Plans Under Final Review", display: true },
  { name: "Plans Awaiting Revision", display: true },
  { name: "Plans Approved", display: true },
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

# Coordinator Shifts
puts '  Coordinator Shifts'
Shift.create([
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-04T20:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-04T20:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-05T00:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-05T00:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-05T04:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-05T04:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-05T08:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-05T08:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-05T12:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-05T12:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-05T16:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-05T16:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-05T20:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-05T20:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-06T00:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-06T00:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-06T04:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-06T04:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-06T08:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-06T08:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-06T12:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-06T12:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-06T16:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-06T16:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-06T20:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-06T20:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-07T00:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-07T00:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-07T04:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-07T04:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-07T08:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-07T08:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-07T12:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-07T12:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-07T16:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-07T16:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-07T20:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-07T20:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-08T00:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-08T00:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-08T04:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-08T04:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-08T08:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-08T08:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-08T12:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-08T12:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-08T16:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-08T16:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-08T20:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-08T20:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-09T00:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-09T00:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-09T04:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-09T04:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-09T08:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-09T08:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-09T12:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-09T12:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-09T16:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-09T16:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-09T20:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-09T20:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-10T00:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-10T00:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-10T04:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-10T04:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-10T08:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-10T08:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-10T12:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-10T12:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-10T16:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-10T16:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-10T20:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-10T20:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-11T00:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-11T00:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-11T04:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-11T04:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-11T08:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-11T08:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-11T12:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-11T12:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-11T16:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-11T16:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-11T20:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-11T20:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-12T00:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-12T00:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-12T04:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-12T04:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-12T08:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-12T08:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-12T12:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-12T12:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-12T16:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-12T16:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-12T20:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-12T20:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-13T00:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-13T00:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-13T04:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-13T04:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-13T08:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-13T08:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 },
  { shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-13T12:00:00+05:00'), ends_at: DateTime.rfc3339('2014-04-13T12:00:00+05:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 }
])

# Watch Shifts
puts '  Watch Shifts'
Shift.create([
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/4/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/4/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization: sae_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/4/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/4/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization: sae_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/4/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/4/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:math_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/4/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/4/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:math_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/4/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/4/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kat_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/4/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/4/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:mcs_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/4/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/5/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aphi_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/4/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/5/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:mcs_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/5/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/5/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kat_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/5/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/5/2014 5:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:du_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/5/2014 5:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/5/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:mudge_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/5/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/5/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:ddd_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/5/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/5/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:ddd_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/5/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/5/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kapsig_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/5/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/5/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:mayur_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/5/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/5/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:dg_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/5/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/5/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kkg_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/5/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/5/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:fringe_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/5/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/5/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:mayur_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/5/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/6/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:mayur_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/6/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/6/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:asa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/6/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/6/2014 5:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:asa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/6/2014 5:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/6/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aepi_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/6/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/6/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aepi_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/6/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/6/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:ddd_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/6/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/6/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kat_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/6/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/6/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:axo_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/6/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/6/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:ssa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/6/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/6/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:ssa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/6/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/6/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:astro_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/6/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/6/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:astro_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/6/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kat_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:asa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 5:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:asa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 5:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:sdc_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:sdc_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:sdc_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:axo_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:axo_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:dg_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:dg_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:axo_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kkg_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:axo_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:fringe_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:astro_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:dg_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/8/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kkg_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/8/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/8/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aepi_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/8/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/8/2014 5:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aepi_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/8/2014 5:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/8/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aepi_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/8/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/8/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aepi_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/8/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/8/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kkg_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/8/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/8/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kkg_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/8/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/8/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:axo_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/8/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/8/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:dg_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/8/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/8/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:dg_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/8/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/8/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:sigep_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/8/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/8/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kgb_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/8/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/8/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:fringe_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/8/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/8/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aphi_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/8/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/8/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:dg_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/8/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/8/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kkg_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/8/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/9/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:mcs_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/8/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/9/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:axo_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/9/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/9/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:asa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/9/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/9/2014 5:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:asa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/9/2014 5:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/9/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:sdc_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/9/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/9/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:sdc_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/9/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/9/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:axo_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/9/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/9/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kkg_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/9/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/9/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kkg_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/9/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/9/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:fringe_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/9/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/9/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kat_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/9/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/9/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:sigep_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/9/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/9/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kat_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/9/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/9/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:ddd_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/9/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/9/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kapsig_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/9/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/9/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kat_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/9/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/9/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kapsig_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/9/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/10/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:sae_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/9/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/10/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:fringe_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/10/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/10/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:sdc_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/10/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/10/2014 5:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:asa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/10/2014 5:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/10/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:dtd_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/10/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/10/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:sigep_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/10/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/10/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:sigep_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/10/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/10/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:sigep_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/10/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/10/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:math_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/10/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/10/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:sigep_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/10/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/10/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kapsig_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/10/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/10/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aphi_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/10/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/10/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kapsig_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/10/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/10/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kgb_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/10/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/10/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:axo_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/10/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/10/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:phidelt_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/10/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/10/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:axo_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/10/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/10/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:ddd_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/10/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/10/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kgb_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/10/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kapsig_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/10/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:spirit_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:dtd_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:spirit_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 5:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:dtd_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 5:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:du_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:du_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:du_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:sigep_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:tsa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:tsa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:tsa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aphi_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:ssa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:axo_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:ssa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kgb_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:tsa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:tsa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:ssa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/11/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kgb_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:ssa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/11/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aepi_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:dtd_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:mudge_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 5:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:dtd_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 5:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:dtd_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:dtd_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:ddd_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aphi_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:sigep_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:ddd_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:tsa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:tsa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:phidelt_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aphi_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kgb_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:axo_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kgb_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:axo_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kgb_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/12/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:axo_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/13/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:ssa_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/12/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/13/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:axo_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/13/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/13/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:mudge_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/13/2014 1:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/13/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:spirit_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/13/2014 3:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/13/2014 5:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:du_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/13/2014 5:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/13/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:du_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/13/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/13/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:du_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/13/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/13/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kapsig_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/13/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/13/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aphi_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/13/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/13/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:fringe_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/13/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/13/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:sdc_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/13/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/13/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:fringe_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/13/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/13/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:phidelt_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/13/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/13/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:ssa_org, required_number_of_participants: 2 }
])

# Security Shifts
puts '  Security Shifts'
Shift.create([
  { shift_type: sec_shift, starts_at: DateTime.rfc3339('2014-04-07T07:30:00+05:00'), ends_at: DateTime.rfc3339('2014-04-07T07:30:00+05:00') + 2.hours, required_number_of_participants: 2 },
  { shift_type: sec_shift, starts_at: DateTime.rfc3339('2014-04-07T09:30:00+05:00'), ends_at: DateTime.rfc3339('2014-04-07T09:30:00+05:00') + 2.hours, required_number_of_participants: 2 },
  { shift_type: sec_shift, starts_at: DateTime.rfc3339('2014-04-07T11:30:00+05:00'), ends_at: DateTime.rfc3339('2014-04-07T11:30:00+05:00') + 2.hours, required_number_of_participants: 2 },
  { shift_type: sec_shift, starts_at: DateTime.rfc3339('2014-04-07T13:30:00+05:00'), ends_at: DateTime.rfc3339('2014-04-07T13:30:00+05:00') + 2.hours, required_number_of_participants: 2 },
  { shift_type: sec_shift, starts_at: DateTime.rfc3339('2014-04-07T15:30:00+05:00'), ends_at: DateTime.rfc3339('2014-04-07T15:30:00+05:00') + 2.hours, required_number_of_participants: 2 },
  { shift_type: sec_shift, starts_at: DateTime.rfc3339('2014-04-08T07:30:00+05:00'), ends_at: DateTime.rfc3339('2014-04-08T07:30:00+05:00') + 2.hours, required_number_of_participants: 2 },
  { shift_type: sec_shift, starts_at: DateTime.rfc3339('2014-04-08T09:30:00+05:00'), ends_at: DateTime.rfc3339('2014-04-08T09:30:00+05:00') + 2.hours, required_number_of_participants: 2 },
  { shift_type: sec_shift, starts_at: DateTime.rfc3339('2014-04-08T11:30:00+05:00'), ends_at: DateTime.rfc3339('2014-04-08T11:30:00+05:00') + 2.hours, required_number_of_participants: 2 },
  { shift_type: sec_shift, starts_at: DateTime.rfc3339('2014-04-08T13:30:00+05:00'), ends_at: DateTime.rfc3339('2014-04-08T13:30:00+05:00') + 2.hours, required_number_of_participants: 2 },
  { shift_type: sec_shift, starts_at: DateTime.rfc3339('2014-04-08T15:30:00+05:00'), ends_at: DateTime.rfc3339('2014-04-08T15:30:00+05:00') + 2.hours, required_number_of_participants: 2 },
  { shift_type: sec_shift, starts_at: DateTime.rfc3339('2014-04-09T07:30:00+05:00'), ends_at: DateTime.rfc3339('2014-04-09T07:30:00+05:00') + 2.hours, required_number_of_participants: 2 },
  { shift_type: sec_shift, starts_at: DateTime.rfc3339('2014-04-09T09:30:00+05:00'), ends_at: DateTime.rfc3339('2014-04-09T09:30:00+05:00') + 2.hours, required_number_of_participants: 2 },
  { shift_type: sec_shift, starts_at: DateTime.rfc3339('2014-04-09T11:30:00+05:00'), ends_at: DateTime.rfc3339('2014-04-09T11:30:00+05:00') + 2.hours, required_number_of_participants: 2 },
  { shift_type: sec_shift, starts_at: DateTime.rfc3339('2014-04-09T13:30:00+05:00'), ends_at: DateTime.rfc3339('2014-04-09T13:30:00+05:00') + 2.hours, required_number_of_participants: 2 },
  { shift_type: sec_shift, starts_at: DateTime.rfc3339('2014-04-09T15:30:00+05:00'), ends_at: DateTime.rfc3339('2014-04-09T15:30:00+05:00') + 2.hours, required_number_of_participants: 2 }
])

puts 'Tools'
# Tools -----------------------------------------------------------------------
generate_tools

case Rails.env
when 'development'
  puts
  puts 'Extra Dev Goodness:'
  puts

  puts "Users & Participants"
  merichar_user = User.new({email: "meribyte@andrew.cmu.edu", name: "Meg Richards" })
  merichar_user.save
  merichar = Participant.create({ andrewid: 'meribyte', user: merichar_user })
  merichar_in_scc = Membership.create({ participant: merichar, organization: scc_org, is_booth_chair: false })

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
when 'production'
  #blah
end

