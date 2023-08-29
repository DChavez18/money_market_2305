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
    begin
      vendor = Vendor.find(params[:id])
      render json: VendorSerializer.new(vendor)
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Vendor not found" }, status: :not_found
    end
  end

  def create
    @vendor = Vendor.new(vendor_params)

    render json: VendorSerializer.new(@vendor)
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end