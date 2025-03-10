FactoryBot.define do
	factory :delayed_jobs do
		priority { 1 }
		attempts { 1 }
		handler { 'MyString' }
		last_error { 'MyString' }
		run_at { Time.now }
		locked_at { Time.now }
		failed_at { Time.now }
		locked_by { 'MyString' }
		queue { 'MyString' }
	end
end
