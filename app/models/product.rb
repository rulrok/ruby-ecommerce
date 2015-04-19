class Product < ActiveRecord::Base
  belongs_to :category

  attr_accessor :image_delete

  # In case that a new style has to be added
  # look that page:
  # https://github.com/thoughtbot/paperclip/wiki/Thumbnail-Generation
  has_attached_file :photo,
                    styles:
                        { mini: '80x80>', small: '150x150>' },
                    url:
                        '/assets/products/:id/:style/:basename.:extension',
                    path:
                        ':rails_root/public/assets/products/'\
                        ':id/:style/:basename.:extension',
                    default_url:
                        '/images/no_picture.png'

  # has_destroyable_file :photo

  has_many :order_items

  # default_scope { where(active: true) }

  # validates_attachment_presence :photo
  validates_attachment_size :photo,
                            less_than: 5.megabytes

  validates_attachment_content_type :photo,
                                    content_type: ['image/jpeg', 'image/png']

  # Validations
  validates :product_name, :short_description, :category, :unit_price,
            :quantity_per_unit, :unit_weight, presence: true

  before_save { delete_photo if image_delete == '1' }

  # Search indexing

  searchable do
    text :product_name, :product_long_description

    integer :category_id,
            multiple: true,
            references: Category

    double :discount
    double :price

    boolean :product_available
    boolean :discount_available
    boost { :discount_available ? 2.0 : 1.0 }

    time :created_at
    time :updated_at
  end

  def price_discount
    price - discount
  end

  def price
    unit_price * quantity_per_unit
  end

  protected

  def delete_photo
    photo.clear
  end

  def self.search_product(search_expression, category, options = nil)
    Product.search do
      # ============= Searching and boosting

      fulltext search_expression do
        # if the search terms are close related in the product name
        phrase_fields product_name: 2.0
        # if the search terms are present, but not necessarily very related
        boost_fields product_name: 1.5
        # boost(5.0) do
        #   with(:discount_available, true)
        # end if options[:with_discount].present?
      end
      with :product_available, true

      # ============= Filtering

      apply_filters.call(self, category, options)

      # ============= Sorting

      sort_search.call(self, options)

      # ============= Paginating
      paginate page: options[:page], per_page: 5
    end
  end

  def self.sort_search
    lambda do |context, options|
      context.order_by(:discount, :desc) if options[:with_discount].present?
      context.order_by(:updated_at, :asc)
    end
  end

  def self.apply_filters
    lambda do |context, category, options|
      apply_price_filters.call(context, options)

      apply_product_filters.call(context, options)

      apply_category_filters.call(context, category)
    end
  end

  def self.apply_price_filters
    lambda do |context, options|
      options[:minimum_price].present? && context.with(:price)\
        .greater_than_or_equal_to(options[:minimum_price].to_i)
      options[:maximum_price].present? && context.with(:price)\
        .less_than_or_equal_to(options[:maximum_price].to_i)
    end
  end

  def self.apply_category_filters
    lambda do |context, category|
      # ============= Filtering category
      # It is important to also consider all the descendant categories from
      # the current one. This is why we must fill the second parameter of
      # 'with' with the children ids as well the own category id (!)
      category && context.with(:category_id, category.child_ids << category.id)
    end
  end

  def self.apply_product_filters
    lambda do |context, options|
      options[:offers_only].present? && context.with(:discount_available, true)
      options[:new_products].present? && context\
        .with(:created_at).greater_than_or_equal_to(Time.now - 1.day)
    end
  end
end
