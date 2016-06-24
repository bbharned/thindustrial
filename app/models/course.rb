class Course < ActiveRecord::Base
	#has_many :users
	validates :title, presence: true,
                    length: { minimum: 5 }
    validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
end
