require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

	test "a project with no tasks is done" do
		project = Project.new
		assert(project.done?)
	end

	test "a project with an incomplete task is not done" do
		project = Project.new
		task = Task.new
		project.tasks << task
		refute(project.done?)
	end

	test "a project is only done if all its tasks are done" do
		project = Project.new
		task = Task.new
		project.tasks << task
		refute(project.done?)
		task.mark_completed
		assert(project.done?)
	end

	test "a project with no completed tasks projects correctly" do
		project = Project.new
		assert_equal(0, project.completed_velocity)
		assert_equal(0, project.current_rate)
		assert(project.projected_days_remaining.nan?)
		refute(project.on_schedule?)

	end

end
