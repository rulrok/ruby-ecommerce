class Product < ActiveRecord::Base



  belongs_to :category

  attr_accessor :image_delete

  has_attached_file :photo, :styles => {:small => "150x150>"},
                    :url => "/assets/products/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension",
                    :default_url => "/images/no_picture.png"

 # has_destroyable_file :photo

  #validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  validates_presence_of :category

  before_save { delete_photo if image_delete == '1' }

  private

  def delete_photo
    self.photo.clear
  end


end
