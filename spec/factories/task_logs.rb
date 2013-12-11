# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task_log do
    task_id 1
    user_id 1
    status "completed"
  end

  factory :task_log_missed do
    task_id 1
    user_id 1
    status "missed"
  end
end
