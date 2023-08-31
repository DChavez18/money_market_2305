require "rails_helper"

RSpec.describe "Markets API" do
  describe "Search Markets by State, City and/or name" do
    it "returns markets with state search" do
      market_1 = create(:market, name: "Market 1", city: "City 4", state: "CO")
      market_2 = create(:market, name: "Market 2", city: "City 5", state: "CO")
      market_3 = create(:market, name: "Market 3", city: "City 6", state: "CA")

      headers = { 'CONTENT_TYPE' => 'application/json' }

      get '/api/v0/markets/search?state=co', headers: headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body)

      expect(data).to have_key("data")

      markets = data["data"]
      expect(markets).to be_an(Array)
      expect(markets.count).to eq(2)

      markets.each do |market|
        expect(market["id"]).to be_a(String)
        expect(market["type"]).to eq("market")
        expect(market["attributes"]).to be_a(Hash)

        attributes = market["attributes"]
        expect(attributes["street"]).to be_a(String)
        expect(attributes["county"]).to be_a(String)
        expect(attributes["zip"]).to be_a(String)
        expect(attributes["lat"]).to be_a(String)
        expect(attributes["lon"]).to be_a(String)
        expect(attributes["vendor_count"]).to be_an(Integer)
      end
    end
  end
end