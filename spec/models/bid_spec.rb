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
  end
end
