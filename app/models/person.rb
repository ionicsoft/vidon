class Person < ApplicationRecord
    validates :username, presence: true, length: { minimum: 3 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
    validates :first_name, presence: true
    validates :last_name, presence: true
    
    has_secure_password
end
