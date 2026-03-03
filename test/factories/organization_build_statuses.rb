FactoryBot.define do
	factory :organization_build_statuses do
		association :organization
		status_type { 'MyString' }
	end
end
