class AddCompanyToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :company_name, :string
    add_column :users, :college_name, :string
    add_column :users, :course_year, :string, default: "1st Year"
  end
end
