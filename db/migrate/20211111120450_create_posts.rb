class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :room_name
      t.string :room_introduction
      t.integer :price
      t.string :address
      t.string :room_image

      t.timestamps
    end
  end
end
