class Post < ApplicationRecord
  belongs_to :user
  belongs_to :ip_address
  has_many :marks, dependent: :destroy
end
