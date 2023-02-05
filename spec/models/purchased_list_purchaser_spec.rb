require 'rails_helper'

# bundle exec rspec spec/models/purchased_list_purchaser_spec.rb

RSpec.describe PurchasedListPurchaser, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchased_list_purchaser = FactoryBot.build(:purchased_list_purchaser, user_id: user.id, item_id: item.id)
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
        expect(@purchased_list_purchaser.errors.full_messages).to include ("User can't be blank")
      end
      it 'item_idが紐づいていないと保存できない' do
        @purchased_list_purchaser.item_id = nil
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include ("Item can't be blank")
      end
      it '郵便番号が空だと保存できない' do
        @purchased_list_purchaser.postal_code = ""
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include ("Postal code can't be blank")
      end
      it '郵便番号にハイフンがないと保存できない' do
        @purchased_list_purchaser.postal_code = 1112222
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include ("Postal code is invalid. Include hyphen(-)")
      end
      it '都道府県のidが１(---)だと保存できない' do
        @purchased_list_purchaser.prefecture_id = 1
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include ("Prefecture must be other than 1")
      end
      it '市区町村が空だと保存できない' do
        @purchased_list_purchaser.city = ""
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include ("City can't be blank")
      end
      it '番地が空だと保存できない' do
        @purchased_list_purchaser.street = ""
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include ("Street can't be blank")
      end
      it '電話番号が空だと保存できない' do
        @purchased_list_purchaser.phone_number = ""
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include ("Phone number can't be blank")
      end
      it '電話番号にハイフンがあると保存できない' do
        @purchased_list_purchaser.phone_number = '111 - 2222 - 3333'
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include ("Phone number is invalid")
      end
      it '電話番号が12桁以上あると保存できない' do
        @purchased_list_purchaser.phone_number = 111222333444
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include ("Phone number is invalid")
      end
      it '電話番号が9桁以下では保存できない' do
        @purchased_list_purchaser.phone_number = 111222333
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include ("Phone number is invalid")
      end
      it 'トークンが空だと保存できない' do
        @purchased_list_purchaser.token = ""
        @purchased_list_purchaser.valid?
        expect(@purchased_list_purchaser.errors.full_messages).to include ("Token can't be blank")
      end
    end
  end
end
