FactoryBot.define do
	factory :tools do
		barcode { 1 }
		description { 'MyString' }
		association :tool_type
		active { true }
	end
end
