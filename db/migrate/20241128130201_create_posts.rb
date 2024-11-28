class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :body, null: false
      t.string :category, null: false
      t.integer :mr, default: 0
      t.integer :sr, default: 0
      t.string :name, null: false

      t.timestamps
    end
  end
end