class Item < ApplicationRecord
  belongs_to :user
  has_many   :comments
  has_one    :purchased_list
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_method
  belongs_to :shipping_time

  # validation
  validates :item_name, presence: true, length: {maximum: 40 }
  validates :item_description, :image,  presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 999999 }
  validates :prefecture_id, :category_id, :condition_id, :shipping_method_id, :shipping_time_id, numericality: { other_than: 1 } 
end
