class CreatePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :photos do |t|
      t.string :asset_id
      t.string :public_id
      t.string :version
      t.string :version_id
      t.string :signature
      t.string :width
      t.string :height
      t.string :format
      t.string :resource_type
      t.string :tags
      t.string :bytes
      t.string :etag
      t.string :placeholder
      t.string :url
      t.string :secure_url
      t.string :api_key

      t.timestamps
    end
  end
end
