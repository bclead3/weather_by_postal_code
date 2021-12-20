# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the LatLongFromAddressesHelper.

RSpec.describe LatLongFromAddressesHelper, type: :helper do
  let(:now) { DateTime.now }

  describe 'format_time' do
    it 'formats the time w/o time zone' do
      expect(helper.format_time('2021-12-20T18:00:00+00:00')).to eq('Dec 20 6:00:00 pm')
    end

    it 'formats the time with time zone' do
      expect(helper.format_time('2021-12-20T18:00:00+00:00',
                                convert_from_station_to_rails_tz('america/chicago'))).to eq('Dec 20 6:00:00 pm')
    end

    it 'format_city for retrieving appropriate time zone' do
      expect(helper.format_city('america/chicago')).to eq('Chicago')
      expect(helper.format_city('america/los angeles')).to eq('Los_Angeles')
      expect(helper.format_city('america/new york')).to eq('New_York')
      expect(helper.format_city('america/denver')).to eq('Denver')
    end
  end

  describe 'format_other' do
    it 'formats argentina' do
      expect(helper.format_other('america/argentina')).to eq('America/Argentina')
    end
  end

  describe 'format_time_zone' do
    it 'handles "america/argentina/buenos aires" to output "America/Argentina/Buenos_Aires"' do
      expect(helper.format_time_zone('america/argentina/buenos aires')).to eq('America/Argentina/Buenos_Aires')
      expect(helper.format_time_zone('america/new york')).to eq('America/New_York')
      expect(helper.format_time_zone('america/chicago')).to eq('America/Chicago')
      expect(helper.format_time_zone('america/denver')).to eq('America/Denver')
      expect(helper.format_time_zone('america/los angeles')).to eq('America/Los_Angeles')
    end
  end

  describe 'format_month_date' do
    it 'parses a DateTime timestamp into just the month and date components' do
      expect(helper.format_month_date(now.to_s)).to eq("#{now.year}  #{now.strftime('%b')} #{now.strftime('%-d')}")
    end
  end
end
