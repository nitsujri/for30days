# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    id 1
    email "test@testing.com"
    display_name "James Dean"
    provider "facebook"
    uid "10700263"
    time_zone "Pacific Time (US & Canada)"
    password "facefaceface"
    password_confirmation "facefaceface"
  end
end
