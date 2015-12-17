require "rspec_api_documentation_helper"

RSpec.resource "Memberships" do
  header "Content-Type", "application/vnd.api+json"

  get "/v1/memberships" do
    before do
      3.times do
        FactoryGirl.create(:membership)
      end
    end

    example_request "GET /v1/memberships" do
      expect(status).to eq 200
      memberships = JSON.parse(response_body)
      expect(memberships["data"].size).to eq 3
    end
  end

  post "/v1/memberships" do
    let! :persisted_user do
      FactoryGirl.create(:user)
    end

    let! :persisted_organization do
      FactoryGirl.create(:organization)
    end

    parameter "type", <<-DESC, required: true
      The type of the resource. Always 'memberships'.
    DESC

    let "type" do
      "memberships"
    end

    parameter "user", <<-DESC, required: true, scope: :relationships
      The user of the membership.
    DESC

    let "user" do
      {
        data: {
          type: "users",
          id: persisted_user.id.to_s
        }
      }
    end

    parameter "organization", <<-DESC, scope: :relationships, required: true
      The organization of the membership.
    DESC

    let "organization" do
      {
        data: {
          type: "organizations",
          id: persisted_organization.id.to_s
        }
      }
    end

    example_request "POST /v1/memberships" do
      #puts request
      puts response_body
      expect(status).to eq 201
    end
  end

end
