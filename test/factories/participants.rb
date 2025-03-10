FactoryBot.define do
	factory :participants do
		eppn { 'MyString' }
		signed_waiver { true }
		phone_number { 'MyString' }
		cached_name { 'MyString' }
		cached_surname { 'MyString' }
		cached_email { 'MyString' }
		cached_department { 'MyString' }
		cached_student_class { 'MyString' }
		cache_updated { Time.now }
		admin { true }
		watched_safety_video { true }
	end
end
