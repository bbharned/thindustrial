class Category < ActiveRecord::Base
	has_many :course_categories
	has_many :courses, through: :course_categories
	validates :name, presence: true, length: { minimum: 3, maximum: 25 }
	validates_uniqueness_of :name
end
