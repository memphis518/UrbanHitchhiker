class UserMailer < ActionMailer::Base
  default from: "no-reply@urbanhitchhiker.com"
  layout 'mailer'

  def welcome_email(user_id)
    @user = User.find(user_id)
    @sign_in_url  = new_user_session_path
    @profile_url = edit_profile_url (@user.profile)
    mail(to: @user.email, subject: 'Welcome to UrbanHitchhiker!')
  end

end
