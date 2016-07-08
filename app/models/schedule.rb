class Schedule < ActiveRecord::Base
	belongs_to :user
	belongs_to :course
	validates :timeblock, presence: true 
	validates :user_id, presence: true 
	validates :course_id, presence: true 
end