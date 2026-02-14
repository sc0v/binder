FactoryBot.define do
	factory :events do
		is_done { true }
		association :event_type
		description { 'MyString' }
		association :participant
	end
end
