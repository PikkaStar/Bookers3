module ApplicationHelper
  def strftime(time)
    time.in_time_zone("Asia/Tokyo").strftime("%Y/%m/%d")
  end

  def strftime_sec(time)
    time.in_time_zone("Asia/Tokyo").strftime("%Y/%m/%d %H:%M:%S")
  end

end
