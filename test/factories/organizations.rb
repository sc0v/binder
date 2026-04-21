FactoryBot.define do
	factory :organizations do
		name { 'MyString' }
		association :organization_category
		short_name { 'MyString' }
	end
end
