class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all)
    # render json: ItemSerializer.format_items(Item.all)
  end

  def show
    if Item.exists?(params[:id])
      render json: ItemSerializer.new(Item.find(params[:id]))
    else
      render json: { data: { message: 'No item matches this id'} },
             status: 404
    end
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(Item.create(item_params)),
            status: 201
    else
      render status: 404
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.destroy
      render status: 204
    end 
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: ItemSerializer.new(item)
    else
      render status: 404
    end
  end

  private

    def item_params
      params.permit(:name, :description, :unit_price, :merchant_id)
    end
end
