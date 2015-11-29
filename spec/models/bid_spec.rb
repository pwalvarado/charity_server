RSpec.describe Bid do
  describe "Attributes" do
    %w(amount_dolars quantity placed_at bidder_id donation_id).each do |attr|
      it { is_expected.to have_attribute attr }
    end
  end

  describe "Relationships" do
    %w(donation bidder).each do |attr|
      it { is_expected.to belong_to attr }
    end
  end

  describe "Validations" do
    %w(amount_dolars quantity placed_at donation bidder).each do |attr|
      it { is_expected.to validate_presence_of attr }
    end

    it { is_expected.to validate_numericality_of(:amount_dolars).is_greater_than(0) }

    it "validates that the quantity is between 1 and donation's quantity" do
      subject.donation = Donation.new(quantity: 2)
      subject.quantity = 0
      subject.valid?
      expect(subject.errors[:quantity]).to include "must be greater than or equal to 1 and less than or equal to 2"
    end
  end
end
