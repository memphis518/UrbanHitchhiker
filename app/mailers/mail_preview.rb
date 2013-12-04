class MailPreview < MailView

  def welcome_email
    user = User.first
    mail = UserMailer.welcome_email(user.id)
  end

  def private_message_email
      message = Message.first
      receiver = User.first
      mail = MessageMailer.new_message_email(message, receiver)
  end

  def reply_email
    message = Message.first
    receiver = User.first
    mail = MessageMailer.reply_message_email(message, receiver)
  end

  def notification_email
    message = Message.first
    receiver = User.first
    mail = NotificationMailer.send_email(message, receiver)
  end

  def comment_email
    trip = Trip.first
    comment = Comment.first
    mail = CommentMailer.comment_email(comment.id, trip.id)
  end

  def new_booking_email
    user = User.first
    trip = Trip.first

    mail = BookingMailer.new_booking_email(user.id, trip.id)
  end

  def notify_all_travelers_new
    user = User.first
    trip = Trip.first

    mail = BookingMailer.notify_all_travelers_new(user.id, trip.id)
  end

  def cancel_booking_email
    user = User.first
    trip = Trip.first

    mail = BookingMailer.cancel_booking_email(user.id, trip.id)
  end

  def notify_all_travelers_cancel
    user = User.first
    trip = Trip.first

    mail = BookingMailer.notify_all_travelers_cancel(user.id, trip.id)
  end



end