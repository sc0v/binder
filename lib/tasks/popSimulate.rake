namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :popSimulate => :environment do
    #Run Init Script First to steralize DB
    Rake::Task['db:popInit'].invoke
    
    puts "Adding simulated data to database..."
    puts
    
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

    ew_participant = Participant.new
    new_participant.andrewid = "lheimann"
    # new_participant.has_signed_waiver = false
    # new_participant.has_signed_hardhat_waiver = false
    new_participant.phone_number = 1234567887
    new_participant.user = User.find_by_name("Test Member")
    new_participant.save!


    puts "Task Category"

    new_task_category = TaskCategory.new
    new_task_category.name = "Busy Work"
    new_task_category.save!

    new_task_category = TaskCategory.new
    new_task_category.name = "Maintinance"
    new_task_category.save!
    

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
    new_task.task_category = TaskCategory.find_by_name("Busy Work")
    new_task.due_at = Date.today
    new_task.save!

    new_task = Task.new
    new_task.name = "Take-out trash"
    # new_task.participant = Participant.find_by_andrewid("dcorwin")
    new_task.task_status = TaskStatus.find_by_name("Incomplete")
    new_task.task_category = TaskCategory.find_by_name("Maintinance")
    new_task.due_at = Date.today
    new_task.save!
    

    puts "Shift"

    new_shift = Shift.new
    new_shift.ends_at = Time.now + 1.hours
    new_shift.required_number_of_participants = 3
    new_shift.starts_at = Time.now - 1.hours
    new_shift.shift_type = ShiftType.find_by_id(1)
    new_shift.organization = Organization.find_by_name("Kappa Alpha Theta")
    new_shift.save!

    new_shift = Shift.new
    new_shift.ends_at = Time.now - 1.hour
    new_shift.required_number_of_participants = 3
    new_shift.starts_at = Time.now - 3.hours
    new_shift.shift_type = ShiftType.find_by_id(2)
    new_shift.organization = Organization.find_by_name("Student Dormitory Council")
    new_shift.save!

    new_shift = Shift.new
    new_shift.ends_at = Time.now + 15.hours
    new_shift.required_number_of_participants = 3
    new_shift.starts_at = Time.now + 1.hours
    new_shift.shift_type = ShiftType.find_by_id(3)
    new_shift.organization = Organization.find_by_name("Kappa Alpha Theta")
    new_shift.save!


    puts "ShiftParticipant"

    new_sp = ShiftParticipant.new
    new_sp.shift = Shift.find_by_id(1)
    new_sp.participant = Participant.find_by_id(1)
    new_sp.clocked_in_at = Time.now - 50.minutes
    new_sp.save!

    new_sp = ShiftParticipant.new
    new_sp.shift = Shift.find_by_id(1)
    new_sp.participant = Participant.find_by_id(3)
    new_sp.clocked_in_at = Time.now - 30.minutes
    new_sp.save!

    new_sp = ShiftParticipant.new
    new_sp.shift = Shift.find_by_id(1)
    new_sp.participant = Participant.find_by_id(2)
    new_sp.clocked_in_at = Time.now - 40.minutes
    new_sp.save!

    new_sp = ShiftParticipant.new
    new_sp.shift = Shift.find_by_id(1)
    new_sp.participant = Participant.find_by_id(4)
    new_sp.clocked_in_at = Time.now - 60.minutes
    new_sp.save!

    puts "Tool"

    new_tool = Tool.new
    new_tool.barcode = 923780
    new_tool.description = "HAMMER"
    new_tool.name = "Hammer"
    new_tool.save!

    new_tool = Tool.new
    new_tool.barcode = 923781
    new_tool.description = "SAW"
    new_tool.name = "Saw"
    new_tool.save!

    new_tool = Tool.new
    new_tool.barcode = 923782
    new_tool.description = "LADDER"
    new_tool.name = "Ladder"
    new_tool.save!

    new_tool = Tool.new
    new_tool.barcode = 923783
    new_tool.description = "HARD HAT"
    new_tool.name = "Hard Hat"
    new_tool.save!

    puts "Checkout"

    new_checkout = Checkout.new
    new_checkout.checked_in_at = Time.now - 10.hours
    new_checkout.checked_out_at = Time.now - 4.hours
    new_checkout.tool = Tool.find_by_name("Hammer")
    new_checkout.save!

    new_checkout = Checkout.new
    new_checkout.checked_in_at = Time.now - 11.hours
    new_checkout.checked_out_at = Time.now - 3.hours
    new_checkout.tool = Tool.find_by_name("Hammer")
    new_checkout.save!

    new_checkout = Checkout.new
    new_checkout.checked_in_at = Time.now - 12.hours
    new_checkout.checked_out_at = Time.now - 2.hours
    new_checkout.tool = Tool.find_by_name("Saw")
    new_checkout.save!

    new_checkout = Checkout.new
    new_checkout.checked_in_at = Time.now - 2.hours
    new_checkout.checked_out_at = Time.now - 1.hours
    new_checkout.tool = Tool.find_by_name("Hard Hat")
    new_checkout.save!

    puts "Charge"

    new_charge = Charge.new
    new_charge.charge_type = ChargeType.find_by_name("Meeting")
    new_charge.issuing_participant = Participant.find_by_andrewid("rcrown")
    new_charge.receiving_participant = nil
    new_charge.organization = Organization.find_by_name("Kappa Alpha Theta")
    new_charge.amount = 50.00
    new_charge.charged_at = Time.now - 1.days
    new_charge.description = "Missed 10/2 meeting"
    new_charge.save!

    new_charge = Charge.new
    new_charge.charge_type = ChargeType.find_by_name("Breaker")
    new_charge.issuing_participant = Participant.find_by_andrewid("rcrown")
    new_charge.receiving_participant = Participant.find_by_andrewid("asteger")
    new_charge.organization = Organization.find_by_name("Kappa Alpha Theta")
    new_charge.amount = 25.00
    new_charge.charged_at = Time.now - 2.days
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

    new_membership = Membership.new
    new_membership.participant = Participant.find_by_andrewid("lheimann")
    new_membership.organization = Organization.find_by_name("Student Dormitory Council")
    new_membership.booth_chair_order = nil
    new_membership.is_booth_chair = false
    new_membership.title = ""
    new_membership.save!

    new_membership = Membership.new
    new_membership.participant = Participant.find_by_andrewid("lheimann")
    new_membership.organization = Organization.find_by_name("Spring Carnival Committee")
    new_membership.booth_chair_order = nil
    new_membership.is_booth_chair = false
    new_membership.title = ""
    new_membership.save!

    puts
    puts "DB now contains simulated data!"
  end
end
