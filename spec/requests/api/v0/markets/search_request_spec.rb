require "rails_helper"

RSpec.describe "Markets API" do
  describe "Search Markets by State, City and/or name" do
    xit "returns markets with state search" do
      markets = create_list(:market, 5)

      headers = { "CONTENT_TYPE": "application/json" }
      params = { state: "Montana" }

      get "/api/v0/markets/search", headers: headers, params: params

      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
end