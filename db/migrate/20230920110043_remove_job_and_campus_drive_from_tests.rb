class RemoveJobAndCampusDriveFromTests < ActiveRecord::Migration[7.0]
  def change
    remove_reference :tests, :job, foreign_key: true
    remove_reference :tests, :campus_drive, foreign_key: true
  end
end
