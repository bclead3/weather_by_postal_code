# frozen_string_literal: true

module LatLongFromAddressesHelper
  TIME_ZONE_HASH = ActiveSupport::TimeZone::MAPPING
  TIME_FORMAT = '%b %-d %-I:%M:%S %P'
  DATE_FORMAT = '%Y  %b %-d'
  def format_time(time_str, station_time_zone = nil)
    if station_time_zone.present?
      new_time_zone = convert_from_station_to_rails_tz(station_time_zone)
      Time.zone = new_time_zone
      Time.zone.parse(time_str).strftime(TIME_FORMAT)
    else
      time_stamp = DateTime.parse(time_str)
      time_stamp.strftime(TIME_FORMAT)
    end
  end

  def format_month_date(time_str)
    ts = DateTime.parse(time_str)
    ts.strftime(DATE_FORMAT)
  end

  # private
  def format_time_zone(str_time_zone)
    return '' if str_time_zone.blank?

    arr = str_time_zone.split('/')
    city = arr.pop
    country = arr.join('/')
    "#{format_other(country)}/#{format_city(city)}"
  end

  def format_city(str_city)
    str_city.split('/')&.last&.split(' ')&.map(&:capitalize)&.join('_')
  end

  # "America/Argentina/Buenos_Aires"
  def format_other(str_time_zone)
    return '' if str_time_zone.blank?

    arr_country = str_time_zone.split('/')
    arr_country&.map(&:capitalize)&.join('/')
  end

  def convert_from_station_to_rails_tz(station_time_zone)
    rails_time_zone_value = format_time_zone(station_time_zone)
    hashlet = TIME_ZONE_HASH.select { |_x, y| y == rails_time_zone_value }

    hashlet.keys.first
  end
end
