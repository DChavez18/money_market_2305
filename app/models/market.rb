class Market < ApplicationRecord
  has_many :market_vendors
  has_many :vendors, through: :market_vendors

  def vendor_count
    vendors.count
  end

  def self.search_all(params)
    results = all
    params.each do |key, value|
      results = results.public_send("search_by_#{key}", value) if value.present?
    end
    results
  end

  def self.search_by_state(state)
    where('state ILIKE ?', "%#{state}%")
  end

  def self.search_by_name(name)
    where('name ILIKE ?', "%#{name}%")
  end

  def self.search_by_city(city)
    where('city ILIKE ?', "%#{city}%")
  end

  def self.search_by_criteria(state, city, name)
    markets = all

    markets = markets.search_by_name(name) if name.present?
    markets = markets.search_by_city(city) if city.present?
    markets = markets.search_by_state(state) if state.present?

    markets
  end
end
