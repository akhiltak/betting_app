class Bet < ActiveRecord::Base
	validates :user_id, :presence => true

	belongs_to :order
end
