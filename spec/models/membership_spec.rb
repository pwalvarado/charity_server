RSpec.describe Membership do
  describe "Attributes" do
    it { is_expected.to have_attribute :organization_id }

    it { is_expected.to have_attribute :user_id }
  end

  describe "Relationships" do
    it { is_expected.to belong_to :user }

    it { is_expected.to belong_to :organization }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of :organization }

    it { is_expected.to validate_presence_of :user }

    it "validates that the user has not changed" do
      subject = FactoryGirl.create(:membership)
      subject.user = User.new
      subject.valid?
      expect(subject.errors[:user]).to include "cannot be changed"
    end

    it "Validates that the organization has not changed" do
      subject  = FactoryGirl.create(:membership)
      subject.organization = Organization.new
      subject.valid?
      expect(subject.errors[:organization]).to include "cannot be changed"
    end
  end
end
