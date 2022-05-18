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
    merchants = Merchant.where("name ILIKE ?","%#{params[:name]}%").order(:name)
    if merchants.nil?
      render json: { data: { message: "No merchants found" } }
    else
      render json: MerchantSerializer.new(merchants)
    end
  end
end
