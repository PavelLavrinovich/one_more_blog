class UserIpAddress < ApplicationRecord
  belongs_to :user
  belongs_to :ip_address
end
