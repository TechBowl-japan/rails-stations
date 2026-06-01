FactoryBot.define do
  factory :seat do
    sequence(:column) { |n| n }
    sequence(:row) { "a" }
  end
end