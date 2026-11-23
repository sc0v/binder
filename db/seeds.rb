# frozen_string_literal: true

# Development sample data: a made-up Spring Carnival at a real season's scale,
# on an empty database:
#
#   bin/rails db:schema:load db:seed
#
# The season's reference data (organizations, build steps, charge types,
# FAQs, store items, tools, scissor lifts) comes from lib/seeds/2025 seeds/
# through Carnival::Import, which bin/rails carnival:import also runs.
# Everyone here is made up: the developer sign-in's test accounts, a few CMU
# namesakes and about 1,200 generated people. Carnival week is placed around
# today, so there are past, current and upcoming shifts. Shifts and timeline
# entries go in with insert_all, which skips their callbacks: those send SMS
# and GroupMe messages.

# insert_all skips validations and callbacks on purpose here: the rows are
# built consistent, and the callbacks send messages
# rubocop:disable Rails/SkipsModelValidations

abort 'db/seeds.rb is development sample data.' unless Rails.env.local?
abort 'The database has people already. Run bin/rails db:schema:load db:seed.' if Participant.exists?

rng = Random.new(1900)
now = Time.zone.now
# Generated people's names never come from the directory, so their name cache
# never expires
cache_forever = Time.zone.local(2100, 1, 1)
eppn = ->(andrewid) { "#{andrewid}@andrew.cmu.edu" }

$stdout.puts 'Season reference data (lib/seeds/2025 seeds)'
Carnival::Import.new(
  models: %w[organization organizationbuildstatus organizationbuildstep chargetype faq
             shifttype storeitem tool scissorlift]
).run

# Category keys: the hardhat rules look for 'doghouse'
OrganizationCategory.find_each { |category| category.update!(lookup_key: category.name.parameterize) }

# Tools beyond the season's list, by type, to a full inventory's size and mix
tool_top_up = {
  'Org Hardhat' => 580, 'SCC Hardhat' => 100, 'Booth Chair Hardhat' => 58, 'EHS Hardhat' => 17,
  'Drill Battery' => 110, 'Smoke Detector' => 38, 'Battery Charger' => 32, 'Tape Measure' => 34,
  'Broom' => 28, 'Ladder' => 24, 'Phillips Screwdriver' => 23, 'Level' => 27, 'Extension Cord' => 15,
  'Hammer' => 13, 'Wire Strippers' => 16, 'Power Strip' => 11, 'Flathead Screwdriver' => 9,
  'Drill' => 9, 'Drill Charger' => 9, 'Dustpan' => 9, 'Staple Gun' => 8, 'Utility Knife' => 13,
  'Drill Bit Set' => 6, 'Shop Vac' => 5, 'Vise Grips' => 6, 'Magnet Broom' => 5, 'Chalk Line' => 4,
  'Outlet Tester' => 4, 'Paint Sprayer' => 4, 'Hex Screwdriver' => 3, 'Belt Sander' => 2,
  'Saw Horse' => 2, 'Stud Finder' => 3, 'Tape Gun' => 2, 'Hot Glue Gun' => 1, 'Jigsaw' => 1,
  'Rubber Mallet' => 1, 'Sledgehammer' => 1, 'Shovel' => 1, 'Telecom Radio' => 1
}
barcode = 40_000
tool_rows = tool_top_up.flat_map do |name, count|
  tool_type = ToolType.find_or_create_by!(name:)
  Array.new(count) { { barcode: barcode += 1, tool_type_id: tool_type.id, description: '' } }
end
Tool.insert_all!(tool_rows)

scissor_lift_type = CertificationType.create!(name: 'Scissor Lift')
power_tools_type = CertificationType.create!(name: 'Power Tools')
ToolTypeCertification.create!(tool_type: ToolType.find_or_create_by!(name: 'Drill'),
                              certification_type: power_tools_type)

$stdout.puts 'People'
departments = [
  'Architecture', 'Art', 'Biological Sciences', 'Chemical Engineering', 'Civil and Environmental Engineering',
  'Computer Science', 'Design', 'Drama', 'Economics', 'Electrical and Computer Engineering', 'English',
  'History', 'Information Systems', 'Mathematical Sciences', 'Mechanical Engineering', 'Physics',
  'Psychology', 'Statistics and Data Science'
]
classes = %w[Freshman Sophomore Junior Senior Masters]
first_names = %w[
  Alex Avery Bailey Blake Cameron Carmen Casey Dana Devon Drew Eli Elena Emery Finley Gray Harper
  Hayden Iris Jamie Jordan Jules Kai Kendall Lane Logan Mara Micah Morgan Nico Noel Parker Quinn
  Reese Remy Riley Robin Rowan Sage Sam Sasha Skyler Taylor Teagan Toby Val Wren Ari Bea Cole Eden
  Fern Hal Ivy Jo Kit Lou Max Nell Ollie Pat
]
last_names = %w[
  Abbott Alder Ashby Bancroft Barlow Bell Birch Booker Brook Calder Carver Chandler Crane Dale
  Dalton Ellis Emerson Fairbanks Fenwick Finch Ford Garland Gibbs Hale Harlow Hayes Holloway Hughes
  Ives Keller Kent Lark Lowell Marsh Mercer Monroe Nash Norris Oakley Pace Parrish Pell Quill Radley
  Reed Rhodes Sawyer Shaw Sloane Stroud Tate Thorne Vance Wade Warren Webb Whitley Winslow Yates
]

# The developer sign-in's test accounts first (it shows the first person in
# each role by id), then CMU namesakes, then generated people
made_up = CarnegieMellonPerson::MADE_UP_PEOPLE
named = %w[aa00 cc00 bb00 pp00 ss00 ac00 mm00 am00].map do |id|
  { id:, name: made_up[id]['cn'], surname: made_up[id]['sn'], department: made_up[id]['cmuDepartment'] }
end
named += [
  { id: 'hf00', name: 'Henry Clay Frick', surname: 'Frick', department: 'Economics' },
  { id: 'hs00', name: 'Herbert Simon', surname: 'Simon', department: 'Computer Science' }
]
taken = named.to_set { |person| person[:id] }
pairs = first_names.product(last_names).sample(1_190, random: rng)
generated = pairs.map do |first, last|
  initials = "#{first[0]}#{last[0]}".downcase
  number = 10
  number += 1 while taken.include?(format('%<initials>s%<number>02d', initials:, number:))
  id = format('%<initials>s%<number>02d', initials:, number:)
  taken << id
  { id:, name: "#{first} #{last}", surname: last, department: departments.sample(random: rng) }
end

people = named + generated
Participant.insert_all!(
  people.each_with_index.map do |person, index|
    signed = index < named.size || rng.rand < 0.85
    {
      eppn: eppn.call(person[:id]), signed_waiver: signed, watched_safety_video: signed && rng.rand < 0.8,
      phone_number: format('41255501%02d', index % 100), admin: %w[aa00 ac00].include?(person[:id]),
      alumni: index >= named.size && rng.rand < 0.02,
      cached_name: person[:name], cached_surname: person[:surname], cached_email: eppn.call(person[:id]),
      cached_department: person[:department], cached_student_class: classes.sample(random: rng),
      cache_updated: cache_forever
    }
  end
)
person_id = Participant.pluck(:eppn, :id).to_h.transform_keys { |key| key.delete_suffix('@andrew.cmu.edu') }

$stdout.puts 'Memberships'
organizations = Organization.includes(:organization_category).to_a
by_name = organizations.index_by(&:name)
scc = by_name.fetch('Spring Carnival Committee')
# Members per organization, by category
sizes = {
  'SCC' => 40, 'Fraternity' => 70, 'Sorority' => 65, 'Independent' => 45, 'Blitz' => 30,
  'Doghouse' => 16, 'Other Building' => 35, 'Staff' => 6
}
fixed = {
  'aa00' => [scc, false], 'cc00' => [scc, false], 'bb00' => [by_name.fetch('Sigma Phi Epsilon'), true],
  'pp00' => [by_name.fetch('Alpha Epsilon Pi'), false], 'ac00' => [scc, false], 'mm00' => [scc, false],
  'am00' => [by_name.fetch('Sigma Phi Epsilon'), true], 'hf00' => [by_name.fetch('Phi Delta Theta'), false]
}
membership_rows = fixed.map do |id, (organization, chair)|
  { participant_id: person_id.fetch(id), organization_id: organization.id, is_booth_chair: chair,
    title: chair ? 'Booth Chair' : nil, booth_chair_order: chair ? 1 : nil, is_red_hardhat: false }
end
members_of = Hash.new { |hash, key| hash[key] = [] }
membership_rows.each { |row| members_of[row[:organization_id]] << row[:participant_id] }
# Sixty generated people stay out of every organization (the sign-in's
# Non-Participants)
pool = generated.map { |person| person_id.fetch(person[:id]) }.shuffle(random: rng)
pool.pop(60)
organizations.each do |organization|
  wanted = sizes.fetch(organization.organization_category.name, 20) - members_of[organization.id].size
  pool.shift(wanted).each_with_index do |id, index|
    chair = organization.organization_category.building && index < 2
    title = chair ? 'Booth Chair' : ['Electrical Chair', 'Treasurer', 'Safety Chair', nil, nil, nil][index % 6]
    membership_rows << {
      participant_id: id, organization_id: organization.id, is_booth_chair: chair, title:,
      booth_chair_order: chair ? index + 1 : nil, is_red_hardhat: chair && index.zero?
    }
    members_of[organization.id] << id
  end
end
Membership.insert_all!(membership_rows)
chairs_of = Membership.where(is_booth_chair: true).group_by(&:organization_id)
                      .transform_values { |list| list.map(&:participant_id) }
scc_ids = members_of[scc.id]

$stdout.puts 'Certifications'
signed_ids = Participant.where(signed_waiver: true).pluck(:id).to_set
certified = (chairs_of.values.flatten + membership_rows.map { |row| row[:participant_id] }.sample(80, random: rng))
            .uniq.select { |id| signed_ids.include?(id) }
Certification.insert_all!(certified.map do |id|
  { participant_id: id, certification_type_id: scissor_lift_type.id }
end)
Certification.insert_all!(certified.sample(40, random: rng).map do |id|
  { participant_id: id, certification_type_id: power_tools_type.id }
end)

$stdout.puts 'Shifts'
# Carnival week: three days back to three days ahead, in four-hour slots
week_start = now.beginning_of_day - 3.days
slots = Array.new(6 * 6) { |slot| week_start + (slot * 4).hours }
types = ShiftType.pluck(:name, :id).to_h
building_orgs = organizations.select { |o| o.organization_category.building && members_of[o.id].any? }
shift_rows = []
building_orgs.each_with_index do |organization, index|
  6.times do |day|
    starts_at = slots[(day * 6) + ((index + day) % 6)]
    shift_rows << { organization_id: organization.id, shift_type_id: types.fetch('Watch Shift'),
                    starts_at:, ends_at: starts_at + 4.hours, capacity: 3, description: 'Booth watch' }
  end
end
slots.each do |starts_at|
  shift_rows << { organization_id: scc.id, shift_type_id: types.fetch('Security Shift'),
                  starts_at:, ends_at: starts_at + 4.hours, capacity: 2, description: 'Midway security' }
end
slots.each_slice(3) do |group|
  shift_rows << { organization_id: scc.id, shift_type_id: types.fetch('Coordinator Shift'),
                  starts_at: group.first, ends_at: group.first + 12.hours, capacity: 1, description: nil }
end
Shift.insert_all!(shift_rows)

# Past shifts are filled and clocked in; current ones partly; upcoming ones
# full, partly filled or, now and then, with no one at all
assignment_rows = []
Shift.unscoped.find_each do |shift|
  members = shift.organization_id == scc.id ? scc_ids : members_of[shift.organization_id]
  count =
    if shift.ends_at < now then shift.capacity
    elsif shift.starts_at < now then [shift.capacity - 1, 1].max
    else [shift.capacity, shift.capacity, shift.capacity - 1, 0, 0].sample(random: rng)
    end
  members.sample(count, random: rng).each do |id|
    clocked = shift.starts_at < now ? shift.starts_at + rng.rand(0..20).minutes : nil
    assignment_rows << { shift_id: shift.id, participant_id: id, clocked_in_at: clocked }
  end
end
ShiftParticipant.insert_all!(assignment_rows) if assignment_rows.any?

$stdout.puts 'Tool checkouts'
tools_by_type = Tool.unscoped.joins(:tool_type).pluck('tool_types.name', 'tools.id')
                    .group_by(&:first).transform_values { |rows| rows.map(&:last) }
checkout_rows = []
checkout = lambda do |tool_id, participant_id, organization_id, out_at, in_at = nil|
  checkout_rows << { tool_id:, participant_id:, organization_id:, checked_out_at: out_at, checked_in_at: in_at }
end
hardhats = ['Org Hardhat', 'Booth Chair Hardhat', 'SCC Hardhat'].index_with { |name| tools_by_type.fetch(name).dup }
membership_rows.each do |row|
  next unless signed_ids.include?(row[:participant_id])

  kind = if row[:organization_id] == scc.id then 'SCC Hardhat'
         elsif row[:is_booth_chair] then 'Booth Chair Hardhat'
         else 'Org Hardhat'
         end
  next if rng.rand > 0.7 || hardhats[kind].empty?

  checkout.call(hardhats[kind].shift, row[:participant_id], row[:organization_id],
                week_start + rng.rand(0..36).hours)
end
hand_tools = tools_by_type.except(*hardhats.keys).values.flatten.shuffle(random: rng)
hours_so_far = ((now - week_start) / 3600).floor
hand_tools.first(320).each_with_index do |tool_id, index|
  organization = building_orgs[index % building_orgs.size]
  out_at = week_start + rng.rand(0..hours_so_far).hours
  # Two in three came back within a few hours; the rest are still out
  returned = index % 3 != 2 && out_at + 6.hours < now
  checkout.call(tool_id, members_of[organization.id].sample(random: rng), organization.id, out_at,
                returned ? out_at + rng.rand(1..6).hours : nil)
end
Checkout.insert_all!(checkout_rows)

$stdout.puts 'Scissor lift checkouts'
lifts = ScissorLift.all.to_a
lift_people = Participant.where(id: certified).select(&:scissor_lift_certified?).first(10)
lift_people.each_with_index do |person, index|
  organization_id = Membership.find_by(participant: person).organization_id
  if index < lifts.size / 2
    ScissorLiftCheckout.create!(scissor_lift: lifts[index], participant: person, organization_id:,
                                checked_out_at: now - 30.minutes, due_at: now + 90.minutes)
  else
    out_at = now - (index + 2).hours
    ScissorLiftCheckout.create!(scissor_lift: lifts.last, participant: person, organization_id:,
                                checked_out_at: out_at, checked_in_at: out_at + 1.hour)
  end
end

$stdout.puts 'Charges'
charge_types = ChargeType.all.to_a
building_orgs.each do |organization|
  rng.rand(2..6).times do
    type = charge_types.sample(random: rng)
    amount = type.default_amount.to_f.positive? ? type.default_amount : rng.rand(10..150)
    Charge.create!(
      organization:, charge_type: type, amount:, description: type.description.presence || type.name,
      issuing_participant_id: scc_ids.sample(random: rng), creating_participant_id: scc_ids.sample(random: rng),
      receiving_participant_id: chairs_of.fetch(organization.id, []).sample(random: rng),
      charged_at: week_start + rng.rand(0..96).hours, is_approved: rng.rand < 0.7
    )
  end
end

$stdout.puts 'Notes and tasks'
note_texts = [
  ['Extension cords', 'Ask about the extension cords run across the walkway.'],
  ['Sign-in sheet', 'Booth watch sign-in sheet left at the SCC tent.'],
  ['Electrical recheck', 'Electrical wants a recheck before power-on.'],
  ['Lost and found', 'A phone was turned in from this booth.'],
  ['Late delivery', 'Lumber delivery came late; build may slip a few hours.'],
  ['Thank you', 'Great cleanup after Saturday night.']
]
colors = ['#ffc', '#cfc', '#ccf', '#fcc', '#ddd']
45.times do |index|
  title, value = note_texts[index % note_texts.size]
  Note.create!(participant_id: scc_ids.sample(random: rng), organization: building_orgs.sample(random: rng),
               title:, value:, color: colors[index % colors.size], hidden: index % 9 == 8,
               archived_at: index % 7 == 6 ? now - 1.day : nil)
end
task_names = [
  'Inspect midway lighting', 'Restock first aid kits', 'Count hardhats at the tool tent',
  'Walk the booth row for trip hazards', 'Post the watch shift schedule', 'Check fire extinguishers',
  'Collect build week charges', 'Return the rental generator'
]
24.times do |index|
  due_at = week_start + (index * 5).hours
  done = due_at < now && index.even?
  Task.create!(name: task_names[index % task_names.size], description: 'Spring Carnival Committee task.',
               due_at:, is_completed: done, completed_by_id: done ? scc_ids.sample(random: rng) : nil)
end

$stdout.puts 'Build progress'
OrganizationBuildStep.find_each do |step|
  next unless rng.rand < 0.45

  step.update!(approver_id: scc_ids.sample(random: rng), approved_at: week_start + rng.rand(0..60).hours)
end
timeline_rows = building_orgs.flat_map do |organization|
  started_at = week_start + rng.rand(0..60).hours
  rows = [{ organization_id: organization.id, entry_type: 0, started_at:, ended_at: started_at + 40.minutes,
            description: 'Structural inspection' }]
  if rng.rand < 0.4
    rows << { organization_id: organization.id, entry_type: 2, started_at: started_at + 3.hours,
              ended_at: started_at + 4.hours, description: 'Downtime' }
  end
  rows
end
# A few organizations waiting in the electrical queue now
building_orgs.sample(4, random: rng).each do |organization|
  timeline_rows << { organization_id: organization.id, entry_type: 1, started_at: now - rng.rand(5..50).minutes,
                     ended_at: nil, description: 'Electrical inspection' }
end
OrganizationTimelineEntry.insert_all!(timeline_rows)

$stdout.puts 'Created:'
[Organization, Participant, Membership, Tool, ToolType, Shift, ShiftParticipant, Checkout, Certification,
 ScissorLiftCheckout, Charge, Note, Task, OrganizationBuildStep, OrganizationTimelineEntry].each do |model|
  $stdout.puts "  #{model.name}: #{model.unscoped.count}"
end
# rubocop:enable Rails/SkipsModelValidations
