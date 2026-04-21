FactoryBot.define do
	factory :tool_inventory_tools do
		barcode { 1 }
		description { 'MyString' }
		active { true }
		association :tool_type
		association :tool_inventory
	end
end
