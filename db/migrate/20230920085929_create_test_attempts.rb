class CreateTestAttempts < ActiveRecord::Migration[7.0]
  def change
    create_table :test_attempts do |t|
      t.references :test, null: false, foreign_key: true
      t.references :campus_drive, foreign_key: true
      t.references :job, foreign_key: true
      t.datetime :started_at
      t.datetime :submitted_at
      t.integer :total_score
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
