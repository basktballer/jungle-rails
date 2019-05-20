class User < ActiveRecord::Base

  validates :name, 
    presence: true,
    length: { maximum: 50 }
  validates :email, 
    presence: true, 
    uniqueness: { case_sensitive: false },
    length: { maximum: 150 }
  validates :password,
    presence: true,
    length: { minimum: 3 }
  validates :password_confirmation,
    presence: true,
    length: { minimum: 3 }
  has_secure_password
  
  def authenticate_with_credentials(email, pw)
    user = User.find_by_email(email.strip.downcase)
    if user && user.authenticate(pw)
      user
    else
      nil
    end
  end
  
end
