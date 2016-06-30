class Course < ActiveRecord::Base
	has_many :schedules
	has_many :users, through: :schedules
	validates :title, presence: true,
                    length: { minimum: 5 }
    validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
    validates :timeblock, presence: true
end
