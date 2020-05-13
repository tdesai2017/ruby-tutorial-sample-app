class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  #These are all active record Methods
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive:false}
  has_secure_password
  # This will not allow users to sign up with empty passwords since "has_secure_password" (above) has its own validation of password presence
  #This is put in place so people can update other parts of their profile and don't have to update their password field every time
  
  validates :password, presence: true, length: {minimum:6}, allow_nil: true
  
  
  
  def feed 
    #id here is the same as self.id I think
    #This question mark format ensures safety against a sql injection
    return Micropost.where("user_id = ?", id)
  end
    
  
  
  #Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end

