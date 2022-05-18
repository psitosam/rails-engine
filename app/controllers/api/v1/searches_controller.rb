class Api::V1::SearchesController < ApplicationController

  def find #should this be find merchant
    merchant = Merchant.where("name ILIKE ?","%#{params[:name]}%").first
    if merchant.nil?
      render json: { data: { message: "No merchant found" } }
    else
      render  json: MerchantSerializer.new(merchant)
    end
  end

  def find_all_merchants
    merchants = Merchant.search_all(params[:name])
    # merchants = Merchant.where("name ILIKE ?","%#{params[:name]}%").order(:name)
    # require 'pry'; binding.pry
    if merchants.empty?
      render json: { data: [] }, status: 404
    else
      render json: MerchantSerializer.new(merchants)
    end
  end
end
