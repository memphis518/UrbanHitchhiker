class CommentMailer < ActionMailer::Base
  default from: "no-reply@urbanhitchhiker.com"
  layout 'mailer'

  def comment_email(comment, trip)
    @trip = trip
    @comment = comment
    @creator = trip.user

    mail(to: @creator.email, subject: 'New Comment For Trip - ' + trip.name)
  end

end
