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
  
  def authenticate_with_credentials(pw)
    if self.authenticate(pw)
      self
    else
      nil
    end
  end
  
end
