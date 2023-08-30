require "rails_helper"

RSpec.describe "MarketVendors API" do
  describe "creating a market vendor" do
    it "creates a new association between a market and a vendor when valid market ids and vendor ids are passed in" do
      market_1 = create(:market)
      vendor_1 = create(:vendor)
      market_vendor_params = { market_id: market_1.id,
                               vendor_id: vendor_1.id }

      headers = { "CONTENT_TYPE": "application/json" }

      post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

      expect(response).to be_successful
    end
  end
end