FactoryBot.define do
  factory :screen do
    sequence(:name) { |n| "スクリーン#{n}" }
  end
end
