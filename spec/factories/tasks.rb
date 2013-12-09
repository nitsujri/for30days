# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    name  "A New 30 Day task"
    user_id 1
    start_date Date.today
  end
end
