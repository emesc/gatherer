FactoryGirl.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}" }
  end

  factory :big_task, parent: :task do
    size 5
  end

  factory :small_task, parent: :task do
    size 1
  end
end
