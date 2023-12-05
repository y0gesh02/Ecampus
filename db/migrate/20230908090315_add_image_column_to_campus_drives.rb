class AddImageColumnToCampusDrives < ActiveRecord::Migration[7.0]
  def change
    add_column :campus_drives, :image_file_name, :string,default: "logo1.png"
  end
end
