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
      expect(response).to have_http_status(201)

      attributes = JSON.parse(response.body)["data"]["attributes"]

      expect(attributes["market_id"]).to eq(market_1.id)
      expect(attributes["vendor_id"]).to eq(vendor_1.id)
    end

    it "returns a 404 status code and an error message if an invalid vendor id is passed in" do
      market_1 = create(:market)
      vendor_1 = create(:vendor)
      invalid_id = 923846039
      market_vendor_params = { market_id: market_1.id,
                               vendor_id: invalid_id }

      headers = { "CONTENT_TYPE": "application/json" }

      post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)
      
      expect(response).to_not be_successful
      expect(response).to have_http_status(404)
      error_response = JSON.parse(response.body)
      expect(error_response["errors"]).to eq("Vendor not found")
    end
    
    it "returns a 404 status code and an error message if an invalid market id is passed" do
      market_1 = create(:market)
      vendor_1 = create(:vendor)
      invalid_id = 923846039
      market_vendor_params = { market_id: invalid_id,
                               vendor_id: vendor_1.id }
      
      headers = { "CONTENT_TYPE": "application/json" }
      
      post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)
      
      expect(response).to_not be_successful
      expect(response).to have_http_status(404)
      error_response = JSON.parse(response.body)
      expect(error_response["errors"]).to eq("Market not found")
    end
    
    it "returns a 400 status code and an error message if both market/vendor id are missing" do
      market_1 = create(:market)
      vendor_1 = create(:vendor)
      market_vendor_params = { market_id: nil,
      vendor_id: nil }
      
      headers = { "CONTENT_TYPE": "application/json" }                       
      
      post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)
      
      expect(response).to_not be_successful
      expect(response).to have_http_status(400)
      error_response = JSON.parse(response.body)
      expect(error_response["errors"]).to eq("Both market ID and vendor ID are required")
    end
    
    it "returns a 422 status code and an error message if the association between market and vendor already exists" do
      market_1 = create(:market)
      vendor_1 = create(:vendor)
      create(:market_vendor, market: market_1, vendor: vendor_1)
      market_vendor_params = { market_id: market_1.id, 
      vendor_id: vendor_1.id }
      
      headers = { "CONTENT_TYPE": "application/json" }
      
      post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

      expect(response).to_not be_successful
      expect(response).to have_http_status(422)
      error_response = JSON.parse(response.body)
      expect(error_response["errors"]).to eq("Association already exists")
    end
  end
end