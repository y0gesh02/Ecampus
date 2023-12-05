class CreatePapers < ActiveRecord::Migration[7.0]
  def change
    create_table :papers do |t|
      t.string :name
      t.text :description
      t.integer :total_marks
      t.integer :duration_in_minutes
      t.integer :passing_marks
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
