module V1
  class DonationResource < BaseResource
    attribute :title
    attribute :description
    attribute :quantity
    attribute :redemption_window_starts_at
    attribute :redemption_window_ends_at
    attribute :estimated_value_amount
    attribute :display_description
    attribute :fulfillment_type
    has_one :auction
    has_one :donor
    has_one :bid_type
  end
end
