# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    title "MyString"
    description "MyText"
    deadline "2013-06-05"
    user_id 1
    responsible_id 1
  end
end
