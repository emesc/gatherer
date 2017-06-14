FactoryGirl.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}" }

    sequence :email do |n|
      "user_#{n}@test.com"
    end
  end

  factory :user do
    name "Fred Flinstone"
    email
  end
end
