class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if Merchant.exists?(params[:id])
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    else
      render json: { data: { message: 'No merchant matches this id'} },
             status: 404
    end
  end
end
