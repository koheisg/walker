class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :confirmable, :lockable, :timeoutable, :trackable, :database_authenticatable, :recoverable, :registerable, :rememberable, :validatable, stretches: 13
end
