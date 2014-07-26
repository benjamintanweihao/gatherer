class CreatesProject

	attr_accessor :name, :task_string, :project

	def initialize(name: "", task_string: "")
		@name = name
		@task_string = task_string
	end

	def	build
		self.project = Project.new(name: name)
		project.tasks = convert_string_to_tasks
		project
	end

	def	convert_string_to_tasks
		task_string.split("\n").map do |task_string|
			title, size = task_string.split(":")
			size = 1 if (size.blank? || size.to_i.zero?)
			Task.new(title: title, size: size)
		end
	end

	def	save
		project.save
	end

	def create
		build
		save
	end
end
