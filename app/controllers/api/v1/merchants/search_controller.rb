class Api::V1::Merchants::SearchController < ApplicationController

  def show
    @merchants = filter
    render json: MerchantSerializer.new(@merchants.first)
  end

  def index
    @merchants = filter
    render json: MerchantSerializer.new(@merchants)
  end

  private

  def filter
    @merchants = Merchant.all
    @merchants = @merchants.filter_by_name(params[:name]) if params[:name].present?
    @merchants
  end
end
