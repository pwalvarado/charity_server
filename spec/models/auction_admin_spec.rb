RSpec.describe AuctionAdmin  do
  describe "Attributes" do
    it { is_expected.to validate_presence_of :auction }
    it { is_expected.to validate_presence_of :user }
    #it { is_expected.to validates_uniqueness_of(:user_id).scoped_to(:auction_id) }
    # Before doesn't work, Valid example at:
    # http://stackoverflow.com/questions/25742505/testing-uniqueness-scope-validation-using-shoulda-matchers
    it 'should validate uniqueness of user_id scoped to auction_id' do
      user = FactoryGirl.create(:user)
      auction = FactoryGirl.create(:auction)
      FactoryGirl.create(:auction_admin, user_id: user.id, auction_id: auction.id)
      is_expected.to validate_uniqueness_of(:user_id).scoped_to(:auction_id)
    end
  end

  describe "Relations" do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :auction }
  end
end
