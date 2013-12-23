class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
     redirect_to root_path, :alert => exception.message
  end

  def current_user
    super.profile = ProfileDecorator.decorate(super.profile) unless super.nil?
    return super
  end

end
