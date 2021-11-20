class AddPostIdToResers < ActiveRecord::Migration[6.1]
  def change
    add_column :resers, :post_id, :integer
  end
end
