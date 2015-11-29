class DefaultToAdminFollowUpNeededToFalseForDonations < ActiveRecord::Migration
  def change
    change_column :donations, :admin_follow_up_needed, :boolean, default: false
  end
end
