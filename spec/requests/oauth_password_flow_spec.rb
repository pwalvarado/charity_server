RSpec.describe "OAuth password flow" do
  let :email_address do
    "test@test.com"
  end

  let :password do
    "12344321"
  end

  let! :user do
    FactoryGirl.create(:user, email_address: email_address, password: password)
  end

  it "Creates a token and return it when the credentials are valid"do
    post "/oauth/token", grant_type: "password", username: email_address, password: password
    expect(response.status).to eq 200
    expect(JSON.parse(response.body)["access_token"]).not_to be_nil
  end

  it "Does not issue a token if the credentials are invalid" do
    post "/oauth/token", grant_type: "password", username: email_address, password: "errado"
    expect(response.status).to eq 401
    expect(JSON.parse(response.body)["access_token"]).to be_nil
  end
end
