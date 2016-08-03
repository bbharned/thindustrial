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
	has_one :payment
	accepts_nested_attributes_for :payment


 #    def self.month_options
 #        Date::MONTHNAMES.compact.each_with_index.map { |name, i| ["#{i+1} - #{name}", i+1]}
 #    end
    
 #    def self.year_options
 #        (Date.today.year..(Date.today.year+10)).to_a
 #    end


end