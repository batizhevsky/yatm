FactoryGirl.define do
  factory :task do
    title "test task"
    description "many many time"
    deadline "2013-06-05"
    user
    creator
    responsible
  end
end
