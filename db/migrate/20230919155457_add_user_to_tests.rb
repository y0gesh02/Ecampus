class AddUserToTests < ActiveRecord::Migration[7.0]
  def change
    add_reference :tests, :user, null: false, foreign_key: true
    change_column :tests, :job_id, :integer, null: true
    change_column :tests, :campus_drive_id, :integer, null: true
  end
end
