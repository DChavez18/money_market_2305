require "rails_helper"

describe "Markets API" do
  it "returns all markets in the database with vendor count" do
    markets = create_list(:market, 5)
    vendors = create_list(:vendor, 10)

    markets.each do |market|
      market.vendors << vendors.sample(rand(1..3))
    end

    get '/api/v0/markets'
    expect(response).to be_successful
    
    markets_response = JSON.parse(response.body)["data"]

    markets_response.each do |market_data|
      attributes = market_data["attributes"]

      expect(attributes).to have_key("id")
      expect(attributes["id"]).to be_a(Integer)
      expect(attributes).to have_key("name")
      expect(attributes["name"]).to be_a(String)
      expect(attributes).to have_key("street")
      expect(attributes["street"]).to be_a(String)
      expect(attributes).to have_key("city")
      expect(attributes["city"]).to be_a(String)
      expect(attributes).to have_key("county")
      expect(attributes["county"]).to be_a(String)
      expect(attributes).to have_key("state")
      expect(attributes["state"]).to be_a(String)
      expect(attributes).to have_key("zip")
      expect(attributes["zip"]).to be_a(String)
      expect(attributes).to have_key("lat")
      expect(attributes["lat"]).to be_a(String)
      expect(attributes).to have_key("lon")
      expect(attributes["lon"]).to be_a(String)
      expect(attributes).to have_key("vendor_count")
      expect(attributes["vendor_count"]).to be_an(Integer)
    end
  end
end