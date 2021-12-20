require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the LatLongFromAddressesHelper.

RSpec.describe LatLongFromAddressesHelper, type: :helper do
  let(:now) { DateTime.now }

  describe 'format_month_date' do
    it 'parses a DateTime timestamp into just the month and date components' do
      expect(helper.format_month_date(now.to_s)).to eq("#{now.month}/#{now.day}")
    end
  end
end
