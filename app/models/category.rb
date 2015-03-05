class Category < ActiveRecord::Base

  belongs_to :parent, class_name: :Product, foreign_key: :parent_id
  has_many  :children, class_name: :Product, foreign_key: :parent_id

end
