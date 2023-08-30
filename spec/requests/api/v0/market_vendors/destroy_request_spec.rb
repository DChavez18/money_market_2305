require "rails_helper"

RSpec.describe "MarketVendors API" do
  describe "destroying a MarketVendor" do
    it "destroys an existing association between a market and a vendor" do
      market_1 = create(:market)
      vendor_1 = create(:vendor)
      market_vendor_1 = create(:market_vendor, market: market_1, vendor: vendor_1)
      
      expect(market_vendor_1.market_id).to eq(market_1.id)
      expect(market_vendor_1.vendor_id).to eq(vendor_1.id)
      
      market_vendor_params = { market_id: market_1.id,
                               vendor_id: vendor_1.id }

      headers = { "CONTENT_TYPE": "application/json" }

      delete "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor_params)

      expect(response).to be_successful
      expect(response).to have_http_status(204)
      expect(response.body).to eq("")
      expect(MarketVendor.find_by(market_id: market_1.id, vendor_id: vendor_1.id)).to be_nil
    end

    it "removes the market associated with the vendor from the vendor's market index page" do
      market_1 = create(:market)
      vendor_1 = create(:vendor)
      market_vendor_1 = create(:market_vendor, market: market_1, vendor: vendor_1)
      
      expect(market_vendor_1.market_id).to eq(market_1.id)
      expect(market_vendor_1.vendor_id).to eq(vendor_1.id)
      
      market_vendor_params = { market_id: market_1.id,
                               vendor_id: vendor_1.id }

      headers = { "CONTENT_TYPE": "application/json" }

      delete "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor_params)

      get "/api/v0/vendors/#{vendor_1.id}/markets"

      expect(response).to be_successful
      expect(vendor_1.markets).to eq([])
    end

    
  end
end