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
      render json: { errors: "Vendor not found" }, status: :not_found
    end
  end

  def create
    vendor = Vendor.new(vendor_params)

    if vendor.save
      render json: VendorSerializer.new(vendor), status: :created
    else
      render json: { errors: vendor.errors.full_messages.join(', ') }, status: :bad_request
    end
  end

  def update
    vendor = Vendor.find(params[:id])

    if vendor.update(vendor_params)
      render json: VendorSerializer.new(vendor), status: :ok
    else
      render json: { errors: vendor.errors.full_messages.join(', ') }, status: :bad_request
    end
  end

  def destroy
    begin
      vendor = Vendor.find(params[:id])
      vendor.market_vendors.destroy_all
  
      if vendor.destroy
        render json: { message: "Vendor deleted successfully" }, status: 204
      else
        render json: { errors: vendor.errors.full_messages.join(', ') }, status: :bad_request
      end
    rescue ActiveRecord::RecordNotFound
      render json: { errors: "Vendor not found" }, status: :not_found
    end
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end