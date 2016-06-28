require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase

	def setup
		@schedule = Schedule.new(name: "timeOne")
	end

	test "schedule should be valid" do 
		assert @schedule.valid?
	end


end