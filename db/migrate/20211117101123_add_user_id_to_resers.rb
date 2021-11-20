class AddUserIdToResers < ActiveRecord::Migration[6.1]
  def change
    add_column :resers, :user_id, :integer
  end
end
