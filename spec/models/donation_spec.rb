RSpec.describe Donation do
  describe "Atrributes" do
    %w(
      title
      description
      auction_id
      bid_type_id
      donor_id
      redemption_window_starts_at
      redemption_window_ends_at
      estimated_value_dollars
      minimum_bid_dollars
      display_description
      admin_follow_up_needed
      fulfillment_type
    ).each do |attr|
      it { is_expected.to have_attribute attr }
    end
  end

  describe "Relationships" do
    it { is_expected.to belong_to :bid_type }

    %w(auction donor).each do |attr|
      it { is_expected.to belong_to attr }

      it { is_expected.to validate_presence_of attr }
    end

    it { is_expected.to have_many :bids}
  end

  describe "Validations" do
    it "validates quantity is either nil or greather than 0" do
      subject.quantity = nil
      subject.valid?
      expect(subject.errors[:quantity]).to be_empty
      subject.quantity = 0
      subject.valid?
      expect(subject.errors[:quantity]).to include "must be greater than 0"
      subject.quantity = 1
      subject.valid?
      expect(subject.errors[:quantity]).to be_empty
    end

    it "validates redemption_window_ends_at is after than redemption_window_starts_at" do

      subject.redemption_window_starts_at = DateTime.new(2015,11,26,0,0)
      subject.redemption_window_ends_at = subject.redemption_window_starts_at
      subject.valid?
      expect(subject.errors[:redemption_window_ends_at]).to include
        "must be after than redemption_window_starts_at"
      subject.redemption_window_ends_at = subject.
        redemption_window_starts_at.advance(seconds: 1)
      subject.valid?
      expect(subject.errors[:redemption_window_ends_at]).to be_empty
    end

    it "validates estimated_value_dollars is either nil or greater than or equel to 0" do
      subject.estimated_value_dollars = nil
      subject.valid?
      expect(subject.errors[:estimated_value_dollars]).to be_empty
      subject.estimated_value_dollars = 0
      subject.valid?
      expect(subject.errors[:estimated_value_dollars]).to be_empty
      subject.estimated_value_dollars = -10
      subject.valid?
      expect(subject.errors[:estimated_value_dollars]).to include
        "must be greater than or equal to 0"
    end

    it "validates that minimum_bid_dollars is either nil or greater than 0" do
      subject.minimum_bid_dollars = nil
      subject.valid?
      expect(subject.errors[:minimum_bid_dollars]).to be_empty
      subject.minimum_bid_dollars = 0
      subject.valid?
      expect(subject.errors[:minimum_bid_dollars]).to include
        "must be greater than 0"
      subject.minimum_bid_dollars = 1
      subject.valid?
      expect(subject.errors[:minimum_bid_dollars]).to be_empty
    end

    it "defaults the admin_follow_up_needed to false" do
      expect(subject.admin_follow_up_needed).to eq false
    end

    it "has fulfillment_type enum definition" do
      expect(described_class.fulfillment_types).to eq(
        "item" => 0,
        "certificate" => 1
        )
    end

    it "has null fulfillment_type after initializacion" do
      expect(subject.fulfillment_type).to be_nil
    end
  end
end
