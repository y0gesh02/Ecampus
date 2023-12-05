class ChangeDateToDatetimeInCampusDrives < ActiveRecord::Migration[7.0]
  def change
    change_column :campus_drives, :start_date, :datetime
    change_column :campus_drives, :end_date, :datetime
  end
end
