class TripDecorator < Draper::Decorator
  delegate_all

  def start_datetime
    object.start_datetime.in_time_zone(object.origin.timezone)
  end

end
