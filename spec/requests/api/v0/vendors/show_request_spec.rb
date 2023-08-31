require "rails_helper"

RSpec.describe "Vendors API" do
  describe "vendors show path" do
    it "returns a vendor with attributes if valid id is passed" do
      market_1 = create(:market)
      vendor_1 = create(:vendor)

      market_1.vendors << vendor_1

      get "/api/v0/vendors/#{vendor_1.id}"

      expect(response).to be_successful

      vendor_data = JSON.parse(response.body)

      expect(vendor_data).to have_key("data")

      attributes = vendor_data["data"]["attributes"]

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

    it "returns a 404 status as well as a descriptive error message if invalid vendor id is passed" do
      invalid_id = 123456789

      get "/api/v0/vendors/#{invalid_id}"

      expect(response).to have_http_status(404)
      error_response = JSON.parse(response.body)
      expect(error_response).to have_key("errors")
      expect(error_response["errors"]).to eq([{"detail"=>"Vendor not found"}])
    end
  end
end