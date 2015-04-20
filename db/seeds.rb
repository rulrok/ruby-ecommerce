# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create(id: 1, name: 'administrator')
Role.create(id: 2, name: 'customer')
User.create(id: 1, role_id: 1, first_name: 'Reuel', last_name: 'Ribeiro', email: 'rulrok@gmail.com', password: '123')
Setting.create(key: 'title', value: 'My eCommerce site')
Category.create(id: 1, name: 'Product', ancestry: nil, 'ancestry_depth' => 0)

OrderStatus.delete_all
OrderStatus.create! id: 1, name: 'Opened'
OrderStatus.create! id: 10, name: 'In Progress'
OrderStatus.create! id: 20, name: 'Paid'
OrderStatus.create! id: 30, name: 'Shipped'
OrderStatus.create! id: 40, name: 'Cancelled'

Province.create(id: 1, name: 'Alberta', code: 'AB', pst: 0, gst: 0.05, hst: 0)
Province.create(id: 2, name: 'British Columbia', code: 'BC', pst: 0.07, gst: 0.05, hst: 0)
Province.create(id: 3, name: 'Manitoba', code: 'MB', pst: 0.08, gst: 0.05, hst: 0)
Province.create(id: 4, name: 'New Brunswick', code: 'NB', pst: 0, gst: 0, hst: 0.13)
Province.create(id: 5, name: 'Newfoundland and Labrador', code: 'NL', pst: 0, gst: 0, hst: 0.13)
Province.create(id: 6, name: 'Northwest Territories', code: 'NT', pst: 0, gst: 0.05, hst: 0)
Province.create(id: 7, name: 'Nova Scotia', code: 'NS', pst: 0, gst: 0, hst: 0.15)
Province.create(id: 8, name: 'Nunavut', code: 'NU', pst: 0, gst: 0.05, hst: 0)
Province.create(id: 9, name: 'Ontario', code: 'ON', pst: 0, gst: 0, hst: 0.13)
Province.create(id: 10, name: 'Prince Edward Island', code: 'PE', pst: 0, gst: 0, hst: 0.14)
Province.create(id: 11, name: 'Quebec', code: 'QC', pst: 0.09, gst: 0.05, hst: 0)
Province.create(id: 12, name: 'Saskatchewan', code: 'SK', pst: 0.05, gst: 0.05, hst: 0)
Province.create(id: 13, name: 'Yukon', code: 'YT', pst: 0, gst: 0.05, hst: 0)

