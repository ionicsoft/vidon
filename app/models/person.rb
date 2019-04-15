class Person < ApplicationRecord
    attr_accessor :remember_token
    
    before_save do
        self.username = username.downcase
        self.email = email.downcase
    end

    belongs_to :user, polymorphic: true, dependent: :destroy
    has_one_attached :avatar
    has_secure_password
    
    validates :username, presence: true,
                         length: { minimum: 3, maximum: 32 },
                         uniqueness: { case_sensative: false }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, 
                      format: { with: VALID_EMAIL_REGEX },
                      length: { maximum: 255}
    validates :first_name, presence: { if: -> { user.is_a?(Customer) } }
    validates :last_name, presence: { if: -> { user.is_a?(Customer) } }
    validates :password, presence: true, length: { minimum: 6 }

    # Generates a hash digest of provided string
    def Person.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    # Returns a random token
    def Person.new_token
        SecureRandom.urlsafe_base64
    end
    
    # Remember person in database for persistant session
    def remember
        self.remember_token = Person.new_token
        update_attribute(:remember_digest, Person.digest(remember_token))
    end
    
    # Returns true if the token matches the digest
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    
    # Forgets a user
    def forget
        update_attribute(:remember_digest, nil)
    end

    # Returns a person's first and last name
    def full_name
       "#{first_name} #{last_name}"
    end

    # Returns true if a customer person
    def customer?
        user_type == "Customer"
    end

    # Returns true if a producer person
    def producer?
        user_type == "Producer"
    end
end
