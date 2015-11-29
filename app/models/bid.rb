class Bid < ActiveRecord::Base
  belongs_to :donation
  belongs_to :bidder
end
