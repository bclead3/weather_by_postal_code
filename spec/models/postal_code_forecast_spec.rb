require 'rails_helper'

RSpec.describe PostalCodeForecast, type: :model do

  describe '#is_below_cache_expiration should be false after 45 minutes' do
    ts = DateTime.now - 45.minutes
    let(:postal_code_forecast) { PostalCodeForecast.create(postal_code: '02134', time_of_last_request: ts) }

    it '#is_below_cache_expiration' do
      expect(postal_code_forecast.is_below_cache_expiration).to be_falsey
    end
  end

  describe '#is_below_cache_expiration should be true under 30 minutes' do
    ts = DateTime.now - 28.minutes
    let(:postal_code_forecast) { PostalCodeForecast.create(postal_code: '02134', time_of_last_request: ts) }

    it '#is_below_cache_expiration' do
      expect(postal_code_forecast.is_below_cache_expiration).to be_truthy
    end
  end
end
