class CreateJoinTableTestsPapers < ActiveRecord::Migration[7.0]
  def change
    create_join_table :tests, :papers do |t|
      # t.index [:test_id, :paper_id]
      # t.index [:paper_id, :test_id]
    end
  end
end
