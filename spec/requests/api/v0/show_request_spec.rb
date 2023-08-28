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

    expect(market_data).to have_key("id")
    expect(market_data["id"]).to be_a(Integer)
    expect(market_data).to have_key("name")
    expect(market_data["name"]).to be_a(String)
    expect(market_data).to have_key("street")
    expect(market_data["street"]).to be_a(String)
    expect(market_data).to have_key("city")
    expect(market_data["city"]).to be_a(String)
    expect(market_data).to have_key("county")
    expect(market_data["county"]).to be_a(String)
    expect(market_data).to have_key("state")
    expect(market_data["state"]).to be_a(String)
    expect(market_data).to have_key("zip")
    expect(market_data["zip"]).to be_a(String)
    expect(market_data).to have_key("lat")
    expect(market_data["lat"]).to be_a(String)
    expect(market_data).to have_key("lon")
    expect(market_data["lon"]).to be_a(String)
    expect(market_1.vendor_count).to eq(2)
  end
end