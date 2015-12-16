module V1
  RSpec.describe OrganizationResource do
    let :creatable_fields do
      [:name]
    end

    subject do
      described_class.new Organization.new, {}
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
