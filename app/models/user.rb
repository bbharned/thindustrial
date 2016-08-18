class User < ActiveRecord::Base
	has_many :schedules 
	has_many :courses, through: :schedules 
	before_save { self.email = email.downcase }
	validates :firstname, presence: true, length: { minimum: 3, maximum: 20 }
	validates :lastname, presence: true, length: { minimum: 3, maximum: 20 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
	validates :email, presence: true, length: { maximum: 105 },
				uniqueness: { case_sensitive: false },
				format: { with: VALID_EMAIL_REGEX }
	has_secure_password
	has_one :payments
	#accepts_nested_attributes_for :payment

end