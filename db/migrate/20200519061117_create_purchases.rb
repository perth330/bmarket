class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.references :seller, foreign_key: { to_table: :users }
      t.references :buyer, foreign_key: { to_table: :users }
      t.references :product, foreign_key: true
      t.references :address, foreign_key: true
      t.timestamps
    end
  end
end
