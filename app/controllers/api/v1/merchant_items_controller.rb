class Api::V1::MerchantItemsController < ApplicationController

  def index
    if Item.exists?(merchant_id: params[:merchant_id])
      render json: ItemSerializer.new(Item.where(merchant_id: params[:merchant_id]))
    else
      render json: { errors: {message: "No items were found for merchant with id: #{params[:merchant_id]}"}},
             status: 404
    end
  end
end
