class Profile < ActiveRecord::Base

  attr_accessible :description, :name, :transportation, :avatar

  mount_uploader :avatar, AvatarUploader
end
