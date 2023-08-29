require "rails_helper"

RSpec.describe "Vendors API" do
  describe "Updates a Vendor" do
    it "updates and existing vendor with any parameters sent in via the body" do
      vendor_1 = create(:vendor)

      params = {
        "contact_name": "Kimberly Couwer",
        "credit_accepted": false
      }

      headers = { 'CONTENT_TYPE' => 'application/json'}

      patch "/api/v0/vendors/#{vendor_1.id}", headers: headers, params: JSON.generate(vendor: params)
      updated_vendor = Vendor.last

      expect(response).to be_successful
      expect(response).to have_http_status(200)
      expect(updated_vendor.contact_name).to eq("Kimberly Couwer")
      expect(updated_vendor.credit_accepted).to eq(false)
    end

    it "won't update a vendor with any nil or empty attributes and it will return a 400 status code and a error message" do
      vendor_1 = create(:vendor)

      params = {
        "contact_name": "",
        "credit_accepted": false
      }

      headers = { 'CONTENT_TYPE' => 'application/json'}

      patch "/api/v0/vendors/#{vendor_1.id}", headers: headers, params: JSON.generate(vendor: params)

      expect(response).to_not be_successful
      expect(response).to have_http_status(400)
      expect(response.body).to include("Contact name can't be blank")
    end
  end
end