require 'test_helper'

class CreatesProjectTest < ActiveSupport::TestCase

	test "creates a project given a name" do
		creator = CreatesProject.new(name: "Project Runway")
		creator.build
		assert_equal "Project Runway", creator.project.name
	end

	test "handles a single string" do
		creator = CreatesProject.new(name: "Test", task_string: "start things")
		tasks = creator.convert_string_to_tasks
		assert_equal 1, tasks.size
		assert_equal "start things", tasks.first.title
		assert_equal 1, tasks.first.size
	end

	test "handles multiple tasks" do
		creator = CreatesProject.new(name: "Test", task_string: "start things:3\nend things:2")
		tasks = creator.convert_string_to_tasks
		assert_equal 2, tasks.size
	end

	test "saves a project with tasks" do
		creator = CreatesProject.new(name: "Project Runway", task_string: "start things:3\nend things:2")
		creator.build.save
		assert_equal 2, creator.project.tasks.size
		refute creator.project.new_record?
	end


end
