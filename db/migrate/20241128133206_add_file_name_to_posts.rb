class AddFileNameToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :file_name, :string
  end
end
