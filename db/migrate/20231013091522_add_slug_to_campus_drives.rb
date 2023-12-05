class AddSlugToCampusDrives < ActiveRecord::Migration[7.0]
  def change
    add_column :campus_drives, :slug, :string
  end
end
