class CreateUserReports < ActiveRecord::Migration[7.0]
  def change
    create_table :user_reports do |t|
      t.references :user, null: false, foreign_key: true
      t.references :test_attempt, null: false, foreign_key: true
      t.integer :total_score
      t.string :campus_drive

      t.timestamps
    end
  end
end
