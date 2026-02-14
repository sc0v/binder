FactoryBot.define do
	factory :memberships do
		association :organization
		association :participant
		is_booth_chair { true }
		title { 'MyString' }
		booth_chair_order { 1 }
		is_in_csv { true }
		is_added_by_csv { true }
	end
end
