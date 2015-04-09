class Product < ActiveRecord::Base
  belongs_to :category

  attr_accessor :image_delete

  # In case that a new style has to be added, look that page: https://github.com/thoughtbot/paperclip/wiki/Thumbnail-Generation
  has_attached_file :photo, styles: {mini: '80x80>', small: '150x150>'},
                    url: '/assets/products/:id/:style/:basename.:extension',
                    path: ':rails_root/public/assets/products/:id/:style/:basename.:extension',
                    default_url: '/images/no_picture.png'

  # has_destroyable_file :photo

  has_many :order_items

  # default_scope { where(active: true) }

  # validates_attachment_presence :photo
  validates_attachment_size :photo, less_than: 5.megabytes
  validates_attachment_content_type :photo, content_type: ['image/jpeg', 'image/png']

  # Validations
  validates_presence_of :product_name, :short_description, :category, :unit_price, :quantity_per_unit, :unit_weight
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

  private

  def delete_photo
    photo.clear
  end
end
