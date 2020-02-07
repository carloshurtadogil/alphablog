class User < ApplicationRecord
  #dependent destroys all articles associated with the current user
  has_many :articles, dependent: :destroy

  # sets the email input to lowercase before moving further with its function
  before_save { self.email = email.downcase }

  # Validates username input
  validates :username, presence: true, 
            uniqueness: { case_sensitive: false }, 
            length: { minimum: 3, maximum: 25 }
  
  # Validates email input
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # checker for valid email format
  validates :email, presence: true,
            length: { maximum: 105 },
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }
            
  has_secure_password
end