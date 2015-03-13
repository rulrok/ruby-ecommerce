json.extract! @sub_tree
# json.array!(@sub_tree) do |child|
#   # json.extract! admin_category, :id, :name, :parent_id
#   json.id child.id
#   json.text child.name
#
#   if child.parent_id?
#     json.parent child.parent_id
#   else
#     json.parent '#'
#     json.state { json.opened true }
#   end
#   # json.url admin_category_url(admin_category, format: :json)
# end