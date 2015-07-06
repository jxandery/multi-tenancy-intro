class ItemsController < ApplicationController
  before_action :load_item, only: [:show]
  before_action :check_merchant_url, only: [:show]

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id].to_i)
  end

  private

  def load_item
    @item = Item.find(params[:id].to_i)
  end

  def check_merchant_url
    if @item.merchant_id && params[:merchant_id].to_i != @item.merchant_id
      redirect_to merchant_item_path(@item.merchant, @item)
    end
  end
end
