class Category < ActiveRecord::Base

  has_ancestry :orphan_strategy => :adopt, :cache_depth => true

  has_many :products, :dependent => :restrict_with_exception

  validates_presence_of :name, :ancestry, :ancestry_depth

  #Ensures that we cannot have a duplicated category on the same level of the category tree
  validates_uniqueness_of :name, :scope => [:ancestry]

  public

  def self.primary_categories
    Category.at_depth(1)
  end

  def self.secondary_categories
    Category.at_depth(2)
  end

  def self.find_children parent_id
    begin
      parent = Category.find(parent_id)
      parent.children
    rescue
      nil
    end
  end

  def self.root_category
    Category.at_depth(0)
  end

end
