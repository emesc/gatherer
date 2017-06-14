FactoryGirl.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}" }

    factory :big_task, parent: :task do
      size 5
    end
  end

  factory :small_task, parent: :task do
    size 1
  end
end
