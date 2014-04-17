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
mudge_org = Organization.create({ name: 'Mudge', organization_category: blitz })
sae_org = Organization.create({ name: 'Sigma Alpha Epsilon', organization_category: blitz, short_name: 'SAE' })
spirit_org = Organization.create({ name: 'Spirit', organization_category: blitz })
phidelt_org = Organization.create({ name: 'Phi Delta Theta', organization_category: blitz, short_name: 'PhiDelt' })
#lambda_org = Organization.create({ name: 'Lambda Phi Epsilon', organization_category: blitz, short_name: 'Lambda' })
#stever_org = Organization.create({ name: 'Stever', organization_category: blitz })

puts '  Non-Building'
crew_org = Organization.create({ name: 'Crew', organization_category: non_building })
  OrganizationAlias.create({ organization: crew_org, name: 'Rowing' })
the_os_org = Organization.create({ name: 'The Originals', organization_category: non_building, short_name: 'The O\'s' })
pike_org = Organization.create({ name: 'Pi Kappa Alpha', organization_category: non_building, short_name: 'Pike' })
  OrganizationAlias.create({ organization: pike_org, name: 'Pika' })
polo_org = Organization.create({ name: 'Water Polo', organization_category: non_building, short_name: 'Polo' })
habitat_org = Organization.create({ name: 'Habitat for Humanity', organization_category: non_building, short_name: 'Habitat' })
lg_org = Organization.create({ name: 'Lunar Gala', organization_category: non_building, short_name: 'LG' })

# SCC Members -----------------------------------------------------------------
puts 'SCC Members (not exhaustive)'
rachel_user = User.new({ email: 'rcrown@andrew.cmu.edu', name: 'Rachel Crown'})
rachel_user.add_role :admin
rachel_user.save!
rachel = Participant.create({ andrewid: 'rcrown', phone_number: 6178617669, user: rachel_user })
Membership.create({ organization: scc_org, participant: rachel, title: 'Head of Booth', is_booth_chair: true })
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

merichar_user = User.new({email: "meribyte@andrew.cmu.edu", name: "Meg" })
merichar_user.add_role :admin
merichar_user.save!
merichar = Participant.create({ andrewid: 'meribyte', phone_number: 8456424549, user: merichar_user })
Membership.create({ organization: scc_org, participant: merichar, title: 'Asst. Operations - Golf Carts & Assistant Web Troll' })

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
  { andrewid: 'rakhan' },
  { andrewid: 'dcbrout', phone_number: 9145238600 },
  { andrewid: 'arbrock' },
  { andrewid: 'abonsu' },
  { andrewid: 'ngasbarr', phone_number: 4128971984 }
])

Membership.create([
  { participant: Participant.find_by_andrewid('nettling'), organization: scc_org},
  { participant: Participant.find_by_andrewid('mbignell'), organization: scc_org},
  { participant: Participant.find_by_andrewid('msiko'), organization: scc_org},
  { participant: Participant.find_by_andrewid('dmiele'), organization: scc_org},
  { participant: Participant.find_by_andrewid('wavil'), organization: scc_org},
  { participant: Participant.find_by_andrewid('bdshih'), organization: scc_org},
  { participant: Participant.find_by_andrewid('mcahill'), organization: scc_org},
  { participant: Participant.find_by_andrewid('hloo'), organization: scc_org},
  { participant: Participant.find_by_andrewid('cweintra'), organization: scc_org},
  { participant: Participant.find_by_andrewid('rdalal'), organization: scc_org},
  { participant: Participant.find_by_andrewid('jcmertz'), organization: scc_org},
  { participant: Participant.find_by_andrewid('prheinhe'), organization: scc_org},
  { participant: Participant.find_by_andrewid('ejsolomo'), organization: scc_org},
  { participant: Participant.find_by_andrewid('snanda'), organization: scc_org},
  { participant: Participant.find_by_andrewid('amort'), organization: scc_org},
  { participant: Participant.find_by_andrewid('dcbrout'), organization: scc_org},
  { participant: Participant.find_by_andrewid('ncoauett'), organization: scc_org},
  { participant: Participant.find_by_andrewid('cssmith'), organization: scc_org},
  { participant: Participant.find_by_andrewid('laurenmi'), organization: scc_org},
  { participant: Participant.find_by_andrewid('tchitten'), organization: scc_org},
  { participant: Participant.find_by_andrewid('crockoff'), organization: scc_org},
  { participant: Participant.find_by_andrewid('arakla'), organization: scc_org},
  { participant: Participant.find_by_andrewid('egarbade'), organization: scc_org},
  { participant: Participant.find_by_andrewid('ekarras'), organization: scc_org},
  { participant: Participant.find_by_andrewid('ise'), organization: scc_org},
  { participant: Participant.find_by_andrewid('vsivakum'), organization: scc_org},
  { participant: Participant.find_by_andrewid('michell2'), organization: scc_org },
  { participant: Participant.find_by_andrewid('amartine'), organization: scc_org },
  { participant: Participant.find_by_andrewid('mtai'), organization: scc_org },
  { participant: Participant.find_by_andrewid('rakhan'), organization: scc_org },
  { participant: Participant.find_by_andrewid('arbrock'), organization: scc_org },
  { participant: Participant.find_by_andrewid('abonsu'), organization: scc_org },
  { participant: Participant.find_by_andrewid('ngasbarr'), organization: scc_org }
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
  { participant: Participant.find_by_andrewid('abonsu'), organization: ddd_org },
  { participant: Participant.find_by_andrewid('wavil'), organization: sigep_org },
  { participant: Participant.find_by_andrewid('arakla'), organization: sdc_org },
  { participant: Participant.find_by_andrewid('ekarras'), organization: axo_org },
  { participant: Participant.find_by_andrewid('dcbrout'), organization: dtd_org },
  { participant: Participant.find_by_andrewid('ngasbarr'), organization: dtd_org }
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
    answer: "Call Jackson, Emily, and/or Rachel immediately." },
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
    answer: "Call them repeatedly. If that fails, call Nick." },
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
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-04T16:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-04T16:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('arakla'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-04T20:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-04T20:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('amartine'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-05T00:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-05T00:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('cssmith'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-05T04:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-05T04:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('ngasbarr'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-05T08:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-05T08:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('snanda'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-05T12:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-05T12:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('laurenmi'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-05T16:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-05T16:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('cweintra'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-05T20:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-05T20:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('egarbade'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-06T00:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-06T00:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('meribyte'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-06T04:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-06T04:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('ise'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-06T08:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-06T08:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('rdalal'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-06T12:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-06T12:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('mcahill'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-06T16:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-06T16:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('msiko'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-06T20:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-06T20:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
# Empty Shift
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-07T00:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-07T00:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('arbrock'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-07T04:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-07T04:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('ngasbarr'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-07T08:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-07T08:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('cbrownel'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-07T12:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-07T12:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('crockoff'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-07T16:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-07T16:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('dmiele'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-07T20:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-07T20:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('ncoauett'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-08T00:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-08T00:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('vsivakum'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-08T04:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-08T04:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('ise'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-08T08:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-08T08:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('amort'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-08T12:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-08T12:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('wavil'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-08T16:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-08T16:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('rakhan'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-08T20:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-08T20:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('dcbrout'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-09T00:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-09T00:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('arbrock'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-09T04:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-09T04:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
# Empty Shift
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-09T08:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-09T08:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
# Empty Shift
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-09T12:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-09T12:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('mhankows'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-09T16:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-09T16:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('cweintra'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-09T20:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-09T20:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('mbignell'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-10T00:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-10T00:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('cssmith'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-10T04:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-10T04:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('tchitten'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-10T08:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-10T08:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('ejsolomo'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-10T12:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-10T12:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('nettling'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-10T16:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-10T16:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('meribyte'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-10T20:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-10T20:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('prheinhe'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-11T00:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-11T00:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('egarbade'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-11T04:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-11T04:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('tchitten'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-11T08:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-11T08:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('laurenmi'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-11T12:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-11T12:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('mtai'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-11T16:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-11T16:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('ekarras'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-11T20:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-11T20:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('amartine'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-12T00:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-12T00:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('cssmith'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-12T04:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-12T04:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('jcmertz'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-12T08:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-12T08:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('arakla'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-12T12:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-12T12:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('jcmertz'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-12T16:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-12T16:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('prheinhe'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-12T20:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-12T20:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
# Empty Shift
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-13T00:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-13T00:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('dmiele'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-13T04:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-13T04:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('vsivakum'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-13T08:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-13T08:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('crockoff'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-13T12:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-13T12:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('crockoff'), clocked_in_at: Time.now })
shift = Shift.create({ shift_type: coord_shift, starts_at: DateTime.rfc3339('2014-04-13T16:00:00-04:00'), ends_at: DateTime.rfc3339('2014-04-13T12:00:00-04:00') + 4.hours, organization: scc_org, required_number_of_participants: 1 })
ShiftParticipant.create({ shift: shift, participant: Participant.find_by_andrewid('crockoff'), clocked_in_at: Time.now })

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
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/6/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/6/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aphio_org, required_number_of_participants: 2 },
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
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aphio_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aphio_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:dg_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:dg_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aphio_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:kkg_org, required_number_of_participants: 2 },
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/7/2014 19:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/7/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aphio_org, required_number_of_participants: 2 },
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
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/8/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/8/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aphio_org, required_number_of_participants: 2 },
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
  { shift_type: watch_shift, starts_at: DateTime.strptime('4/9/2014 9:00:00-0400','%m/%d/%Y %H:%M:%S%z'), ends_at: DateTime.strptime('4/9/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z'), organization:aphio_org, required_number_of_participants: 2 },
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
#puts '  Security Shifts'

puts 'Tasks'
puts '  One-Time Tasks'
Task.create([
  { name: 'Towing for Move On Begins', description: 'Any cars remaining on Morewood Lot after 5pm will be towed.', due_at: DateTime.strptime('4/4/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Move On Begins', description: 'Orgs start moving on to Midway', due_at: DateTime.strptime('4/4/2014 18:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Final Booth Inspections', description: 'Larry Cartwright and Bob Anderegg will show up to Midway. Help them find Rachel so that they can inspect the state of the booths.', due_at: DateTime.strptime('4/9/2014 12:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Construction Ends', description: 'All but 4 members (full-size) or 2 members (blitz) of each org must clear Midway.', due_at: DateTime.strptime('4/10/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Call for Cleaning Helpers', description: 'Each org must send 2 members at 1pm to the trailer to assist with Midway clean-up', due_at: DateTime.strptime('4/10/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Final Fixes End', description: '4 members (full-size) or 2 members (blitz) of each org may stay to make final fixes between 1pm and 2:30pm. Everyone must be gone from Midway at 2:30pm.', due_at: DateTime.strptime('4/10/2014 14:30:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Opening Ceremony', description: 'Speeches, ribbon cutting, and Midway officially opens to the public.', due_at: DateTime.strptime('4/10/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Judging Begins', description: 'Judges will arrive with Rachel and will judge each booth. No, we do not have a schedule of which booths will be judged when. Sorry.', due_at: DateTime.strptime('4/11/2014 13:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Concert', description: 'Icona Pop & Mac Miller! On the mall. Rain location: Wiegand Gym. Student opener at 7:30pm.', due_at: DateTime.strptime('4/11/2014 19:30:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Night Judging Ends', description: 'Judges will wander around Midway to judge booths after dusk and will return their packets after. Put them in the box, Rachel or someone else will come get them later.', due_at: DateTime.strptime('4/11/2014 20:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Fireworks', description: 'Following the concert, pretty things go boom in the sky. Also on the mall. Cancelled in the case of rain.', due_at: DateTime.strptime('4/11/2014 22:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Move Chairs for Awards', description: 'Send shifts to clear the chairs from the main tent to prepare for awards', due_at: DateTime.strptime('4/12/2014 16:15:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Awards', description: 'Orgs will rush the main tent to find out who won. Awards involve both buggy and booth.', due_at: DateTime.strptime('4/12/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Dumpsters for Teardown Arrive', description: 'Company should have layout and should drop dumpsters into place. Dumpster layout is in the documents section, if you need to reference it.', due_at: DateTime.strptime('4/13/2014 6:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Start of Teardown', description: 'Orgs may begin to teardown no earlier than 8am. They must begin by 10am.', due_at: DateTime.strptime('4/13/2014 8:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'End of Teardown', description: 'At this time, all orgs should be completed cleared from Midway. If they are not, fining begins at a rate of $1/hr until 5:30, $5 until 6pm, and $10 after 6pm.', due_at: DateTime.strptime('4/13/2014 17:00:00-0400','%m/%d/%Y %H:%M:%S%z') }
])

puts '  Recurring Tasks'
Task.create([
  { name: 'Move dumpsters', description: 'Have a watch shift move dumpsters to the gate by the tent by 6am', due_at: DateTime.strptime('4/5/2014 6:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Move dumpsters', description: 'Have a watch shift move dumpsters to the gate by the tent by 6am', due_at: DateTime.strptime('4/6/2014 6:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Move dumpsters', description: 'Have a watch shift move dumpsters to the gate by the tent by 6am', due_at: DateTime.strptime('4/7/2014 6:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Move dumpsters', description: 'Have a watch shift move dumpsters to the gate by the tent by 6am', due_at: DateTime.strptime('4/8/2014 6:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Move dumpsters', description: 'Have a watch shift move dumpsters to the gate by the tent by 6am', due_at: DateTime.strptime('4/9/2014 6:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Move dumpsters', description: 'Have a watch shift move dumpsters to the gate by the tent by 6am', due_at: DateTime.strptime('4/10/2014 6:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Check Perimeter', description: 'Make sure that Asian Row +AEPI is not out in the lot and that no one is building in the WQED Parking Lot. Also fix snow fencing.', due_at: DateTime.strptime('4/5/2014 0:01:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Check Perimeter', description: 'Make sure that Asian Row +AEPI is not out in the lot and that no one is building in the WQED Parking Lot. Also fix snow fencing.', due_at: DateTime.strptime('4/6/2014 0:01:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Check Perimeter', description: 'Make sure that Asian Row +AEPI is not out in the lot and that no one is building in the WQED Parking Lot. Also fix snow fencing.', due_at: DateTime.strptime('4/7/2014 0:01:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Check Perimeter', description: 'Make sure that Asian Row +AEPI is not out in the lot and that no one is building in the WQED Parking Lot. Also fix snow fencing.', due_at: DateTime.strptime('4/8/2014 0:01:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Check Perimeter', description: 'Make sure that Asian Row +AEPI is not out in the lot and that no one is building in the WQED Parking Lot. Also fix snow fencing.', due_at: DateTime.strptime('4/9/2014 0:01:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Check Perimeter', description: 'Make sure that Asian Row +AEPI is not out in the lot and that no one is building in the WQED Parking Lot. Also fix snow fencing.', due_at: DateTime.strptime('4/10/2014 0:01:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Check Perimeter', description: 'Make sure that Asian Row +AEPI is not out in the lot and that no one is building in the WQED Parking Lot. Also fix snow fencing.', due_at: DateTime.strptime('4/11/2014 0:01:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Check Perimeter', description: 'Make sure that Asian Row +AEPI is not out in the lot and that no one is building in the WQED Parking Lot. Also fix snow fencing.', due_at: DateTime.strptime('4/12/2014 0:01:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Check Perimeter', description: 'Make sure that Asian Row +AEPI is not out in the lot and that no one is building in the WQED Parking Lot. Also fix snow fencing.', due_at: DateTime.strptime('4/13/2014 0:01:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Midway Opens', description: '2 members from each org are allowed on Midway 15 mins before opening, but that is it.', due_at: DateTime.strptime('4/10/2014 15:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Midway Opens', description: '2 members from each org are allowed on Midway 15 mins before opening, but that is it.', due_at: DateTime.strptime('4/11/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Midway Opens', description: '2 members from each org are allowed on Midway 15 mins before opening, but that is it.', due_at: DateTime.strptime('4/12/2014 11:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Midway Closes', description: '2 members from each org are allowed on Midway up until 15 mins after closing, but everyone else must clear out.', due_at: DateTime.strptime('4/10/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Midway Closes', description: '2 members from each org are allowed on Midway up until 15 mins after closing, but everyone else must clear out.', due_at: DateTime.strptime('4/11/2014 23:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Midway Closes', description: '2 members from each org are allowed on Midway up until 15 mins after closing, but everyone else must clear out.', due_at: DateTime.strptime('4/12/2014 21:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Quiet Hours Start', description: 'No more loud noise on Midway. If you can hear something outside a booth it\'s probably too loud, if you can hear it at the trailer then it\'s WAY too loud. Don\'t want to wake the neighbors. Tell booth orgs, "Shh, time to go to bed..."', due_at: DateTime.strptime('4/4/2014 22:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Quiet Hours Start', description: 'No more loud noise on Midway. If you can hear something outside a booth it\'s probably too loud, if you can hear it at the trailer then it\'s WAY too loud. Don\'t want to wake the neighbors. Tell booth orgs, "Shh, time to go to bed..."', due_at: DateTime.strptime('4/5/2014 22:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Quiet Hours Start', description: 'No more loud noise on Midway. If you can hear something outside a booth it\'s probably too loud, if you can hear it at the trailer then it\'s WAY too loud. Don\'t want to wake the neighbors. Tell booth orgs, "Shh, time to go to bed..."', due_at: DateTime.strptime('4/6/2014 22:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Quiet Hours Start', description: 'No more loud noise on Midway. If you can hear something outside a booth it\'s probably too loud, if you can hear it at the trailer then it\'s WAY too loud. Don\'t want to wake the neighbors. Tell booth orgs, "Shh, time to go to bed..."', due_at: DateTime.strptime('4/7/2014 22:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Quiet Hours Start', description: 'No more loud noise on Midway. If you can hear something outside a booth it\'s probably too loud, if you can hear it at the trailer then it\'s WAY too loud. Don\'t want to wake the neighbors. Tell booth orgs, "Shh, time to go to bed..."', due_at: DateTime.strptime('4/8/2014 22:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Quiet Hours Start', description: 'No more loud noise on Midway. If you can hear something outside a booth it\'s probably too loud, if you can hear it at the trailer then it\'s WAY too loud. Don\'t want to wake the neighbors. Tell booth orgs, "Shh, time to go to bed..."', due_at: DateTime.strptime('4/9/2014 22:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Quiet Hours End', description: 'Noise is allowed again. Hooray Power Tools!', due_at: DateTime.strptime('4/5/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Quiet Hours End', description: 'Noise is allowed again. Hooray Power Tools!', due_at: DateTime.strptime('4/6/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Quiet Hours End', description: 'Noise is allowed again. Hooray Power Tools!', due_at: DateTime.strptime('4/7/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Quiet Hours End', description: 'Noise is allowed again. Hooray Power Tools!', due_at: DateTime.strptime('4/8/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Quiet Hours End', description: 'Noise is allowed again. Hooray Power Tools!', due_at: DateTime.strptime('4/9/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z') },
  { name: 'Quiet Hours End', description: 'Noise is allowed again. Hooray Power Tools!', due_at: DateTime.strptime('4/10/2014 7:00:00-0400','%m/%d/%Y %H:%M:%S%z') }
])

puts 'Org Timeline Entry Types'
OrganizationTimelineEntryType.create([
  { name: 'Electrical Queue' },
  { name: 'Structural Queue' },
  { name: 'Downtime' }
])

puts 'Tools'
# Tools -----------------------------------------------------------------------
generate_tools

case Rails.env
when 'production'
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

