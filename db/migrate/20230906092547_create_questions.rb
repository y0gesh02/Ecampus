class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.text :question, null: false
      t.string :question_type, null: false, default: 'objective'
      t.json :options, default: [], null: true
      t.text :correct_answer
      t.text :answer
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
