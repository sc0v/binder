# frozen_string_literal: true

FactoryBot.define do
  # Tool Barcodes
  sequence :barcode do |n|
    "123#{n}"
  end

  # Random Strings
  sequence :random_string do |n|
    "text#{n}"
  end

  # charge
  factory :charge do
    amount { 100.00 }
    charged_at { Time.zone.today }
    description { 'Missed 10/2 meeting' }

    association :charge_type
    association :organization
    association :issuing_participant
    association :creating_participant
  end

  # charge_type
  factory :charge_type do
    name { generate(:random_string) }
  end

  # checkout
  factory :checkout do
    checked_out_at { 1.hour.ago }

    association :tool
    association :organization
    association :participant
  end

  # event
  factory :event do
    association :event_type
    association :participant
  end

  # event_type
  factory :event_type do
    name { generate(:random_string) }
  end

  # faq
  factory :faq do
    question { 'MyText' }
    answer { 'MyText' }
  end

  # membership
  factory :membership do
    is_booth_chair { false }

    association :organization
    association :participant
  end

  # organization
  factory :organization do
    name { generate(:random_string) }

    association :organization_category
  end

  # organization_category
  factory :organization_category do
    name { generate(:random_string) }
  end

  # organization_timeline_entry
  factory :organization_timeline_entry do
    description { generate(:random_string) }
    started_at { 2.hours.ago }
    entry_type { 0 }

    association :organization
  end

  # participant
  factory :participant,
          aliases: %i[
            completed_by
            creating_participant
            issuing_participant
            receiving_participant
          ] do
    eppn { "#{generate(:random_string)}@andrew.cmu.edu" }
    phone_number { '412-555-0100' }
    signed_waiver { true }
  end

  # shift
  factory :shift do
    ends_at { 2.days.ago }
    capacity { 3 }
    starts_at { 3.days.ago }

    association :organization
    association :shift_type
  end

  # shift_participant
  factory :shift_participant do
    clocked_in_at { Time.zone.local(2000, 1, 1, 12, 3, 0) }

    association :participant
    association :shift
  end

  # shift_type
  factory :shift_type do
    name { generate(:random_string) }
  end

  # task
  factory :task do
    due_at { Time.zone.today }
    name { 'Assign rides' }
  end

  # tool type
  factory :tool_type do
    name { 'Hammer' }
  end

  # tool
  factory :tool do
    barcode { generate(:barcode) }
    description { 'HAMMER' }
    association :tool_type
  end

  # store_purchase
  factory :store_purchase do
    association :store_item
  end

  # store_item
  factory :store_item do
    name { generate(:random_string) }
    price { 5.00 }
  end
end
