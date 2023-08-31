require "rails_helper"

RSpec.describe Market do
  describe "relationships" do
    it { should have_many(:market_vendors) }
    it { should have_many(:vendors).through(:market_vendors) }
  end

  describe "#vendor_count" do
    it "returns the count of associated vendors" do
      market = create(:market)
      vendors = create_list(:vendor, 3)
      market.vendors << vendors

      expect(market.vendor_count).to eq(3)
    end
  end

  describe ".search_all" do
    it "returns results filtered by the given parameters" do
      market1 = create(:market, name: "Market 1", city: "City 1", state: "CO")
      market2 = create(:market, name: "Market 2", city: "City 2", state: "CO")
      market3 = create(:market, name: "Market 3", city: "City 3", state: "CA")

      results = Market.search_all(state: "CO", city: "City 1")

      expect(results).to contain_exactly(market1)
    end
  end

  describe ".search_by_state" do
    it "returns markets filtered by state" do
      market1 = create(:market, state: "CO")
      market2 = create(:market, state: "CA")

      results = Market.search_by_state("CO")

      expect(results).to contain_exactly(market1)
    end
  end

  describe ".search_by_name" do
    it "returns markets filtered by name" do
      market1 = create(:market, name: "Market 1")
      market2 = create(:market, name: "Market 2")

      results = Market.search_by_name("Market 1")

      expect(results).to contain_exactly(market1)
    end
  end

  describe ".search_by_city" do
    it "returns markets filtered by city" do
      market1 = create(:market, city: "City 1")
      market2 = create(:market, city: "City 2")

      results = Market.search_by_city("City 1")

      expect(results).to contain_exactly(market1)
    end
  end

  describe ".search_by_criteria" do
    it "returns markets filtered by state, city, and name" do
      market1 = create(:market, name: "Market 1", city: "City 1", state: "CO")
      market2 = create(:market, name: "Market 2", city: "City 2", state: "CA")
      market3 = create(:market, name: "Market 3", city: "City 1", state: "CA")

      results = Market.search_by_criteria("CO", "City 1", "Market 1")

      expect(results).to contain_exactly(market1)
    end
  end
end