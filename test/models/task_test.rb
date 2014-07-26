require 'test_helper'

class TaskTest < ActiveSupport::TestCase

	test "a completed task is complete" do
		task = Task.new
		refute(task.complete?)
		task.mark_completed
		assert(task.complete?)
	end

	test "an uncompleted task down not count toward velocity" do
		task = Task.new(size: 3)
		refute(task.counts_towards_velocity?)
		assert_equal(0, task.points_toward_velocity)
	end

	test "a task completed long ago does not count toward velocity" do
		task = Task.new(size: 3)
		task.mark_completed(6.months.ago)
		refute(task.counts_towards_velocity?)
		assert_equal(0, task.points_toward_velocity)
	end

	test "a task completed recently counts toward velocity" do
		task = Task.new(size: 3)
		task.mark_completed(1.day.ago)
		assert(task.counts_towards_velocity?)
		assert_equal(3, task.points_toward_velocity)
	end

end
