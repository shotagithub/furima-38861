require 'rails_helper'

# bundle exec rspec spec/models/purchased_list_purchaser_spec.rb

RSpec.describe PurchasedListPurchaser, type: :model do
  before do
    @purchased_list_purchaser = FactoryBot.build(:purchased_list_purchaser)
  end

  describe '配送先の保存' do
    context '配送先の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@purchased_list_purchaser).to be_valid
      end
      it '建物名が空でも保存できる' do
        @purchased_list_purchaser.building = nil
        expect(@purchased_list_purchaser).to be_valid
      end
    end

    context '配送先の保存ができないとき' do
      it 'user_idが紐づいていないと保存できない' do
        @purchased_list_purchaser.user_id = nil
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが紐づいていないと保存できない' do
        @purchased_list_purchaser.item_id = nil
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include("Item can't be blank")
      end
      it '郵便番号が空だと保存できない' do
        @purchased_list_purchaser.postal_code = nil
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include("Postal code can't be blank",
                                                                          'Postal code is invalid. Include hyphen(-)')
      end
      it '郵便番号にハイフンがないと保存できない' do
        @purchased_list_purchaser.postal_code = 1_234_567
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it '都道府県のidが１(---)だと保存できない' do
        @purchased_list_purchaser.prefecture_id = 1
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it '市区町村が空だと保存できない' do
        @purchased_list_purchaser.city = nil
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できない' do
        @purchased_list_purchaser.street = nil
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include("Street can't be blank")
      end
      it '電話番号が空だと保存できない' do
        @purchased_list_purchaser.phone_number = nil
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にハイフンがあると保存できない' do
        @purchased_list_purchaser.phone_number = '123 - 1234 - 1234'
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上あると保存できない' do
        @purchased_list_purchaser.phone_number = 111_111_111_111
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include('Phone number is invalid')
      end
      it 'トークンが空だと保存できない' do
        @purchased_list_purchaser.token = nil
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
