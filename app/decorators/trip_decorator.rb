class TripDecorator < Draper::Decorator
  delegate_all
  decorates_association :user


  def start_datetime
    object.start_datetime.in_time_zone(object.origin.timezone)
  end

end
