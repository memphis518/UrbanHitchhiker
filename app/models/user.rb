class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :trips
  has_many :bookings
  belongs_to :profile

  before_create :create_profile_record

  def create_profile_record
      profile = Profile.create
      self.profile_id = profile.id
  end

end
