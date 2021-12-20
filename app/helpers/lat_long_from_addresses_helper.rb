module LatLongFromAddressesHelper
  def format_time(time_str)
    ts = DateTime.parse(time_str)
    ts.strftime("")
  end

  def format_month_date(time_str)
    ts = DateTime.parse(time_str)
    ts.strftime('%m/%d')
  end
end
