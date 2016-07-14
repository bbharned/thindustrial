class Course < ActiveRecord::Base
	has_many :schedules
	has_many :users, through: :schedules
	has_many :course_categories
	has_many :categories, through: :course_categories
	validates :title, presence: true,
                    length: { minimum: 5 }
    validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
    validates :timeblock, presence: true
end
