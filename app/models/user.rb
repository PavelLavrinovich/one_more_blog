class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :user_ip_addresses, dependent: :destroy
  has_many :ip_addresses, through: :user_ip_addresses
end
