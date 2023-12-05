class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :paper, null: false, foreign_key: true
      t.text :response_text
      t.text :response_choice
      t.references :test_attempt, null: false, foreign_key: true

      t.timestamps
    end
  end
end
