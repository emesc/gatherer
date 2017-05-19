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
    let(:done) { Task.new(size: 2, completed_at: 2.days.ago) }
    let(:small_not_done) { Task.new(size: 1) }
    let(:large_not_done) { Task.new(size: 4) }

    before(:example) do
      # when: What action is taking place? We're calculating the remaining work
      project.tasks = [done, small_not_done, large_not_done]
    end

    # behaviours that need to be specified; work calculation result
    it "can calculate total size" do
      expect(project.total_size).to eq 7
    end

    it "can calculate remaining size" do
      expect(project.remaining_size).to eq 5
    end
  end
end