class Api::V0::MarketVendorsController < ApplicationController
  def create
    vendor = Vendor.find_by(id: market_vendor_params[:vendor_id])

    if vendor.nil?
      render json: { errors: "Vendor not found" }, status: :not_found
    else
      market_vendor = MarketVendor.create!(market_vendor_params)
      render json: MarketVendorSerializer.new(market_vendor), status: 201
    end
  rescue ActiveRecord::RecordInvalid => error
    render json: { errors: error.record.errors.full_messages.join(', ') }, status: :bad_request
  end

  private

  def market_vendor_params
    params.require(:market_vendor).permit(:market_id, :vendor_id)
  end
end