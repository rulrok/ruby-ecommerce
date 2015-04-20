json.array!(@provinces) do |admin_province|
  json.extract! admin_province, :name, :code, :pst, :gst, :hst
  json.url admin_province_url(admin_province, format: :json)
end
