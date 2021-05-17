FactoryBot.define do
  factory :sheet do
    sequence(:column) { |n| n }
    sequence(:row) { "a" }
  end
end