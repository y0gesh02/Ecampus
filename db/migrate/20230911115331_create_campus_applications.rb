class CreateCampusApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :campus_applications do |t|
      t.string :contact_information, null: false
      t.string :status, default: "Application Submitted", null: false
      t.string :applicant_id,null: false
      t.references :user, null: false, foreign_key: true
      t.references :campus_drive, null: false, foreign_key: true

      t.timestamps
    end
  end
end
