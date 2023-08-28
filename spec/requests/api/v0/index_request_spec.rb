require "rails_helper"

describe "Markets API" do
  it "returns all markets in the database with vendor count" do
    create_list(:market, 5)

    get '/api/v0/markets'

    expect(response).to be_successful

    markets = JSON.parse(response.body)
require 'pry'; binding.pry
    markets.each do |market|
      expect(market).to have_key("id")
      expect(market["id"]).to be_an(Integer)

    end
  end
end