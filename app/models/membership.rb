class Membership < ActiveRecord::Base
  belongs_to :user

  belongs_to :organization

  validates :user, presence: true

  validates :organization, presence: :true

  validate :_user_and_organization_have_not_change

  def _user_and_organization_have_not_change
    return unless persisted?

    ["user", "organization"].each do |key|
      if changes.key?(key + "_id")
        errors.add key, "cannot be changed"
      end
    end
  end
end
