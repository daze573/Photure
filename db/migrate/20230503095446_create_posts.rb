class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.string :title, null: false
      t.text :introduction, null: false
      t.boolean :status, null: false, default: false

      t.timestamps
    end
  end
end
