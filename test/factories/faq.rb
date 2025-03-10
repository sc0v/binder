FactoryBot.define do
	factory :faq do
		question { 'MyString' }
		answer { 'MyString' }
		association :organization_category
	end
end
