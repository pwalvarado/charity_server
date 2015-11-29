class Bid < ActiveRecord::Base
  belongs_to :donation
  belongs_to :bidder, class_name: "User"

  validates :bidder, presence: true
  validates :donation, presence: true
  validates :amount_dolars, presence: true
  validates :quantity, presence: true
  validates :placed_at, presence: true
  validates :amount_dolars, numericality: { greater_than: 0 }
  validate :_quatity_between_1_and_donation_quantity

  def _quatity_between_1_and_donation_quantity
    return unless quantity && donation.try(:quantity)

    unless 1 <= quantity && quantity <= donation.quantity
      errors.add :quantity,  "must be greater than or equal to 1 and less than or equal to 2"
    end
  end
end
