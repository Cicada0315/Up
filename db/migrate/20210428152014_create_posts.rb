class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.belongs_to :user
      t.string :title
      t.string :image
      t.string :clip
      t.string :link
      t.string :content
      t.integer :views, default: 0 
      t.integer :likes, default: 0 

      t.timestamps
    end
  end
end
