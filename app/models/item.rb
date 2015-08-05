class Item < ActiveRecord::Base
  has_many :category_items
  has_many :categories, through: :category_items
  has_many :order_items
  validates :title, presence: true, length: { minimum: 3 }, uniqueness: true
  validates :description, presence: true, length: { minimum: 5 }
  validates :price, presence: true
  validates_presence_of :title, :description, :price
  mount_uploader :image, ItemImageUploader

  def self.items_in_menu
    Item.where(retired: false)
  end
end
