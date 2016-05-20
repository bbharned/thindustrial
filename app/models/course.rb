class Course < ActiveRecord::Base
	validates :title, presence: true,
                    length: { minimum: 5 }
    validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
end
