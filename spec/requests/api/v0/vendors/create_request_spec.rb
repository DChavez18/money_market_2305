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

      headers = { 'CONTENT_TYPE'=> 'application/json' }

      post "/api/v0/vendors", headers: headers, params: JSON.generate(vendor: vendor_params)
      new_vendor = Vendor.last

      expect(response).to be_successful
      expect(response).to have_http_status(201)
      expect(new_vendor.name).to eq("Buzzy Bees")
      expect(new_vendor.description).to eq("local honey and wax products")
      expect(new_vendor.contact_name).to eq("Berly Couwer")
      expect(new_vendor.contact_phone).to eq("8389928383")
      expect(new_vendor.credit_accepted).to eq(false)
    end

    it "returns a 400 status code and an error message if any of the attributes are missing" do
      vendor_params = {
        'description': 'local honey and wax products',
        'contact_name': 'Berly Couwer',
        'contact_phone': '8389928383',
        'credit_accepted': false
      }

      headers = { 'CONTENT_TYPE'=> 'application/json' }

      post "/api/v0/vendors", headers: headers, params: JSON.generate(vendor: vendor_params)

      expect(response).to_not be_successful
      expect(response).to have_http_status(400)
      error_response = JSON.parse(response.body)
      expect(error_response).to have_key('error')
      expect(error_response['error']).to eq("Name can't be blank")
    end
  end
end