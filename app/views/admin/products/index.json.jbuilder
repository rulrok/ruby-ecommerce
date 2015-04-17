json.array!(@admin_products) do |admin_product|
  json.extract! admin_product, :id, :product_name, :product_long_description,
                :category_id, :quantity_per_unit, :unit_price, :discount,
                :discount_available, :unit_weight, :unit_in_stock,
                :product_available, :picture_url
  json.url admin_product_url(admin_product, format: :json)
end
