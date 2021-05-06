class CreateFavoritePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_posts do |t|
      t.references :post, null: false, foreign_key: true
      t.references :favorite, null: false, foreign_key: true

      t.timestamps
    end
  end
end
