class User < ActiveRecord::Base

  validates :name, 
    presence: true,
    length: { maximum: 50 }
  validates :email, 
    presence: true, 
    uniqueness: true,
    length: { maximum: 150 }

  has_secure_password
  
end
