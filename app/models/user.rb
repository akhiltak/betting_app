class User < ActiveRecord::Base
  validates :device_id, :uniqueness => true

  has_many :bets
end
