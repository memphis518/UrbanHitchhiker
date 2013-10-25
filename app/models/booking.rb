class Booking < ActiveRecord::Base
  attr_accessible :trip_id, :user_id

  belongs_to :trip
  belongs_to :user

  validate :seats_remain, :on => :create

  def seats_remain
     if self.trip.total_seats <= self.trip.bookings.count
       errors.add(:base, 'All seats have been booked on this trip')
     end
  end

end
