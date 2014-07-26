class Task < ActiveRecord::Base
	attr_accessor :completed_at

	def	mark_completed(date = nil)
		@completed_at = (date || Time.current)
	end

	def	complete?
		!completed_at.nil?
	end

	def	counts_towards_velocity?
		return false unless complete?
		completed_at > Project.velocity_length_in_days.days.ago
	end

	def	points_toward_velocity
		if counts_towards_velocity? then size else 0 end
	end

end
