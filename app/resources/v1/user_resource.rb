module V1
  class UserResource < BaseResource
    attribute :name
    attribute :mobile_phone_number
    attribute :email_address
    attribute :physical_address
    attribute :password

    # class << self
    #   def creatable_fields(context)
    #     [:name, :mobile_phone_number, :email_address, :physical_address, :password]
    #   end
    #   alias_method :updatable_fields, :creatable_fields
    # end

    def fetchable_fields
      super - [:password]
    end
  end
end
