class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :link
      t.text :content
      t.integer :views, default: 0

      t.timestamps
    end
  end
end
