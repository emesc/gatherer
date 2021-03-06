require 'rails_helper'

RSpec.describe Project do

  describe "initialization" do
    let(:project) { Project.new }
    let(:task) { Task.new }

    it "considers a project with no tasks to be done" do
      expect(project).to be_done
    end

    it "knows that a project with an incomplete task is not done" do
      project.tasks << task
      expect(project).not_to be_done
    end

    it "marks a project done if its tasks are done" do
      project.tasks << task
      task.mark_completed
      expect(project).to be_done
    end
  end

  describe "estimates" do
    # given data: test needs a project, at least one complete and one incomplete tasks
    let(:project) { Project.new }
    let(:newly_done) { Task.new(size: 3, completed_at: 1.day.ago) }
    let(:old_done) { Task.new(size: 2, completed_at: 6.months.ago) }
    let(:small_not_done) { Task.new(size: 1) }
    let(:large_not_done) { Task.new(size: 4) }

    before(:example) do
      # when: What action is taking place? We're calculating the remaining work
      project.tasks = [newly_done, old_done, small_not_done, large_not_done]
    end

    # behaviours that need to be specified; work calculation result
    it "can calculate total size" do
      expect(project.total_size).to eq 10
    end

    it "can calculate remaining size" do
      expect(project.remaining_size).to eq 5
    end

    it "knows its velocity" do
      expect(project.completed_velocity).to eq 3
    end

    it "knows its rate" do
      expect(project.current_rate).to eq(1.0 / 7)
    end

    it "knows its projected time remaining" do
      expect(project.projected_days_remaining).to eq 35
    end

    it "knows if it is on schedule" do
      project.due_date = 1.week.from_now
      expect(project).not_to be_on_schedule
      project.due_date = 6.months.from_now
      expect(project).to be_on_schedule
    end

    it "properly estimates a blank project" do
      project.tasks = []
      expect(project.completed_velocity).to eq 0
      expect(project.current_rate).to eq 0
      expect(project.projected_days_remaining.nan?).to be_truthy
      expect(project).not_to be_on_schedule
    end

    it "can calculate total size" do
      expect(project).to be_of_size(10)
      expect(project).not_to be_of_size(5).for_incomplete_tasks_only
    end
  end

  it "uses factory girl slug block" do
    project = FactoryGirl.create(:project, name: "Book To Write")
    expect(project.slug).to eq("book_to_write")
  end

  it "uses factory girl build_stubbed method" do
    project = FactoryGirl.build_stubbed(:project, name: "New Project")
    expect(project.name).to eq ("New Project")
  end

  it "yields the new object to a block for custom processing" do
    project = FactoryGirl.build_stubbed(:project) do |p|
      p.tasks << FactoryGirl.build_stubbed(:task)
    end
  end
end