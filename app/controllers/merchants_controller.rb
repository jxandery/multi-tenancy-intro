class MerchantsController < ApplicationController

  def show
    @merchant = Merchant.find_by(id: params[:id])
  end
end
