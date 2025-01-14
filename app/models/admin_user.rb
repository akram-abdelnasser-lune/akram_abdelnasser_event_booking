class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "current_sign_in_at", "email", "id", "name"]
  end
end
