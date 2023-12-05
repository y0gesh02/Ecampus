class CreateTests < ActiveRecord::Migration[7.0]
  def change
    create_table :tests do |t|
      t.string :name
      t.text :details
      t.integer :total_time
      t.integer :duration_in_minutes
      t.integer :passing_marks
      t.references :job, null: true, foreign_key: true
      t.references :campus_drive, null: true, foreign_key: true

      t.timestamps
    end
  end
end
