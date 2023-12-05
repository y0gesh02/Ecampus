class AddEligibleYeartoCampusDrives < ActiveRecord::Migration[7.0]
  def change
    add_column :campus_drives, :eligible_year, :string
  end
end
