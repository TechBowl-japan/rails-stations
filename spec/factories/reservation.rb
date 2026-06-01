FactoryBot.define do
  factory :reservation do
    association :schedule, factory: :schedule
    association :seat, factory: :seat
    sequence(:name) { |n| "TEST_USER#{n}" }
    sequence(:email) { |n| "test_email#{n}@test.com" }
    sequence(:date) { |n| "2019-04-1#{n}"}
  end
end