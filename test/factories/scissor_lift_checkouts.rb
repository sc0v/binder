FactoryBot.define do
	factory :scissor_lift_checkouts do
		association :scissor_lift
		association :participant
		association :organization
		checked_out_at { Time.now }
		checked_in_at { Time.now }
		due_at { Time.now }
		is_forfeit { true }
	end
end
