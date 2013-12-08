FactoryGirl.define do

  # charge
  factory :charge do
    amount 100.00
    charged_at Date.today
    description "Missed 10/2 meeting"

    association :charge_type
    association :organization
    association :issuing_participant
  end

  # charge_type
  factory :charge_type do
    default_amount 100.00
    description "Missed a meeting"
    name "Meeting"
    requires_booth_chair_approval false
  end

  # checkout
  factory :checkout do
    checked_out_at Time.now
    checked_in_at nil

    association :tool
  end

  # contact_list
  factory :contact_list do
    association :participant
  end

  # document
  factory :document do
    name "MyString"
    url "MyString"
  end

  # faq
  factory :faq do
    question "MyText"
    answer "MyText"
  end

  # membership
  factory :membership do
    is_booth_chair false
    association :organization
    association :participant
  end

  # organization
  factory :organization do
    name "Test Org"

    association :organization_category
  end

  # organization_alias
  factory :organization_alias do
    name "Test Alias"

    association :organization
  end

  # organization_category
  factory :organization_category do
    name "Test Category"
  end

  # participant
  factory :participant, :aliases => [:completed_by, :issuing_participant, :receiving_participant] do
    andrewid "default_factory_andrew_id" #this should always be overridden
    has_signed_hardhat_waiver true
    has_signed_waiver true
    phone_number 1234567890
  end

  # shift
  factory :shift do
    ends_at Time.now - 2.days
    required_number_of_participants 3
    starts_at Time.now - 3.days

    #should not require and organization association
  end

  # shift_participant
  factory :shift_participant do
    clocked_in_at Time.local(2000,1,1,12,3,0)

    association :participant
    association :shift
  end

  # shift_type
  factory :shift_type do
    name "Watch Shift"
  end

  # task
  factory :task do
    due_at Date.today
    name "Assign rides"

    association :task_status
    association :completed_by
  end

  # task_category
  factory :task_category do
    name "Default Task Category"
  end

  # task_status
  factory :task_status do
    name "Test Status"
  end


  # tool
  factory :tool do
    barcode 123780890
    description "HAMMER"
    name "Hammer"
  end

  # user
  factory :user do
    name "Default Factory User"
    email "default_factory_andrew_id@andrew.cmu.edu"
    password "testtest"
    password_confirmation "testtest"
    association :participant
  end

end