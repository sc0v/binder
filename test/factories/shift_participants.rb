FactoryBot.define do
	factory :shift_participants do
		association :shift
		association :participant
		clocked_in_at { Time.now }
	end
end
