class Auction < ActiveRecord::Base
  has_many :donations

  belongs_to :organization

  validate :_ends_at_after_starts_at

  validate :_starts_at_after_donation_window_ends_at

  validates :time_zone_id, inclusion: { in: ActiveSupport::TimeZone::MAPPING.values,
    message: "must be in list" }, allow_blank: :true

  validates :organization, presence: true

  def _ends_at_after_starts_at
    return unless starts_at && ends_at

    if ends_at <= starts_at
      errors.add :ends_at, "must be greater than starts_at"
    end
  end

  def _starts_at_after_donation_window_ends_at
    return unless starts_at && donation_window_ends_at

    if starts_at <= donation_window_ends_at
      errors.add :starts_at, "must be greater than donation_window_ends_at"
    end
  end


end
