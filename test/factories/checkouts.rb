FactoryBot.define do
	factory :checkouts do
		association :tool
		checked_out_at { Time.now }
		checked_in_at { Time.now }
		association :participant
		association :organization
	end
end
