class IpAddress < ApplicationRecord
  has_many :posts
  has_many :user_ip_addresses
  has_many :users, through: :user_ip_addresses
end
