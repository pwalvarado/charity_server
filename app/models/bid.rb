class Bid < ActiveRecord::Base
  belongs_to :donation
  belongs_to :bidder, class_name: "User"

  validates :bidder, presence: true
  validates :donation, presence: true
  validates :amount_dolars, presence: true
  validates :quantity, presence: true
  validates :placed_at, presence: true
end
