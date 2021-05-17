FactoryBot.define do
  factory :schedule do
    sequence(:movie_id) { |n| n }
    sequence(:start_time) { Time.now }
    sequence(:end_time) { |n| Time.now + n.minutes }
  end
end