class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :trips
  has_many :bookings
  belongs_to :profile

  acts_as_messageable

  before_create :create_profile_record

  after_create :send_welcome_email

  def create_profile_record
      profile = Profile.create
      self.profile_id = profile.id
  end

  def mailboxer_email(object)
    name = self.profile.name unless self.profile.nil?
    email = self.email
    return "#{name} <#{email}>" if email.present?
  end

  def name
    return self.profile.name unless self.profile.nil?
    return self.email
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

end
