class Payment < ActiveRecord::Base
    has_many :users
    validates :user_id, presence: true
    
    
end
