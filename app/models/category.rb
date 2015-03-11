class Category < ActiveRecord::Base

  has_ancestry :orphan_strategy => :restrict, :cache_depth => true

  has_many :products

  validates_presence_of :name, :ancestry, :ancestry_depth

  #Ensures that we cannot have a duplicated category on the same level of the category tree
  validates_uniqueness_of :name, :scope => [:ancestry]

  # belongs_to :parent, class_name: :Category, foreign_key: :parent_id
  # has_many :children, class_name: :Category, foreign_key: :parent_id

  public

  def self.primary_categories
    Category.at_depth(1)
  end

  def self.secondary_categories
    Category.at_depth(2)
  end

  # def self.children parent_id
  #   Category.where(:parent => parent_id)
  # end

  def self.root_category
    Category.at_depth(0)
  end

end
