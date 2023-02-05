class PurchasedListPurchaser
  include ActiveModel::Model
  attr_accessor :postal_code, :city, :street, :building, :phone_number, :prefecture_id, :user_id, :item_id, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :city
    validates :street
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
    validates :token
  end
  validates :prefecture_id, numericality: { other_than: 1 }
  def save
    purchased_list = PurchasedList.create(item_id: item_id, user_id: user_id)
    Purchaser.create(postal_code: postal_code, city: city, street: street, building: building, phone_number: phone_number,
                     prefecture_id: prefecture_id, purchased_list_id: purchased_list.id)
  end
end
