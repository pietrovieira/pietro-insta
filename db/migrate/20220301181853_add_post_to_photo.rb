class AddPostToPhoto < ActiveRecord::Migration[7.0]
  def change
    add_column :photos, :post_id, :integer
    add_foreign_key :photos, :posts
  end
end
