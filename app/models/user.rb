class User < ActiveRecord::Base
  validates :device_id, :uniqueness => true

  has_many :bets
  has_many :addresses
  has_many :user_preferences
end
