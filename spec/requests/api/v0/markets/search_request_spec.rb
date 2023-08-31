require "rails_helper"

RSpec.describe "Markets API" do
  describe "Search Markets by State, City and/or name" do
    before do
      @market_1 = create(:market, name: "Market 1", city: "City 4", state: "CO")
      @market_2 = create(:market, name: "Market 2", city: "City 5", state: "CO")
      @market_3 = create(:market, name: "Market 3", city: "City 6", state: "CA")
    end

    it "returns markets with state search" do
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

    it "returns markets with state and city search" do
      headers = { 'CONTENT_TYPE' => 'application/json' }

      get '/api/v0/markets/search?state=co&city=city%204', headers: headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body)

      expect(data).to have_key("data")

      markets = data["data"]
      expect(markets).to be_an(Array)
      expect(markets.count).to eq(1)

      market = markets[0]
      expect(market["id"]).to eq(@market_1.id.to_s)
      expect(market["attributes"]["name"]).to eq(@market_1.name)
      expect(market["attributes"]["city"]).to eq(@market_1.city)
      expect(market["attributes"]["state"]).to eq(@market_1.state)
    end
  end

  
end