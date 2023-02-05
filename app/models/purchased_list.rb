class PurchasedList < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one    :purchaser
end
