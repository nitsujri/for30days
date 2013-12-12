# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    id 1
    name  "A New 30 Day task"
    status "active"
    user_id 1
    start_date Date.today
  end

  factory :task_inactive, class: Task do
    id 1
    name  "An Inactive task"
    user_id 1
    start_date Date.today
    status "inactive"
  end
end
