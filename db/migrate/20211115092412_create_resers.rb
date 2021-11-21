class CreateResers < ActiveRecord::Migration[6.1]
  def change
    create_table :resers do |t|
      t.integer :people
      t.date :start
      t.date :stop
      t.integer :price
      t.integer :days

      t.timestamps
    end
  end
end
