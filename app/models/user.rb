class User < ActiveRecord::Base
  validates :device_id, :uniqueness => true
end
