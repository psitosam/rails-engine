class Api::V1::MerchantItemsController < ApplicationController

  def index
    if Item.exists?(merchant_id: params[:merchant_id])
      render json: ItemSerializer.new(Item.where(merchant_id: params[:merchant_id]))
    else
      render json: { error: {message: "No items were found for merchant with id: #{params[:merchant_id]}"}},
             status: 404
    end
  end

  def show
    if Item.exists?(params[:item_id])
      render json: MerchantSerializer.new(Merchant.find(get_merchant))
    else
      render json: { errors: {message: "No item was found with id: #{params[:item_id]}"}},
             status: 404
    end
  end

  private
    def get_merchant
      Item.find(params[:item_id])[:merchant_id]
    end
end
