require "rails_helper"


RSpec.describe "Vendors API" do
  describe "destroying a vendor" do
    it "detstroys a vendor and any associations when a valid id is passed" do
      market_1 = create(:market)
      vendor_1 = create(:vendor)

      market_vendor = create(:market_vendor, market: market_1, vendor: vendor_1)

      delete "/api/v0/vendors/#{vendor_1.id}"

      expect(response).to be_successful
    end
  end
end