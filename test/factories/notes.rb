FactoryBot.define do
	factory :notes do
		association :participant
		association :organization
		hidden { true }
		title { 'MyString' }
		value { 'MyString' }
		color { 'MyString' }
	end
end
