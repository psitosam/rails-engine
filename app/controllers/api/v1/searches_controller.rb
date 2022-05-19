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
    if merchants.empty?
      render json: { data: [] }, status: 404
    else
      render json: MerchantSerializer.new(merchants)
    end
  end

  def find_all_items
    if params[:name]
      items = Item.search_all(params[:name])
      # items = Item.where("name ILIKE ?", "%#{params[:name]}%") #this one works, but is vulnerable, so I made a method in the Item model in order to not have user input directly conveyed to the database through possible SQL injection, similar to the search_all method in the Merchant model.
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
