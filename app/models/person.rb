class Person < ApplicationRecord
    attr_accessor :remember_token, :activation_token
    
    before_save do
        self.username = username.downcase
        self.email = email.downcase
    end
    
    before_create :create_activation_digest

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
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end
    
    # Forgets a user
    def forget
        update_attribute(:remember_digest, nil)
    end
    
    # Activates an account.
    def activate
        update_columns(activated: true, activated_at: Time.zone.now)
    end
    
    # Sends activation email.
    def send_activation_email
        UserMailer.account_activation(self).deliver_now
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
    
    
    private
        # Creates and assigns the activation token and digest.
        def create_activation_digest
            self.activation_token = Person.new_token
            self.activation_digest = Person.digest(activation_token)
        end
end
