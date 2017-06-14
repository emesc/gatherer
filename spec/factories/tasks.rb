FactoryGirl.define do
  factory :task do
    sequence :email do |n|
      "user_#{n}@test.com"
    end
    title "Finish Chapter"
    user_email { generate(:email) }
  end

  factory :user do
    name "Fred Flinstone"
    email
  end
end
