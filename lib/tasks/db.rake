namespace :db do
  desc 'TODO'
  task clear_unimportant: :environment do
    Payment.delete_all
    OrderItem.delete_all
    Order.delete_all
  end
end
