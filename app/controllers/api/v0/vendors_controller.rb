class Api::V0::VendorsController < ApplicationController
  def index
    market = Market.find_by(id: params[:market_id])

    if market.nil?
      render json: { errors: "Market not found" }, status: :not_found
    else
      render json: VendorSerializer.new(market.vendors)
    end
  end

  def show
    render json: VendorSerializer.new(Vendor.find(params[:id]))
  end
end