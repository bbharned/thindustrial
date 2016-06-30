class ChangeSchedules < ActiveRecord::Migration
  def change
  	remove_column :schedules, :course_timeblock_id
  	add_column :schedules, :timeblock, :integer
  end
end
