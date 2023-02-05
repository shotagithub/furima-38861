class PurchasedListsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :item_find, only: [:index, :create]

  def index
    redirect_to root_path if user_signed_in? && current_user.id == @item.user.id || !@item.purchased_list.nil?
    @purchased_list_purchaser = PurchasedListPurchaser.new
  end

  def create
    @purchased_list_purchaser = PurchasedListPurchaser.new(purchased_list_purchaser_params)
    if @purchased_list_purchaser.valid?
      pay_item
      @purchased_list_purchaser.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchased_list_purchaser_params
    params.require(:purchased_list_purchaser).permit(:postal_code, :prefecture_id, :city, :street, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchased_list_purchaser_params[:token],
      currency: 'jpy'
    )
  end

  def item_find
    @item = Item.find(params[:item_id])
  end
end
