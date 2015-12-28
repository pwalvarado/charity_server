RSpec.describe User do
  describe "Attributes" do
    %w(name mobile_phone_number email_address physical_address).each do |attr|
      it { is_expected.to have_attribute attr }
    end
  end

  describe "Relationships" do
    it {is_expected.to have_many :memberships }

    it { is_expected.to have_many :donations }
  end

  describe "Validations" do
    %w(name mobile_phone_number email_address physical_address).each do |attr|
      it { is_expected.to validate_presence_of attr }
    end

    # %w(mobile_phone_number email_address).each do |attr|
    #   # it { is_expected.to validate_uniqueness_of attr }
    #   # Before doesn't work, Explanation:
    #   # http://stackoverflow.com/questions/27046691/cant-get-uniqueness-validation-test-pass-with-shoulda-matcher
    #   it do
    #     FactoryGirl.create(:user)
    #     is_expected.to validate_uniqueness_of(attr)
    #   end
    # end

    it "validates the uniqueness of email_address" do
      original = FactoryGirl.create(:user, email_address: "test@test.com")
      duplicate = FactoryGirl.build(:user, email_address: original.email_address)
      duplicate.valid?
      expect(duplicate.errors[:email_address]).to include "has already been taken"
    end

    it "validates the uniqueness of mobile_phone_number" do
      original = FactoryGirl.create(:user, mobile_phone_number: "8885551212")
      duplicate = FactoryGirl.build(:user, mobile_phone_number: original.mobile_phone_number)
      duplicate.valid?
      expect(duplicate.errors[:mobile_phone_number]).to include "has already been taken"
    end

    it "persists a password_digest based on the password that can be used for authentication" do
      password = "password"
      subject = FactoryGirl.create(:user, password: password)
      expect(subject.authenticate(password)).to eq subject
    end
  end
end
