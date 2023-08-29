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

      patch "/api/v0/vendors/#{vendor_1.id}"
      updated_vendor = Vendor.last

      expect(response).to be_successful
      
    end
  end
end