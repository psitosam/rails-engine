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

  def find_all_items
    if params[:name]
      items = Item.where("name ILIKE ?", "%#{params[:name]}%") #this one works, but is vulnerable
    elsif params[:min_price]
      items = Item.where("unit_price > ?", params[:min_price])
    elsif params[:max_price]
      items = Item.where("unit_price < ?", params[:max_price])
    end

    if items.empty?
      render json: { data: [] }
    else
      render json: ItemSerializer.new(items)
    end
  end
end
