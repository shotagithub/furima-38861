class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new
  
  def index
    @item = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :item_description, :price, :prefecture_id, :category_id, :condition_id,
                                 :shipping_method_id, :shipping_time_id, :image).merge(user_id: current_user.id)
  end
end
