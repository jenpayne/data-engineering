class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :count
      t.integer :item_id
      t.integer :purchaser_id
      t.integer :data_import_id

      t.timestamps
    end
    add_index :purchases, :purchaser_id
  end
end
