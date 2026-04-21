FactoryBot.define do
	factory :charge_types do
		name { 'MyString' }
		requires_booth_chair_approval { true }
		default_amount { 1 }
		description { 'MyString' }
	end
end
