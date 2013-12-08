# spec/support/mock_helpers.rb
require 'spec_helper'
include Warden::Test::Helpers

#Warden.test_mode!

module MockHelpers
  def create_mocks
    # Webmock
    stub_request(:any, "http://merichar-dev.eberly.cmu.edu/cgi-bin/card-lookup?card_id=#{1234}").to_return(:body => '{ "andrewid": "member_FG", "expiration": "2013-11-29T00:00:00+00:00" }', :status => 200, :headers => { 'Content-Length' => 17 })
    stub_request(:any, "http://merichar-dev.eberly.cmu.edu/cgi-bin/card-lookup?card_id=#{2345}").to_return(:body => '{ "andrewid": "rcrown_FG", "expiration": "2013-11-29T00:00:00+00:00" }', :status => 200, :headers => { 'Content-Length' => 17 })
    stub_request(:any, "http://merichar-dev.eberly.cmu.edu/cgi-bin/card-lookup?card_id=#{3456}").to_return(:body => '{ "andrewid": "shannon1_FG", "expiration": "2013-11-29T00:00:00+00:00" }', :status => 200, :headers => { 'Content-Length' => 17 })
    stub_request(:any, "http://merichar-dev.eberly.cmu.edu/cgi-bin/card-lookup?card_id=#{4567}").to_return(:body => '{ "andrewid": "dcorwin_FG", "expiration": "2013-11-29T00:00:00+00:00" }', :status => 200, :headers => { 'Content-Length' => 17 })
    stub_request(:any, "http://merichar-dev.eberly.cmu.edu/cgi-bin/card-lookup?card_id=#{4567}").to_return(:body => '{ "andrewid": "asteger_FG", "expiration": "2013-11-29T00:00:00+00:00" }', :status => 200, :headers => { 'Content-Length' => 17 })
    stub_request(:any, "http://merichar-dev.eberly.cmu.edu/cgi-bin/card-lookup?card_id=#{5678}").to_return(:body => '{ "andrewid": "juc_FG", "expiration": "2013-11-29T00:00:00+00:00" }', :status => 200, :headers => { 'Content-Length' => 17 })


    # Create 4 organization categories
    @blitz = FactoryGirl.create(:organization_category, :name => "Blitz")
    @independent = FactoryGirl.create(:organization_category, :name => "Independent")
    @frat = FactoryGirl.create(:organization_category, :name => "Fraternity")
    @sorority = FactoryGirl.create(:organization_category, :name => "Sorority")

    # Create 3 organizations
    @theta = FactoryGirl.create(:organization, :name => "Kappa Alpha Theta", :organization_category => @sorority)
    @sdc = FactoryGirl.create(:organization, :name => "Student Dormitory Council", :organization_category => @independent)
    @scc = FactoryGirl.create(:organization, :name => "Spring Carnival Committee", :organization_category => @independent)

    # Create 3 organization aliases
    @theta_alias = FactoryGirl.create(:organization_alias, :name => "Theta", :organization => @theta)
    @sdc_alias = FactoryGirl.create(:organization_alias, :name => "SDC", :organization => @sdc)
    @scc_alias = FactoryGirl.create(:organization_alias, :name => "SCC", :organization => @scc)

    # Create 3 shift types
    @watch_shift = FactoryGirl.create(:shift_type) #defaults to Watch Shift
    @security_shift = FactoryGirl.create(:shift_type, :name => "Security Shift")
    @coord_shift = FactoryGirl.create(:shift_type, :name => "Coordinator Shift")

    # Create 3 shifts
    @shift1 = FactoryGirl.create(:shift, :ends_at => Time.local(2000,1,1,15,0,0), :required_number_of_participants => 3, :starts_at => Time.local(2000,1,1,12,3,0), :organization => @theta)
    @shift2 = FactoryGirl.create(:shift, :ends_at => Time.local(2000,1,1,15,0,0), :required_number_of_participants => 3, :starts_at => Time.local(2000,1,1,13,4,0), :organization => @sdc)
    @shift3 = FactoryGirl.create(:shift, :ends_at => Time.local(2000,1,1,15,0,0), :required_number_of_participants => 3, :starts_at => Time.local(2000,1,1,14,10,0), :organization => @theta)

    #ORDER MATTERS: Participant first, then user.

    # Create 6 participants
    @member_participant = FactoryGirl.create(:participant, :andrewid => "member_FG", :user => @member_user)
    @rachel_participant = FactoryGirl.create(:participant, :andrewid => "rcrown_FG", :phone_number => 6178617669, :user => @rachel_user)
    @shannon_participant = FactoryGirl.create(:participant, :andrewid => "shannon1_FG", :phone_number => 4124124124, :user => @shannon_user)
    @dylan_participant = FactoryGirl.create(:participant, :andrewid => "dcorwin_FG", :phone_number => 4121235555, :user => @dylan_user)
    @alexis_participant = FactoryGirl.create(:participant, :andrewid => "asteger_FG", :phone_number => 5391234124, :user => @alexis_user)
    @jonathan_participant = FactoryGirl.create(:participant, :andrewid => "juc_FG", :phone_number => 4128675309, :user => @jonathan_user)

    # Create 5 users
    @member_user = FactoryGirl.create(:user, :participant => @member_participant)
    @member_user.add_role(:member)

    @rachel_user = FactoryGirl.create(:user, :name => "Rachel Crown", :email => "rcrown_FG@andrew.cmu.edu", :participant => @rachel_participant)
    @rachel_user.add_role(:admin)

    @dylan_user = FactoryGirl.create(:user, :name => "Dylan Corwin", :email => "dcorwin_FG@andrew.cmu.edu", :participant => @dylan_participant)
    @dylan_user.add_role(:admin)

    @alexis_user = FactoryGirl.create(:user, :name => "Alexis Steiger", :email => "asteiger_FG@andrew.cmu.edu", :participant => @alexis_participant)
    @alexis_user.add_role(:booth_chair)

    @shannon_user = FactoryGirl.create(:user, :name => "Shannon Chen", :email => "shannon1_FG@andrew.cmu.edu", :participant => @shannon_participant)
    @shannon_user.add_role(:scc)

    @jonathan_user = FactoryGirl.create(:user, :name => "Jonathan U Chung", :email => "jonathanc@cmu.edu", :participant => @jonathan_participant)
    @jonathan_user.add_role(:member)

    # Create 4 Shift Participants
    @sp1 = FactoryGirl.create(:shift_participant, :participant => @rachel_participant, :clocked_in_at => Time.now, :shift => @shift1)
    @sp2 = FactoryGirl.create(:shift_participant, :participant => @shannon_participant, :clocked_in_at => Time.now, :shift => @shift2)
    @sp3 = FactoryGirl.create(:shift_participant, :participant => @alexis_participant, :clocked_in_at => Time.now, :shift => @shift3)
    @sp4 = FactoryGirl.create(:shift_participant, :participant => @dylan_participant, :clocked_in_at => Time.now, :shift => @shift3)

    # Create 2 memberships
    @member_rachel = FactoryGirl.create(:membership, :participant => @rachel_participant, :organization => @scc)
    @member_alexis = FactoryGirl.create(:membership, :participant => @alexis_participant, :organization => @theta, :booth_chair_order => 1, :is_booth_chair => true, :title => nil)
    @member_member = FactoryGirl.create(:membership, :participant => @member_participant, :organization => @sdc)

    # Create 2 charge types
    @miss_meeting = FactoryGirl.create(:charge_type, :default_amount => 100.00, :description => "Missed a meeting", :name => "Meeting", :requires_booth_chair_approval => false)
    @trip_breaker = FactoryGirl.create(:charge_type, :default_amount => 200.00, :description => "Tripped a breaker", :name => "Breaker", :requires_booth_chair_approval => true)

    # Create 2 charges
    @meeting_fine = FactoryGirl.create(:charge, :charge_type => @miss_meeting, :issuing_participant => @rachel_participant, :receiving_participant => nil, :organization => @theta, :amount => 50.00, :charged_at => Date.today, :description => "Missed 10/2 meeting")
    @breaker_fine = FactoryGirl.create(:charge, :charge_type => @trip_breaker, :issuing_participant => @rachel_participant, :receiving_participant => @alexis_participant, :organization => @theta, :amount => 25.00, :charged_at => Date.today-1, :description => "Breaker trip")

    # Create 3 task statuses
    @complete = FactoryGirl.create(:task_status, :name => "Complete")
    @incomplete = FactoryGirl.create(:task_status, :name => "Not Completed")
    @in_progress = FactoryGirl.create(:task_status, :name => "Unable To Complete")

    #Create 2 task categories
    @busy_work = FactoryGirl.create(:task_category, :name => "Busy Work")
    @maintinance = FactoryGirl.create(:task_category, :name => "Maintinance")
    
    # Create 3 tasks
    @assign_rides = FactoryGirl.create(:task, :completed_by => @rachel_participant, :task_status => @incomplete, :due_at => Time.local(2000,1,1,12,3,0))
    @buy_wood = FactoryGirl.create(:task, :name => "Buy wood", :task_category => @busy_work, :completed_by => @shannon_participant, :task_status => @in_progress, :due_at => Time.local(2000,1,1,15,0,0))
    @takeout_trash = FactoryGirl.create(:task, :name => "Take-out trash", :task_category => @maintinance, :completed_by => @dylan_participant, :task_status => @complete, :due_at => Time.local(2020,1,1,15,0,0))
        
    # Create 4 tools
    @hammer = FactoryGirl.create(:tool)
    @saw = FactoryGirl.create(:tool, :barcode => 1239043, :description => "SAW", :name => "Saw")
    @ladder = FactoryGirl.create(:tool, :barcode => 120120, :description => "LADDER", :name => "Ladder")
    @hard_hat = FactoryGirl.create(:tool, :barcode => 1280812, :description => "HARD HAT", :name => "Hard Hat")

    # Create 4 checkouts
    @hammer_checkout1 = FactoryGirl.create(:checkout, :checked_in_at => Time.now + 2.days, :tool => @hammer)
    @hammer_checkout2 = FactoryGirl.create(:checkout, :checked_in_at => Time.now + 3.days, :tool => @hammer, :organization => @sdc)
    @saw_checkout = FactoryGirl.create(:checkout, :checked_in_at => Time.now + 2.days, :tool => @saw, :organization => @theta, :participant => @shannon_participant)
    @hard_hat_checkout = FactoryGirl.create(:checkout, :checked_in_at => Time.now + 2.days, :tool => @hard_hat, :organization => @theta)
    #still checked out
    @hammer_checkout2 = FactoryGirl.create(:checkout, :tool => @hammer, :organization => @sdc)
    
    @Faqs = [
      FactoryGirl.create(:faq, :question => "What is Booth?", :answer => "Booth is one of the biggest showpieces of Spring Carnival. Student organizations build multi-story structures around our annual theme (2014: Best of the Best), hosting interactive games and elaborate decorations. The booths will be placed on Midway, which is located in the Morewood Gardens Parking Lot."), 
      FactoryGirl.create(:faq, :question => "What do I do if something catches on fire?", :answer => "There are fire extinguishers located at every booth. Take one and follow the instructions listed on the can."), 
      FactoryGirl.create(:faq, :question => "Where does CMU get money for Carnival?", :answer => "Carnegie Mellon University's Spring Carnival is funded in part by your Student Activities Fee."), 
      FactoryGirl.create(:faq, :question => "Who won booth last year (2013)?", :answer => "Independent: ASA, Fraternity: Sigma Phi Epsilon, Sorority: Delta Gamma, Blitz: Mayur SASA, Environmental Award: Delta Gamma and Mudge, T-Shirt Award: TSA, Chairman's Choice: Alpha Phi"), 
      FactoryGirl.create(:faq, :question => "What are the hours of rides?", :answer => "TBD"),   
      FactoryGirl.create(:faq, :question => "How much are rides tickets?", :answer => "TBD"), 
      FactoryGirl.create(:faq, :question => "Are there group rates for rides tickets?", :answer => "No."), 
      FactoryGirl.create(:faq, :question => "Where do you pick up presale tickets?", :answer => "UC Info Desk"), 
      FactoryGirl.create(:faq, :question => "Can I get a wristband for the comedian?", :answer => "Spring Carnival does not deal with the comedian. Talk to AB."), 
      FactoryGirl.create(:faq, :question => "Where do I go for the green room security shift?", :answer => "Morewood multipurpose room. You need a radio and jackets. And no, you cannot eat the food."), 
      FactoryGirl.create(:faq, :question => "What do I do if the comedian shows up?", :answer => "Call student activities (Tim)."), 
      FactoryGirl.create(:faq, :question => "Alumni is complaining about their tent.", :answer => "Call Nick."), 
      FactoryGirl.create(:faq, :question => "Alumni needs something special.", :answer => "Call Jackson or Emily."), 
      FactoryGirl.create(:faq, :question => "When do dumpsters go out?", :answer => "They must be by the back of Morewood lot by 5am."), 
      FactoryGirl.create(:faq, :question => "What is downtime?", :answer => "When a booth takes time to close their booth and have it not manned during operations. They must register the start of their downtime (you should track this) and put caution tape up to close off the doorways. They should also tell you when they are ending their downtime."), 
      FactoryGirl.create(:faq, :question => "How much downtime does an org get?", :answer => "4 hours."), 
      FactoryGirl.create(:faq, :question => "How do I check how much downtime an org has left?", answer: "TBD"), 
      FactoryGirl.create(:faq, :question => "A booth tripped a breaker. What do I do?", :answer => "Add them to Dan's queue. Mark the fine in app if applicable."), 
      FactoryGirl.create(:faq, :question => "Someone has a minor injury (splinter, small cut, dust in eye, etc.).", :answer => "Give them equipment from the medical kit in the trailer. Tell them they can call EMS if they want. DO NOT ADMINISTER MEDICAL ASSISTANCE."), 
      FactoryGirl.create(:faq, :question => "EMS is closed. What do I do?", :answer => "Call them."), 
      FactoryGirl.create(:faq, :question => "I saw an ambulance take someone to the hospital. What do I do?",answer: "Call Jackson or Emily immediately."), 
      FactoryGirl.create(:faq, :question => "Someone wants to drop off in the firelane. Can they do that?", :answer => "No, unless they are Cyert, food delivery for Underground, fire, police, EMS, FMS, people with passes, or an approved delivery (Rachel, Emily, or Jackson says it's OK)."), 
      FactoryGirl.create(:faq, :question => "Golf cart problem?", :answer => "Call Meg."), 
      FactoryGirl.create(:faq, :question => "Missing golf cart.", :answer => "Call Meg."), 
      FactoryGirl.create(:faq, :question => "If someone legitimately needs a golf cart...", :answer => "...radio for golfcart."), 
      FactoryGirl.create(:faq, :question => "A booth chair is freaking out, sad, angry, etc. What do I do?", :answer => "Call Rachel."), 
      FactoryGirl.create(:faq, :question => "University official wants to borrow something. What do I do?", :answer => "Let them. They do not need to sign a waiver. Ideally, check it out to Jackson, Emily, or Rachel to track it in the app."), 
      FactoryGirl.create(:faq, :question => "The next coordinator doesn't show up. What do I do?", :answer => "Call them repeatedly. If that fails, call the Nicks."), 
      FactoryGirl.create(:faq, :question => "Booth watch shift doesn't show up. What do I do?", :answer => "Do not let previous watch shift leave. Call booth chairs of that org in order until someone answers. Fine them accordingly in the app. If no one can show up and old watch shift has to leave, split the other watch shift."), 
      FactoryGirl.create(:faq, :question => "Drunk people won't listen. What do I do?", :answer => "Call the police."), 
      FactoryGirl.create(:faq, :question => "Booth chair is asking questions I don't understand. What do I do?", :answer => "Put them in Rachel's queue. Leave a note if necessary."), 
      FactoryGirl.create(:faq, :question => "Parking complains about Asian row. What do I do?", answer: "Tell Asian row to clear their stuff out. If they won't listen, call Rachel."), 
      FactoryGirl.create(:faq, :question => "What should the 12am-4am watch shifts do?", :answer => "MOVE THE DUMPSTERS TO THE FIRELANE BY THE TENT. Check the radio station. Make sure no one is doing anything stupid (climbing on roofs, having sex in booths, etc.)."), 
      FactoryGirl.create(:faq, :question => "What's the difference between a security and watch shift?", :answer => "Security is paid, watch is not. Watch shifts are booth orgs, while security are non-building orgs."), 
      FactoryGirl.create(:faq, :question => "What do I do with my drunk watch/security shift that just showed up?", :answer => "Send them home, call their booth chair, and inform them of what happened and that they are getting fined unless they supply new, sober people."), 
      FactoryGirl.create(:faq, :question => "AB tech asks for the keys to the scissor lift.", :answer => "Call Nick."), 
      FactoryGirl.create(:faq, :question => "Taylor Rental needs something.", :answer => "Call Nick."), 
      FactoryGirl.create(:faq, :question => "Where do I find the midway layout?", :answer => "In the app, under documents!"), 
      FactoryGirl.create(:faq, :question => "Madelyn Miller calls. What do I do?", :answer => "Listen to her. Then call Emily/Jackson/Rachel and relay the message."), 
      FactoryGirl.create(:faq, :question => "It's raining and people are losing electricity.", :answer => "Wait until the rain stops, then tell them to suck it up and we'll deal with it."), 
      FactoryGirl.create(:faq, :question => "It's super windy. Things are flying off of booths.", :answer => "Check weather on trailer computer. Call Emily/Jackson/Rachel with that information.")
    ]
    
    #Coordinator Shifts
    @Coordinator_Shifts = [
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-04T20:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-04T20:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-05T00:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T00:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-05T04:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T04:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-05T08:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T08:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-05T12:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T12:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-05T16:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T16:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-05T20:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T20:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-06T00:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T00:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-06T04:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T04:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-06T08:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T08:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-06T12:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T12:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-06T16:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T16:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-06T20:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T20:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-07T00:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T00:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-07T04:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T04:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-07T08:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T08:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-07T12:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T12:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-07T16:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T16:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-07T20:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T20:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-08T00:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T00:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-08T04:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T04:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-08T08:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T08:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-08T12:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T12:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-08T16:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T16:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-08T20:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T20:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-09T00:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T00:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-09T04:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T04:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-09T08:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T08:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-09T12:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T12:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-09T16:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T16:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-09T20:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T20:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-10T00:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T00:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-10T04:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T04:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-10T08:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T08:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-10T12:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T12:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-10T16:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T16:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-10T20:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T20:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-11T00:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T00:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-11T04:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T04:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-11T08:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T08:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-11T12:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T12:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-11T16:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T16:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-11T20:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T20:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-12T00:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T00:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-12T04:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T04:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-12T08:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T08:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-12T12:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T12:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-12T16:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T16:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-12T20:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T20:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-13T00:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-13T00:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-13T04:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-13T04:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-13T08:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-13T08:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 ), 
      FactoryGirl.create(:shift, :shift_type => @coord_shift, :starts_at => DateTime.rfc3339('2014-04-13T12:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-13T12:00:00+05:00') + 4.hours, :organization => @scc, :required_number_of_participants => 1 )
    ]

    # Watch Shifts
    @Watch_Shifts = [
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-04T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-04T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-04T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-04T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-04T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-04T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-04T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-04T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T01:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T01:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T03:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T03:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T05:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T05:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T07:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T07:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T09:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T09:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T01:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T01:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T03:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T03:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T05:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T05:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T07:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T07:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T09:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T09:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T01:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T01:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T03:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T03:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T05:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T05:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T07:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T07:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T09:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T09:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T01:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T01:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T03:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T03:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T05:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T05:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T07:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T07:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T09:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T09:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T01:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T01:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T03:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T03:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T05:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T05:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T07:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T07:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T09:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T09:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T01:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T01:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T03:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T03:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T05:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T05:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T07:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T07:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T09:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T09:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T01:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T01:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T03:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T03:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T05:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T05:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T07:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T07:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T09:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T09:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T01:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T01:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T03:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T03:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T05:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T05:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T07:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T07:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T09:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T09:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-13T01:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-13T01:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-13T03:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-13T03:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-13T05:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-13T05:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-13T07:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-13T07:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-13T09:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-13T09:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-13T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-13T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-13T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-13T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-13T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-13T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-04T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-04T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-04T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-04T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-04T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-04T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T01:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T01:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T03:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T03:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T05:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T05:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T07:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T07:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T09:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T09:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T01:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T01:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T03:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T03:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T05:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T05:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T07:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T07:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T09:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T09:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T01:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T01:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T03:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T03:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T05:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T05:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T07:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T07:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T09:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T09:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T01:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T01:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T03:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T03:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T05:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T05:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T07:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T07:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T09:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T09:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T01:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T01:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T03:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T03:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T05:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T05:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T07:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T07:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T09:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T09:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T01:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T01:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T03:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T03:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T05:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T05:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T07:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T07:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T09:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T09:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T01:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T01:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T03:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T03:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T05:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T05:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T07:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T07:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T09:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T09:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T01:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T01:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T03:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T03:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T05:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T05:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T07:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T07:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T09:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T09:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-13T01:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-13T01:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-13T03:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-13T03:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-13T05:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-13T05:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-13T07:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-13T07:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-13T09:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-13T09:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-13T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-13T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-13T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-13T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-13T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-13T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-04T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-04T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-04T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-04T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-04T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-04T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-05T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-05T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-06T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-06T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-07T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-08T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-09T23:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T23:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T07:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T07:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T09:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T09:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-10T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-10T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-11T21:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-11T21:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T11:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T11:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T13:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T13:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T15:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T15:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T17:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T17:00:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @watch_shift, :starts_at => DateTime.rfc3339('2014-04-12T19:00:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-12T19:00:00+05:00') + 2.hours, :required_number_of_participants => 2 )
    ]

    # Security Shifts
    @Security_Shifts = [
      FactoryGirl.create(:shift, :shift_type => @sec_shift, :starts_at => DateTime.rfc3339('2014-04-07T07:30:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T07:30:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @sec_shift, :starts_at => DateTime.rfc3339('2014-04-07T09:30:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T09:30:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @sec_shift, :starts_at => DateTime.rfc3339('2014-04-07T11:30:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T11:30:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @sec_shift, :starts_at => DateTime.rfc3339('2014-04-07T13:30:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T13:30:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @sec_shift, :starts_at => DateTime.rfc3339('2014-04-07T15:30:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-07T15:30:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @sec_shift, :starts_at => DateTime.rfc3339('2014-04-08T07:30:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T07:30:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @sec_shift, :starts_at => DateTime.rfc3339('2014-04-08T09:30:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T09:30:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @sec_shift, :starts_at => DateTime.rfc3339('2014-04-08T11:30:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T11:30:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @sec_shift, :starts_at => DateTime.rfc3339('2014-04-08T13:30:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T13:30:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @sec_shift, :starts_at => DateTime.rfc3339('2014-04-08T15:30:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-08T15:30:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @sec_shift, :starts_at => DateTime.rfc3339('2014-04-09T07:30:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T07:30:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @sec_shift, :starts_at => DateTime.rfc3339('2014-04-09T09:30:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T09:30:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @sec_shift, :starts_at => DateTime.rfc3339('2014-04-09T11:30:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T11:30:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @sec_shift, :starts_at => DateTime.rfc3339('2014-04-09T13:30:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T13:30:00+05:00') + 2.hours, :required_number_of_participants => 2 ), 
      FactoryGirl.create(:shift, :shift_type => @sec_shift, :starts_at => DateTime.rfc3339('2014-04-09T15:30:00+05:00'), :ends_at => DateTime.rfc3339('2014-04-09T15:30:00+05:00') + 2.hours, :required_number_of_participants => 2 )
    ]

  end

  def destroy_mocks
    # Destroy 4 organization categories
    @blitz.destroy
    @independent.destroy
    @frat.destroy
    @sorority.destroy

    # Destroy 3 organizations
    @theta.destroy
    @sdc.destroy
    @scc.destroy

    # Destroy 3 organization aliases
    @theta_alias.destroy
    @sdc_alias.destroy
    @scc_alias.destroy

    # Destroy 2 charge types
    @miss_meeting.destroy
    @trip_breaker.destroy

    # Destroy 4 participants
    @rachel_participant.destroy
    @shannon_participant.destroy
    @dylan_participant.destroy
    @alexis_participant.destroy
    @member_participant.destroy
    @jonathan_participant.destroy

    # Destroy task status
    @complete.destroy
    @incomplete.destroy
    @in_progress.destroy
    
    # Destroy Task Category
    @busy_work.destroy
    @maintinance.destroy

    # Destroy 3 tasks
    @assign_rides.destroy
    @buy_wood.destroy
    @takeout_trash.destroy

    # Destroy 3 shift types
    @watch_shift.destroy
    @security_shift.destroy
    @coord_shift.destroy

    # Destroy 3 shifts
    @shift1.destroy
    @shift2.destroy
    @shift3.destroy

    # Destroy 4 shift_participants
    @sp1.destroy
    @sp2.destroy
    @sp3.destroy
    @sp4.destroy

    # Destroy 4 tools
    @hammer.destroy
    @saw.destroy
    @ladder.destroy
    @hard_hat.destroy

    # Destroy 4 checkouts
    @hammer_checkout1.destroy
    @hammer_checkout2.destroy
    @saw_checkout.destroy
    @hard_hat_checkout.destroy

    # Destroy 2 charges
    @meeting_fine.destroy
    @breaker_fine.destroy

    # Destroy 2 memberships
    @member_rachel.destroy
    @member_alexis.destroy

    # Destroy 5 users
    @member_user.destroy
    @alexis_user.destroy
    @shannon_user.destroy
    @rachel_user.destroy
    @jonathan_user.destroy

    #mass assignment
    @Faqs.each { |item| item.destroy }
    @Coordinator_Shifts.each { |item| item.destroy }
    @Security_Shifts.each { |item| item.destroy }
    @Watch_Shifts.each { |item| item.destroy }

  end
end