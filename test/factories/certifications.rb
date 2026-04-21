FactoryBot.define do
	factory :certifications do
		association :participant
		association :certification_type
	end
end
