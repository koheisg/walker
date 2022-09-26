class User < ApplicationRecord
  has_secure_password
  has_many :followings, dependent: :destroy
  has_many :feeds, through: :followings
end
