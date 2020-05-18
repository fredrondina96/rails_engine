class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(merchant)
  end

  def update
    render json: MerchantSerializer.new(Merchant.update(params[:id], merchant_params))
  end

  def create
    render json: MerchantSerializer.new(Merchant.create(merchant_params))
  end

  def destroy
    destroyed_merchant = Merchant.find(params[:id])
    Merchant.delete(params[:id])
    render json: MerchantSerializer.new(destroyed_merchant)
  end

  private

  def merchant_params
   params.require("merchant").permit("name")
  end
end
