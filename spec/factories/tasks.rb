FactoryGirl.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}" }

    trait :large do
      size 5
    end

    trait :small do
      size 1
    end

    trait :soon do
      due_date { 1.day.from_now }
    end

    trait :later do
      due_date { 1.month.from_now }
    end

    # can be rewritten as factory :trivial, traits: [:small, :later]
    factory :trivial do
      small
      later
    end

    # can be rewritten as factory :panic, traits: [:large, :soon]
    factory :panic do
      large
      soon
    end
  end
end
