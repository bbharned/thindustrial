require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase

	def setup
		@schedule = Schedule.new(user_id: 1, course_id:4, timeblock: 3)
	end

	test "schedule should be valid" do 
		assert @schedule.valid?
	end

	test "timeblock must exist" do
		@schedule.timeblock = ""
		assert_not @schedule.valid?
	end


end