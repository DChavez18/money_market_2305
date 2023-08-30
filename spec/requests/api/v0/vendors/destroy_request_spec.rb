require "rails_helper"


RSpec.describe "Vendors API" do
  describe "destroying a vendor" do
    it "destroys a vendor and any associations when a valid id is passed" do
      market_1 = create(:market)
      vendor_1 = create(:vendor)

      market_vendor = create(:market_vendor, market: market_1, vendor: vendor_1)

      delete "/api/v0/vendors/#{vendor_1.id}"

      expect(response).to be_successful
      expect(response).to have_http_status(204)
      expect(market_1.vendor_count).to eq(0)
      expect { MarketVendor.find(market_vendor.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "returns an error message and a 404 status code if the id is invalid" do
      invalid_id = 123456789

      delete "/api/v0/vendors/#{invalid_id}"

      expect(response).to_not be_successful
      expect(response).to have_http_status(404)
      error_response = JSON.parse(response.body)
      expect(error_response).to have_key("errors")
      expect(error_response["errors"]).to eq("Vendor not found")
    end
  end
end