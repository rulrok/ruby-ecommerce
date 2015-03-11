class Category < ActiveRecord::Base

  has_many :products

  belongs_to :parent, class_name: :Category, foreign_key: :parent_id
  has_many :children, class_name: :Category, foreign_key: :parent_id

  public

  def self.primary_categories
    root = Category.where(:parent => nil)
    Category.where(:parent => root_category)
  end

  def self.secondary_categories
    Category.where.not(:parent => root_category) #The sweetness of a not statement, what a joy :D
  end

  def self.children parent_id
    Category.where(:parent => parent_id)
  end
  protected

  def self.root_category
    Category.where(:parent => nil)
  end
end
