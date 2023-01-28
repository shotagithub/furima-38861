require 'rails_helper'
# bundle exec rspec spec/models/item_spec.rb
RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品の出品' do
    context '出品できる場合' do
      it 'imege、item_name、item_description、category、condition、shipping_method、shipping_time、prifecture、priceが存在すれば出品できる' do
        expect(@item).to be_valid
      end
    end
    context '出品できない場合' do
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'item_nameが空では出品できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it 'item_descriptionが空では出品できない' do
        @item.item_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item description can't be blank")
      end
      it 'categoryのidが1であるときは出品できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end
      it 'conditionのidが1であるときは出品できない' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition must be other than 1')
      end
      it 'shipping_methodのidが1であるときは出品できない' do
        @item.shipping_method_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping method must be other than 1')
      end
      it 'prefectureのidが1であるときは出品できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it 'shipping_timeのidが1であるときは出品できない' do
        @item.shipping_time_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping time must be other than 1')
      end
      it 'priceが空であるときは出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが300未満であるときは出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it 'priceが999999より上であるときは出品できない' do
        @item.price = 1_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 999999')
      end
      it 'priceが全角数字であるときは出品できない' do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'ユーザーが紐づいていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
