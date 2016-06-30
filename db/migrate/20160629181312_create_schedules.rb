class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
    	t.belongs_to :user, index: true
      	t.belongs_to :course, index: true
      	t.belongs_to :course_timeblock
      	t.timestamps null: false
    end
  end
end
