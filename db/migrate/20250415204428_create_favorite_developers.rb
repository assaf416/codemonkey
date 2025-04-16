class CreateFavoriteDevelopers < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_developers do |t|
      t.integer :business_id
      t.integer :developer_id
      t.timestamps
    end
    add_index :favorite_developers, :business_id
    add_index :favorite_developers, :developer_id
  end
end
