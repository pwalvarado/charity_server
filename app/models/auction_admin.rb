class AuctionAdmin < ActiveRecord::Base
  validates  :auction, presence: true
  validates :user, presence: true
  validates :user_id, uniqueness: { scope: :auction_id }

  belongs_to :user
  belongs_to :auction
end
