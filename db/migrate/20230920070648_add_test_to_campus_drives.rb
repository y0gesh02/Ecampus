class AddTestToCampusDrives < ActiveRecord::Migration[7.0]
  def change
    add_reference :campus_drives, :test, foreign_key: true
  end
end
