FactoryBot.define do
	factory :tool_type_certifications do
		association :tool_type
		association :certification_type
	end
end
