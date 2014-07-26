require 'test_helper'

class ProjectWithDataTest < ActiveSupport::TestCase

	setup :create_project_with_data

	def	create_project_with_data
		@project = Project.new
		newly_done = Task.new(size: 3, completed_at: 1.day.ago)
		old_done = Task.new(size: 2, completed_at: 6.months.ago)
		small_not_done = Task.new(size: 1)
		large_not_done = Task.new(size: 4)
		@project.tasks = [newly_done, old_done, small_not_done, large_not_done]
	end

	test "a project knows its velocity" do
		assert_equal(3, @project.completed_velocity)
	end

	test "a project knows its rate" do
		assert_equal(1.0/ 7, @project.current_rate)
	end

	test "a project knows its projected time remanining" do
		assert_equal(35, @project.projected_days_remaining)
	end

	test "a project can tell if it is on schedule" do
		@project.due_date = 1.week.from_now
		refute(@project.on_schedule?)
		@project.due_date = 6.months.from_now
		assert(@project.on_schedule?)
	end

	test "a project can tell its total size" do
		assert_equal(10, @project.total_size)
	end

end
