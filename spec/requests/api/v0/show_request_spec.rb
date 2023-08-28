require "rails_helper"

describe "Markets API" do
  it "returns a single market with its attrubutes including vendor_count" do
    market_1 = create(:market)
    vendor_1 = create(:vendor)

    get "/api/v0/markets/#{market_1.id}"

    expect(response).to be_successful
  end
end