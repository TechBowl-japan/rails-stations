FactoryBot.define do
  factory :reservation do
    association :schedule, factory: :schedule
    association :sheet, factory: :sheet
    sequence(:name) { |n| "TEST_USER#{n}" }
    sequence(:email) { |n| "test_email#{n}@test.com" }
    sequence(:date) { |n| "2019-04-1#{n}"}
  end
end