# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :journal do
    user_id 1
    journable_id 1
    jounerable_type "MyString"
    text "MyText"
  end
end
