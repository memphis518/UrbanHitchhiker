class BookingMailer < ActionMailer::Base
  default from: "no-reply@urbanhitchhiker.com"
  layout 'mailer'

  def new_booking_email(user, trip)
     @user = user
     @trip = TripDecorator.decorate(trip)

     mail(to: user.email, subject: 'Congratulations, You Are Booked!')

  end

  def notify_all_travelers_new(user,trip)
      @hitchhiker = user
      @trip = TripDecorator.decorate(trip)

      @to_list = []
      @to_list.push(@trip.user.email)

      @bookings = trip.bookings

      @bookings.each do |booking|
        @to_list.push(booking.user.email)
      end

      @subject = 'New Passenger For Trip - ' + trip.name

      mail(to:'no-reply@urbanhitchhiker.com', bcc: @to_list, subject: @subject)

  end

  def cancel_booking_email(user, trip)
    @user = user
    @trip = TripDecorator.decorate(trip)

    mail(to: user.email, subject: 'Your booking has been canceled')

  end

  def notify_all_travelers_cancel(user,trip)
    @hitchhiker = user
    @trip = TripDecorator.decorate(trip)

    @to_list = []
    @to_list.push(@trip.user.email)

    @bookings = trip.bookings

    @bookings.each do |booking|
      @to_list.push(booking.user.email)
    end

    @subject = 'Passenger Canceled For Trip - ' + trip.name

    mail(to:'no-reply@urbanhitchhiker.com', bcc: @to_list, subject: @subject)

  end


end
