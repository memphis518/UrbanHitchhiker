# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email 'someone@domain.com'
    password  'badpassword'
    password_confirmation  'badpassword'
    remember_me true
  end
end
