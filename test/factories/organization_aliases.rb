FactoryBot.define do
	factory :organization_aliases do
		name { 'MyString' }
		association :organization
	end
end
