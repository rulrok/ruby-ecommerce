json.array!(@all_categories) do |category|
  # json.extract! admin_category, :id, :name, :parent_id
  json.id category.id
  json.text category.name
  json.depth category.depth
  if category.is_root?
    json.parent '#'
    json.state { json.opened true }
    json.icon false
  else
    json.parent category.parent_id

  end
  # json.url admin_category_url(admin_category, format: :json)
end
