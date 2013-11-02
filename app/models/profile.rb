class Profile < ActiveRecord::Base

  attr_accessible :description, :name, :avatar

  mount_uploader :avatar, AvatarUploader
end
