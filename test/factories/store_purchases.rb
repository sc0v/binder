FactoryBot.define do
	factory :store_purchases do
		association :charge
		association :store_item
		price_at_purchase { 1 }
		quantity_purchased { 1 }
	end
end
