FactoryGirl.define do
  factory :task do
    title: "To Something"
    size: 3
    project
    association :doer, factory: :user, strategy: :build, name: "Task Doer"
  end
end
