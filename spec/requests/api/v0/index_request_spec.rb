require "rails_helper"

describe "Markets API" do
  it "returns all markets in the database with vendor count" do
    create_list(:market, 5)

    get '/api/v0/markets'

    expect(response).to be_successful
  end
end