class MailPreview < MailView

  def welcome_email
    user = User.first
    mail = UserMailer.welcome_email(user)
  end

  def private_message_email
      message = Message.first
      receiver = User.first
      MessageMailer.new_message_email(message, receiver)
  end

  def reply_email
    message = Message.first
    receiver = User.first
    MessageMailer.reply_message_email(message, receiver)
  end

  def notification_email
    message = Message.first
    receiver = User.first
    NotificationMailer.send_email(message, receiver)
  end

  def comment_email
    trip = Trip.first
    comment = Comment.first
    mail = CommentMailer.comment_email(comment, trip)
  end

  def new_booking_email
    user = User.first
    trip = Trip.first

    mail = BookingMailer.new_booking_email(user, trip)
  end

  def notify_all_travelers_new
    user = User.first
    trip = Trip.first

    mail = BookingMailer.notify_all_travelers_new(user, trip)
  end

  def cancel_booking_email
    user = User.first
    trip = Trip.first

    mail = BookingMailer.cancel_booking_email(user, trip)
  end

  def notify_all_travelers_cancel
    user = User.first
    trip = Trip.first

    mail = BookingMailer.notify_all_travelers_cancel(user, trip)
  end



end