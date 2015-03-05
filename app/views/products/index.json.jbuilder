json.array!(@products) do |product|
  json.extract! product, :id, :product_name, :product_description, :category_id, :quantity_per_unit, :unit_price, :discount, :discount_available, :unit_weight, :unit_in_stock, :product_available, :picture_url
  json.url product_url(product, format: :json)
end
