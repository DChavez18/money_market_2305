require "rails_helper"

RSpec.describe "Markets API" do
  describe "getting all vendors for a specific market" do
    it "returns all vendors fror a market if a valid id is passed" do
      market_1 = create(:market)
      vendor_1 = create(:vendor)
      vendor_2 = create(:vendor)

      market_1.vendors << vendor_1
      market_1.vendors << vendor_2

      get "/api/v0/markets/#{market_1.id}/vendors"

      expect(response).to be_successful

      vendors_response = JSON.parse(response.body)

      expect(vendors_response).to have_key("data")

      vendors_response["data"].each do |vendor_data|
        attributes = vendor_data["attributes"]

        expect(attributes).to have_key("name")
        expect(attributes["name"]).to be_a(String)
        expect(attributes).to have_key("description")
        expect(attributes["description"]).to be_a(String)
        expect(attributes).to have_key("contact_name")
        expect(attributes["contact_name"]).to be_a(String)
        expect(attributes).to have_key("contact_phone")
        expect(attributes["contact_phone"]).to be_a(String)
        expect(attributes).to have_key("credit_accepted")
        expect(attributes["credit_accepted"]).to be(true).or be(false)
      end
    end
  end
end