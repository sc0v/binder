FactoryBot.define do
	factory :shifts do
		starts_at { Time.now }
		ends_at { Time.now }
	end
end
