require 'digest/sha1'

class User < ActiveRecord::Base
  validates :username,    :presence => true
  validates_uniqueness_of :username
  validates_length_of :username, :within => 3..40
  validates_length_of :password, :within => 5..40
  validates :password,    :presence => true
  validates :password_confirmation, :presence => true
  validates_confirmation_of :password
  validates :firstname,   :presence => true
  validates :lastname,    :presence => true
  validates :email,       :presence => true
  validates_uniqueness_of :email
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
  has_many :trips
  
  attr_accessor :password, :password_confirm
  attr_protected :id
  
  def password=(pass)
    @password = pass
    if(@password != 'DO NOT UPDATE')
      write_attribute(:hashed_password , Digest::SHA1.hexdigest(@password))
    end
    
  end
  
  def self.authenticate(username, pass)
    u=find(:first, :conditions=>["username = ?", username])
    return nil if u.nil?
    return u if Digest::SHA1.hexdigest(pass)==u.hashed_password
    nil
  end 
    
end
