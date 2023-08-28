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

    markets = JSON.parse(response.body)

    markets.each do |market|
      expect(market).to have_key("id")
      expect(market["id"]).to be_a(Integer)
      expect(market).to have_key("name")
      expect(market["name"]).to be_a(String)
      expect(market).to have_key("street")
      expect(market["street"]).to be_a(String)
      expect(market).to have_key("city")
      expect(market["city"]).to be_a(String)
      expect(market).to have_key("county")
      expect(market["county"]).to be_a(String)
      expect(market).to have_key("state")
      expect(market["state"]).to be_a(String)
      expect(market).to have_key("zip")
      expect(market["zip"]).to be_a(String)
      expect(market).to have_key("lat")
      expect(market["lat"]).to be_a(String)
      expect(market).to have_key("lon")
      expect(market["lon"]).to be_a(String)
      expect(market).to have_key("vendor_count")
      expect(market["vendor_count"]).to be_a(Integer)
      expect(markets[0]["vendor_count"]).to eq(3)
    end
  end
end