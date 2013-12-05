class CreateDataImports < ActiveRecord::Migration
  def change
    create_table :data_imports do |t|      
      t.string :file_path
      t.string :file_hash
      t.boolean :completed

      t.timestamps
    end
  end
end
