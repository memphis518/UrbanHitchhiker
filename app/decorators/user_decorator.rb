class UserDecorator < Draper::Decorator
  delegate_all
  decorates_association :profile

end
