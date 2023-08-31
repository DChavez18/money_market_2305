require "rails_helper"

RSpec.describe "Markets API" do
  describe "use api to get atms near market location" do
    xit "returns the nearest atms" do
      VCR.use_cassette('nearby_atms') do
        market = create(:market, lat: '35.077529', lon: '-106.600449')

        get "/api/v0/markets/#{market.id}/nearest_atms"

        expect(response).to be_successful
        expect(response.status).to eq(200)

        atm_response_data = JSON.parse(response.body)

        expect(atm_response_data).to have_key["data"]
      end
    end
  end
end