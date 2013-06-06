# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:email) {|n| "person#{n}@example.com" }

  factory :user, aliases: [:creator, :responsible] do
    email { generate(:email) }
    password 'changeme'
    password_confirmation 'changeme'
  end
end
