class BookingDecorator < Draper::Decorator
  delegate_all
  decorates_association :user

  def created_at
    object.created_at.in_time_zone(object.trip.origin.timezone)
  end

end
