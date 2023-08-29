require "rails_helper"

RSpec.describe "Vendors API" do
  describe "creating a vendor" do
    it "creates a vendor and passes all vendor attributes with a 201 status code" do
      vendor_params = {
        'name': 'Buzzy Bees',
        'description': 'local honey and wax products',
        'contact_name': 'Berly Couwer',
        'contact_phone': '8389928383',
        'credit_accepted': false
      }

      headers = { "CONTENT_TYPE": "application/json "}

      post "/api/v0/vendors", headers: headers, params: JSON.generate(vendor: vendor_params)
      new_vendor = Vendor.last

      expect(response).to be_successful
      expect(response.status).to eq(201)
    end
  end
end