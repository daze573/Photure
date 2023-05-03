class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :introduction, null: false
      t.string :image_id, null: false
      t.integer :status, null: false, default: true

      t.timestamps
    end
  end
end
