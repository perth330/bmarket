class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name,null: false
      t.text :introduction,null: false
      t.string :condition,null: false
      t.string :delivery_cost,null: false
      t.string :from,null: false
      t.string :delivery_day,null: false
      t.integer :price,null: false, limit: 6
      t.string :size
      t.string :status,null: false
      t.references :user,null: false, foreign_key: true
      t.references :brand,null: false, foreign_key: true
      t.references :category,null: false, foreign_key: true
      t.timestamps
    end
  end
end
