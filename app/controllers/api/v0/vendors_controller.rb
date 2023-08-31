class Api::V0::VendorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    market = Market.find_by(id: params[:market_id])
    return render_record_not_found if market.nil?

    render json: VendorSerializer.new(market.vendors)
  end

  def show
    vendor = Vendor.find(params[:id])
    render json: VendorSerializer.new(vendor)
  end

  def create
    vendor = Vendor.new(vendor_params)
    if vendor.save
      render json: VendorSerializer.new(vendor), status: :created
    else
      render json: ErrorSerializer.serialize(vendor.errors.full_messages), status: :bad_request
    end
  end

  def update
    vendor = Vendor.find(params[:id])
    if vendor.update(vendor_params)
      render json: VendorSerializer.new(vendor)
    else
      render json: ErrorSerializer.serialize(vendor.errors.full_messages), status: :bad_request
    end
  end

  def destroy
    vendor = Vendor.find(params[:id])
    vendor.market_vendors.destroy_all
    if vendor.destroy
      head :no_content
    else
      render json: ErrorSerializer.serialize(vendor.errors.full_messages), status: :bad_request
    end
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end

  def record_not_found
    render json: ErrorSerializer.serialize("Vendor not found"), status: :not_found
  end

  def render_record_not_found
    render json: { errors: "Market not found" }, status: :not_found
  end
end