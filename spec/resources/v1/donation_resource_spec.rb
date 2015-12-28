module V1
  RSpec.describe DonationResource do
    let :creatable_fields do
      [ :bid_type,
        :auction,
        :donor,

        :title,
        :description,
        :quantity,
        :redemption_window_starts_at,
        :redemption_window_ends_at,
        :estimated_value_amount,
        :display_description,
        :fulfillment_type,
       ].sort
    end

    subject do
      described_class.new Donation.new, {}
    end

    it "has the expected creatable attributes" do
      expect(described_class.creatable_fields({}).sort).to eq creatable_fields
    end

    it "has the expected updatable attributes" do
      expect(described_class.updatable_fields({}).sort).to eq creatable_fields
    end

    it "has the expected fetchable attributes" do
      expect(subject.fetchable_fields.sort).to eq (creatable_fields + [:id, :created_at, :updated_at]).sort
    end
  end
end
