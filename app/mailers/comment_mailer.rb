class CommentMailer < ActionMailer::Base
  default from: "no-reply@urbanhitchhiker.com"
  layout 'mailer'

  def comment_email(comment_id, trip_id)
    @trip = Trip.find(trip_id)
    @comment = Comment.find(comment_id)
    @creator = @trip.user

    @subject = 'New Comment For Trip - ' + @trip.name

    @to_list = []
    @to_list.push(@creator.email)

    @bookings = @trip.bookings

    @bookings.each do |booking|
      @to_list.push(booking.user.email)
    end

    mail(to:'no-reply@urbanhitchhiker.com', bcc: @to_list, subject: @subject)

  end

end
