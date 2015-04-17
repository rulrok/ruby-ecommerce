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
OrderStatus.create! id: 1, name: 'In Progress'
OrderStatus.create! id: 2, name: 'Placed'
OrderStatus.create! id: 3, name: 'Shipped'
OrderStatus.create! id: 4, name: 'Cancelled'
