require "rails_helper"

describe "Markets API" do
  it "returns a single market with its attrubutes including vendor_count" do
    market_1 = create(:market)
    vendor_1 = create(:vendor)
    vendor_2 = create(:vendor)

    market_1.vendors << vendor_1
    market_1.vendors << vendor_2

    get "/api/v0/markets/#{market_1.id}"
    
    expect(response).to be_successful
    
    market_data = JSON.parse(response.body)
    
    market_attributes = market_data["data"]["attributes"]
    
    expect(market_attributes).to have_key("id")
    expect(market_attributes["id"]).to be_a(Integer)
    expect(market_attributes).to have_key("name")
    expect(market_attributes["name"]).to be_a(String)
    expect(market_attributes).to have_key("street")
    expect(market_attributes["street"]).to be_a(String)
    expect(market_attributes).to have_key("city")
    expect(market_attributes["city"]).to be_a(String)
    expect(market_attributes).to have_key("county")
    expect(market_attributes["county"]).to be_a(String)
    expect(market_attributes).to have_key("state")
    expect(market_attributes["state"]).to be_a(String)
    expect(market_attributes).to have_key("zip")
    expect(market_attributes["zip"]).to be_a(String)
    expect(market_attributes).to have_key("lat")
    expect(market_attributes["lat"]).to be_a(String)
    expect(market_attributes).to have_key("lon")
    expect(market_attributes["lon"]).to be_a(String)
    expect(market_1.vendor_count).to eq(2)
  end
  
  it "returns a descriptive 404 error if an invalid market id is passed" do
    invalid_id = 1001
    
    get "/api/v0/markets/#{invalid_id}"

    expect(response).to_not be_successful
    expect(response).to have_http_status(404)
    error_data = JSON.parse(response.body)
    expect(error_data).to have_key("errors")
    expect(error_data["errors"]).to be_an(Array)
    expect(error_data["errors"][0]["detail"]).to eq("Couldn't find Market with 'id'=#{invalid_id}")
  end
end