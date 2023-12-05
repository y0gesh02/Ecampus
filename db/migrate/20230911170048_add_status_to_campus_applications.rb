class AddStatusToCampusApplications < ActiveRecord::Migration[7.0]
  def change
    change_column :campus_applications, :status,:string , default: "Application Submitted"
  end
end
