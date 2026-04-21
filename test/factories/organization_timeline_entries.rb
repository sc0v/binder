FactoryBot.define do
	factory :organization_timeline_entries do
		started_at { Time.now }
		ended_at { Time.now }
	end
end
