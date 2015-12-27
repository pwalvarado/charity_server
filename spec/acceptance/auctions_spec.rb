require "rake"
require "rspec_api_documentation_helper"

RSpec.resource "Auctions" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "auction parameters" do
    parameter "type", <<-DESC, required: true
      The type of the resource. Must be 'auctions'.
    DESC

    let "type" do
      "auctions"
    end

    parameter "organization", <<-DESC, required: true, scope: :relationships
      The organization to which the auction belongs.
    DESC

    parameter "starts-at", <<-DESC, required: false, scope: :attributes
      The time at which auction starts in UTC.
    DESC

    parameter "ends-at", <<-DESC, required: false, scope: :attributes
      The time at which auction ends in UTC.
    DESC

    parameter "time-zone-id", <<-DESC, required: true, scope: :attributes
      The time zone id that should be used to localize the times for the auction. For example, 'America/New_York'.
    DESC

    parameter "physical-address", <<-DESC, required: false, scope: :attributes
      The physical address at which the auction will be held.
    DESC

    parameter "name", <<-DESC, required: true, scope: :attributes
      The name by which the auction should be referred to.
    DESC

    parameter "donation_window_ends_at", <<-DESC, required: true, scope: :attributes
      The time in UTC after which donations to the auction can no longer be accepted.
    DESC
  end

  shared_context "persisted auction" do
    let! :persisted_auction do
      FactoryGirl.create(:auction)
    end

    let :auction_id do
      persisted_auction.id.to_s
    end
  end

  post "/v1/auctions" do
    include_context "auction parameters"

    let! :persisted_organization do
      FactoryGirl.create(:organization)
    end

    let "name" do
      "Decemberfest 2015 Colombian Charity"
    end

    let "donation-window-ends-at" do
      Time.utc(2015,12,24,12,0).as_json
    end

    let "starts-at" do
      Time.utc(2015,12,25,12,0).as_json
    end

    let "ends-at" do
      Time.utc(2015,12,25,14,0).as_json
    end

    let "time-zone-id" do
      "America/Bogota"
    end

    let "physical-address" do
      "Circunvalar 1ra, 36 - 4"
    end

    let "organization" do
      {
        data: {
          type: "organizations",
          id: persisted_organization.id.to_s
        }
      }
    end

    example_request "POST /v1/auctions" do
      expect(status).to eq 201
      auction = JSON.parse(response_body)
      expect(auction["data"]["attributes"]["name"]).to eq public_send("name")
    end
  end

  patch "/v1/auctions/:auction_id" do
    include_context "persisted auction"

    parameter "id", <<-DESC, required: true
      The id of the resource
    DESC

    let "id" do
      auction_id
    end

    include_context "auction parameters"

    let "name" do
      "Automated Labor"
    end

    example_request "PATCH /v1/auctions/:id" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"]["attributes"]["name"]).to eq public_send("name")
    end
  end

  get "/v1/auctions" do
    before do
      FactoryGirl.create(:auction)
    end

    example_request "GET /v1/auctions" do
      expect(status).to eq 200
      auctions = JSON.parse(response_body)["data"]
      expect(auctions.size).to eq Auction.count
    end
  end

  get "/v1/auctions/:auction_id" do
    include_context "persisted auction"

    example_request "GET /v1/auctions/:auction_id" do
      expect(status).to eq 200
    end
  end

  delete "/v1/auctions/:auction_id" do
    include_context "persisted auction"

    example_request "DELETE /v1/auctions/:id" do
      expect(status).to eq 204
    end
  end
end

