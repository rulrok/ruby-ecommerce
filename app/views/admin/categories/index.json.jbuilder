json.array!(@admin_categories) do |admin_category|
  # json.extract! admin_category, :id, :name, :parent_id
  json.id admin_category.id
  json.text admin_category.name

  if admin_category.parent_id?
    json.parent admin_category.parent_id
  else
    json.parent '#'
    json.state { json.opened true }
  end
  # json.url admin_category_url(admin_category, format: :json)
end
