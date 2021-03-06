class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id]
     render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).items)
   else
     render json: ItemSerializer.new(Item.all)
   end
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def update
    render json: ItemSerializer.new(Item.update(params[:id], item_params))
  end

  def create
    render json: ItemSerializer.new(Item.create(item_params))
  end

  def destroy
    destroyed_item = Item.find(params[:id])
    Item.delete(params[:id])
    render json: ItemSerializer.new(destroyed_item)
  end
  private

  def item_params
      params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
