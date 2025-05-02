FactoryBot.define do
	factory :charges do
		association :organization
		association :charge_type
		amount { 1 }
		description { 'MyString' }
		association :issuing_participant
		association :receiving_participant
		charged_at { Time.now }
		is_approved { true }
		association :creating_participant
	end
end
