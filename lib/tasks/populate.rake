namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    if (!Rails.env.development?)
      puts "Environment wasn't developement"
      return
    end

    puts "clearing out data in database..."
    # Invoke rake db:migrate just in case...
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke

    # Docs at: http://populator.rubyforge.org/
    require 'populator'

    # clear out old data in the database and reset the id sequences to 1 on each run of the populator
    [Charge, ChargeType, Checkout, Document, Faq, Membership, Organization, OrganizationAlias, OrganizationCategory, Participant, Role, Shift, ShiftParticipant, ShiftType, Task, TaskStatus, Tool].each(&:delete_all)

    puts "adding new data to database..."
    puts
    puts "OrganizationCategory"

    organization_categories = ["Blitz", "Independent", "Fraternity", "Sorority", "Concession", "Non-Building"]

    organization_categories.each do |org_category|
      new_org_categories = OrganizationCategory.new
      new_org_categories.name = org_category
      new_org_categories.save!
    end

    puts "Organization"

    new_org = Organization.new
    new_org.name = "Kappa Alpha Theta"
    new_org.organization_category = OrganizationCategory.find_by_name("Sorority")
    new_org.save!

    new_org = Organization.new
    new_org.name = "Student Dormitory Council"
    new_org.organization_category = OrganizationCategory.find_by_name("Independent")
    new_org.save!

    new_org = Organization.new
    new_org.name = "Spring Carnival Committee"
    new_org.organization_category = OrganizationCategory.find_by_name("Independent")
    new_org.save!

    puts "OrganizationAlias"

    new_org_alias = OrganizationAlias.new
    new_org_alias.name = "Theta"
    new_org_alias.organization = Organization.find_by_name("Kappa Alpha Theta")
    new_org_alias.save!

    new_org_alias = OrganizationAlias.new
    new_org_alias.name = "SDC"
    new_org_alias.organization = Organization.find_by_name("Student Dormitory Council")
    new_org_alias.save!

    new_org_alias = OrganizationAlias.new
    new_org_alias.name = "SCC"
    new_org_alias.organization = Organization.find_by_name("Spring Carnival Committee")
    new_org_alias.save!

    puts "ChargeType"

    new_charge_type = ChargeType.new
    new_charge_type.default_amount = 100.00
    new_charge_type.description = "Missed a meeting"
    new_charge_type.name = "Meeting"
    new_charge_type.requires_booth_chair_approval = false
    new_charge_type.save!

    new_charge_type = ChargeType.new
    new_charge_type.default_amount = 200.00
    new_charge_type.description = "Tripped a breaker"
    new_charge_type.name = "Breaker"
    new_charge_type.requires_booth_chair_approval = true
    new_charge_type.save!

    puts "User"
    new_user = User.new
    new_user.email = "dcorwin@andrew.cmu.edu"
    new_user.password = "testtest"
    new_user.password_confirmation = "testtest"
    new_user.name = "Dylan Corwin"
    new_user.add_role :admin
    new_user.save!

    new_user = User.new
    new_user.email = "smcquaid@andrew.cmu.edu"
    new_user.password = "testtest"
    new_user.password_confirmation = "testtest"
    new_user.name = "Steve McQuaid"
    new_user.add_role :admin
    new_user.save!

    new_user = User.new
    new_user.email = "rcrown@andrew.cmu.edu"
    new_user.password = "testtest"
    new_user.password_confirmation = "testtest"
    new_user.name = "Rachel Crown"
    new_user.add_role :admin
    new_user.save!

    new_user = User.new
    new_user.email = "shannon1@andrew.cmu.edu"
    new_user.password = "testtest"
    new_user.password_confirmation = "testtest"
    new_user.name = "Shannon Chen"
    new_user.add_role :admin
    new_user.save!

    new_user = User.new
    new_user.email = "juc@andrew.cmu.edu"
    new_user.password = "testtest"
    new_user.password_confirmation = "testtest"
    new_user.name = "Jonathan Chung"
    new_user.add_role :admin
    new_user.save!

    new_user = User.new
    new_user.email = "jgallagh@andrew.cmu.edu"
    new_user.password = "testtest"
    new_user.password_confirmation = "testtest"
    new_user.name = "Jackson Gallagher"
    new_user.add_role :admin
    new_user.save!

    new_user = User.new
    new_user.email = "ehrin@andrew.cmu.edu"
    new_user.password = "testtest"
    new_user.password_confirmation = "testtest"
    new_user.name = "Emily Hrin"
    new_user.add_role :admin
    new_user.save!

    new_user = User.new
    new_user.email = "scc@boa.com"
    new_user.password = "testtest"
    new_user.password_confirmation = "testtest"
    new_user.name = "Test SCC"
    new_user.add_role :scc
    new_user.save!

    new_user = User.new
    new_user.email = "booth_chair@boa.com"
    new_user.password = "testtest"
    new_user.password_confirmation = "testtest"
    new_user.name = "Test Booth Chair"
    new_user.add_role :booth_chair
    new_user.save!

    new_user = User.new
    new_user.email = "member@boa.com"
    new_user.password = "testtest"
    new_user.password_confirmation = "testtest"
    new_user.name = "Test Member"
    new_user.add_role :member
    new_user.save!

    puts "Participant"

    new_participant = Participant.new
    new_participant.andrewid = "rcrown"
    # new_participant.has_signed_waiver = true
    # new_participant.has_signed_hardhat_waiver = false
    new_participant.phone_number = 1234567890
    new_participant.user = User.find_by_name("Rachel Crown")
    new_participant.save!

    new_participant = Participant.new
    new_participant.andrewid = "shannon1"
    # new_participant.has_signed_waiver = false
    # new_participant.has_signed_hardhat_waiver = true
    new_participant.phone_number = 4124124124
    new_participant.user = User.find_by_name("Shannon Chen")
    new_participant.save!

    new_participant = Participant.new
    new_participant.andrewid = "dcorwin"
    # new_participant.has_signed_waiver = true
    # new_participant.has_signed_hardhat_waiver = true
    new_participant.phone_number = 4121235555
    new_participant.user = User.find_by_name("Dylan Corwin")
    new_participant.save!

    new_participant = Participant.new
    new_participant.andrewid = "juc"
    # new_participant.has_signed_waiver = false
    # new_participant.has_signed_hardhat_waiver = true
    new_participant.phone_number = 4124124142
    new_participant.user = User.find_by_name("Jonathan Chung")
    new_participant.save!

    new_participant = Participant.new
    new_participant.andrewid = "smcquaid"
    # new_participant.has_signed_waiver = true
    # new_participant.has_signed_hardhat_waiver = true
    new_participant.phone_number = 4121235551
    new_participant.user = User.find_by_name("Steve McQuaid")
    new_participant.save!


    new_participant = Participant.new
    new_participant.andrewid = "asteger"
    # new_participant.has_signed_waiver = false
    # new_participant.has_signed_hardhat_waiver = false
    new_participant.phone_number = 5391234124
    new_participant.user = User.find_by_name("Test Booth Chair")
    new_participant.save!

    new_participant = Participant.new
    new_participant.andrewid = "ehrin"
    # new_participant.has_signed_waiver = false
    # new_participant.has_signed_hardhat_waiver = false
    new_participant.phone_number = 1234567888
    new_participant.user = User.find_by_name("Emily Hrin")
    new_participant.save!

    new_participant = Participant.new
    new_participant.andrewid = "jgallagh"
    # new_participant.has_signed_waiver = false
    # new_participant.has_signed_hardhat_waiver = false
    new_participant.phone_number = 1234567887
    new_participant.user = User.find_by_name("Jackson Gallagher")
    new_participant.save!

    puts "TaskStatus"

    new_task_status = TaskStatus.new
    new_task_status.name = "Complete"
    new_task_status.save!

    new_task_status = TaskStatus.new
    new_task_status.name = "Incomplete"
    new_task_status.save!

    new_task_status = TaskStatus.new
    new_task_status.name = "In Progress"
    new_task_status.save!

    puts "Task"

    new_task = Task.new
    new_task.name = "Assign rides"
    # new_task.participant = Participant.find_by_andrewid("rcrown")
    new_task.task_status = TaskStatus.find_by_name("In Progress")
    new_task.due_at = Date.today
    new_task.save!

    new_task = Task.new
    new_task.name = "Buy wood"
    # new_task.participant = Participant.find_by_andrewid("shannon1")
    new_task.task_status = TaskStatus.find_by_name("Complete")
    new_task.due_at = Date.today
    new_task.save!

    new_task = Task.new
    new_task.name = "Take-out trash"
    # new_task.participant = Participant.find_by_andrewid("dcorwin")
    new_task.task_status = TaskStatus.find_by_name("Incomplete")
    new_task.due_at = Date.today
    new_task.save!

    puts "ShiftType"

    new_shift_type = ShiftType.new
    new_shift_type.name = "Watch Shift"
    new_shift_type.save!

    new_shift_type = ShiftType.new
    new_shift_type.name = "Security Shift"
    new_shift_type.save!

    new_shift_type = ShiftType.new
    new_shift_type.name = "Ride Shift"
    new_shift_type.save!

    puts "Shift"

    new_shift = Shift.new
    new_shift.ends_at = Date.new
    new_shift.required_number_of_participants = 3
    new_shift.starts_at = Date.new
    new_shift.shift_type = ShiftType.find_by_id(1)
    new_shift.organization = Organization.find_by_name("Kappa Alpha Theta")
    new_shift.save!

    new_shift = Shift.new
    new_shift.ends_at = Date.new
    new_shift.required_number_of_participants = 3
    new_shift.starts_at = Date.new
    new_shift.shift_type = ShiftType.find_by_id(2)
    new_shift.organization = Organization.find_by_name("Student Dormitory Council")
    new_shift.save!

    new_shift = Shift.new
    new_shift.ends_at = Date.new
    new_shift.required_number_of_participants = 3
    new_shift.starts_at = Date.new
    new_shift.shift_type = ShiftType.find_by_id(3)
    new_shift.organization = Organization.find_by_name("Kappa Alpha Theta")
    new_shift.save!

    puts "ShiftParticipant"

    new_sp = ShiftParticipant.new
    new_sp.shift = Shift.find_by_id(1)
    new_sp.participant = Participant.find_by_id(1)
    new_sp.clocked_in_at = Date.new
    new_sp.save!

    new_sp = ShiftParticipant.new
    new_sp.shift = Shift.find_by_id(1)
    new_sp.participant = Participant.find_by_id(3)
    new_sp.clocked_in_at = Date.new
    new_sp.save!

    new_sp = ShiftParticipant.new
    new_sp.shift = Shift.find_by_id(1)
    new_sp.participant = Participant.find_by_id(2)
    new_sp.clocked_in_at = Date.new
    new_sp.save!

    new_sp = ShiftParticipant.new
    new_sp.shift = Shift.find_by_id(1)
    new_sp.participant = Participant.find_by_id(4)
    new_sp.clocked_in_at = Date.new
    new_sp.save!

    puts "Tool"

    new_tool = Tool.new
    new_tool.barcode = 1412
    new_tool.description = "Original Hammer"
    new_tool.name = "Original Hammer"
    new_tool.save!

    new_tool = Tool.new
    new_tool.barcode = 12378083290
    new_tool.description = "HAMMER"
    new_tool.name = "Hammer"
    new_tool.save!

    new_tool = Tool.new
    new_tool.barcode = 123789012343
    new_tool.description = "SAW"
    new_tool.name = "Saw"
    new_tool.save!

    new_tool = Tool.new
    new_tool.barcode = 12378424330120
    new_tool.description = "LADDER"
    new_tool.name = "Ladder"
    new_tool.save!

    new_tool = Tool.new
    new_tool.barcode = 123743280812
    new_tool.description = "HARD HAT"
    new_tool.name = "Hard Hat"
    new_tool.save!

    new_tool = Tool.new
    new_tool.barcode = 1344
    new_tool.description = "HARD HAT"
    new_tool.name = "Hard Hat"
    new_tool.save!

    puts "Checkout"

    new_checkout = Checkout.new
    new_checkout.checked_in_at = Date.new
    new_checkout.checked_out_at = Date.new
    new_checkout.tool = Tool.find_by_name("Hammer")
    new_checkout.save!

    new_checkout = Checkout.new
    new_checkout.checked_in_at = Date.new
    new_checkout.checked_out_at = Date.new
    new_checkout.tool = Tool.find_by_name("Hammer")
    new_checkout.save!

    new_checkout = Checkout.new
    new_checkout.checked_in_at = Date.new
    new_checkout.checked_out_at = Date.new
    new_checkout.tool = Tool.find_by_name("Saw")
    new_checkout.save!

    new_checkout = Checkout.new
    new_checkout.checked_in_at = Date.new
    new_checkout.checked_out_at = Date.new
    new_checkout.tool = Tool.find_by_name("Hard Hat")
    new_checkout.save!


    puts "Faq"

    new_faq = Faq.new
    new_faq.question = "What is Booth?"
    new_faq.answer = "Booth is one of the biggest showpieces of Spring Carnival. Student organizations build multi-story structures around our annual theme (2014: Best of the Best), hosting interactive games and elaborate decorations. The booths will be placed on Midway, which is located in the Morewood Gardens Parking Lot."
    new_faq.save!

    new_faq = Faq.new
    new_faq.question = "What do I do if something catches on fire?"
    new_faq.answer = "There are fire extinguishers located at every booth. Take one and follow the instructions listed on the can."
    new_faq.save!

    new_faq = Faq.new
    new_faq.question = "Where does CMU get money for Carnival?"
    new_faq.answer = "Carnegie Mellon University's Spring Carnival is funded in part by your Student Activities Fee."
    new_faq.save!

    new_faq = Faq.new
    new_faq.question = "Who won booth last year (2013)? "
    new_faq.answer = "Independent: ASA, Fraternity: Sigma Phi Epsilon, Sorority: Delta Gamma, Blitz: Mayur SASA, Environmental Award: Delta Gamma and Mudge, T-Shirt Award: TSA, Chairman's Choice: Alpha Phi"
    new_faq.save!


    puts "Charge"

    new_charge = Charge.new
    new_charge.charge_type = ChargeType.find_by_name("Meeting")
    new_charge.issuing_participant = Participant.find_by_andrewid("rcrown")
    new_charge.receiving_participant = nil
    new_charge.organization = Organization.find_by_name("Kappa Alpha Theta")
    new_charge.amount = 50.00
    new_charge.charged_at = Date.today
    new_charge.description = "Missed 10/2 meeting"
    new_charge.save!

    new_charge = Charge.new
    new_charge.charge_type = ChargeType.find_by_name("Breaker")
    new_charge.issuing_participant = Participant.find_by_andrewid("rcrown")
    new_charge.receiving_participant = Participant.find_by_andrewid("asteger")
    new_charge.organization = Organization.find_by_name("Kappa Alpha Theta")
    new_charge.amount = 25.00
    new_charge.charged_at = Date.today - 1
    new_charge.description = "Breaker trip"
    new_charge.save!

    puts "Membership"

    new_membership = Membership.new
    new_membership.participant = Participant.find_by_andrewid("rcrown")
    new_membership.organization = Organization.find_by_name("Spring Carnival Committee")
    new_membership.booth_chair_order = nil
    new_membership.is_booth_chair = false
    new_membership.title = "Head of Booth"
    new_membership.save!

    new_membership = Membership.new
    new_membership.participant = Participant.find_by_andrewid("asteger")
    new_membership.organization = Organization.find_by_name("Kappa Alpha Theta")
    new_membership.booth_chair_order = 1
    new_membership.is_booth_chair = true
    new_membership.title = nil
    new_membership.save!
    


    puts
    puts "db populated!"
  end
end
