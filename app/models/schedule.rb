class Schedule < ActiveRecord::Base
	belongs_to :user
	belongs_to :course
	validates :timeblock, presence: true 
end