FactoryBot.define do
	factory :tasks do
		due_at { Time.now }
		# TODO: Rename variable if it is not intended as a FK
		completed_by_id { 1 }
		name { 'MyString' }
		description { 'MyString' }
		is_completed { true }
	end
end
