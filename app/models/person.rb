class Person < ApplicationRecord
    before_save do
        self.username = username.downcase
        self.email = email.downcase
    end

    belongs_to :user, polymorphic: true, dependent: :destroy
    has_one_attached :avatar
    has_secure_password
    
    validates :username, presence: true, length: { minimum: 3 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
    validates :first_name, presence: { if: -> { user.is_a?(Customer) } }
    validates :last_name, presence: { if: -> { user.is_a?(Customer) } }

    def full_name
       "#{first_name} #{last_name}"
    end

    def customer?
        user_type == "Customer"
    end

    def producer?
        user_type == "Producer"
    end
end
