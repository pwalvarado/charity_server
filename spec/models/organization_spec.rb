RSpec.describe Organization do
  describe "Attributes" do
    it { is_expected.to have_attribute :name }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of :name }
  end

  describe "Relationships" do
    it { is_expected.to have_many :auctions }
  end
end
