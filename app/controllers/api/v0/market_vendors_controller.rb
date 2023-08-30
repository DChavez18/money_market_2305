class Api::V0::MarketVendorsController < ApplicationController
  def create
    if market_vendor_params[:market_id].nil? || market_vendor_params[:vendor_id].nil?
      render json: { errors: "Both market ID and vendor ID are required" }, status: :bad_request
      return
    end

    existing_association = MarketVendor.find_by(market_id: market_vendor_params[:market_id], vendor_id: market_vendor_params[:vendor_id])
    if existing_association
      render json: { errors: "Association already exists" }, status: :unprocessable_entity
      return
    end

    market = Market.find_by(id: market_vendor_params[:market_id])
    vendor = Vendor.find_by(id: market_vendor_params[:vendor_id])

    if market.nil?
      render json: { errors: "Market not found" }, status: :not_found
    elsif vendor.nil?
      render json: { errors: "Vendor not found" }, status: :not_found
    else
      market_vendor = MarketVendor.create!(market_vendor_params)
      render json: MarketVendorSerializer.new(market_vendor), status: :created
    end
  rescue ActiveRecord::RecordInvalid => error
    render json: { errors: error.record.errors.full_messages.join(', ') }, status: :bad_request
  end

  private

  def market_vendor_params
    params.require(:market_vendor).permit(:market_id, :vendor_id)
  end
end