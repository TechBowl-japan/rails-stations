FactoryBot.define do
  factory :reservation do
    sequence(:name) { |n| "TEST_USER#{n}" }
    sequence(:email) { |n| "test_email#{n}@test.com" }
    sequence(:date) { |n| "2019-04-1#{n}"}
    sequence(:schedule_id) { n }
    sequence(:sheet_id) { n }
  end
end