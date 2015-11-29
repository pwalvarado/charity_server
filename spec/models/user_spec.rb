RSpec.describe User do
  describe "Relationships" do
    it {is_expected.to have_many :auction_admins }
  end

  describe "Validations" do
    %w(name mobile_phone_number email_address physical_address).each do |attr|
      it { is_expected.to have_attribute attr }
      it { is_expected.to validate_presence_of attr }
    end

    %w(mobile_phone_number email_address).each do |attr|
      # it { is_expected.to validate_uniqueness_of attr }
      # Before doesn't work, Explanation:
      # http://stackoverflow.com/questions/27046691/cant-get-uniqueness-validation-test-pass-with-shoulda-matcher
      it do
        FactoryGirl.create(:user)
        is_expected.to validate_uniqueness_of attr
      end
    end
  end

  describe "Relationships" do
    it { is_expected.to have_many :donations }
  end
end
