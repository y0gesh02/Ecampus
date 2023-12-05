class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.string :company_name
      t.string :contact_info
      t.string :salary
      t.references :user, null: false, foreign_key: true
      t.string :status,default: "active", null: false

      t.timestamps
    end
  end
end
