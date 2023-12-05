class CreateJoinTablePapersQuestions < ActiveRecord::Migration[7.0]
  def change
    create_join_table :papers, :questions do |t|
      # t.index [:paper_id, :question_id]
      # t.index [:question_id, :paper_id]
    end
  end
end
