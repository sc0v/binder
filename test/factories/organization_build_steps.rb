FactoryBot.define do
	factory :organization_build_steps do
		title { 'MyString' }
		requirements { 'MyString' }
		step { 1 }
		completed { true }
		association :organization_build_status
	end
end
