class CreateUrlTagLists < ActiveRecord::Migration[5.0]
  def change
    create_table :url_tag_lists do |t|
      t.text :url
      t.text :tags

      t.timestamps
    end
  end
end
