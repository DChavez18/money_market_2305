require "rails_helper"

RSpec.describe AtmService do
  describe "#nearby_atms" do
    xit "returns nearby atms" do
      VCR.use_cassette("nearby_atms") do
        search = AtmService.new.nearby_atms(35.077529, -106.600449)

        expect(search).to be_a(Hash)
        expect(search[:results]).to be_an Array
        expect(search[:results].count).to eq(10)
      end
    end
  end
end