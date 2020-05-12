class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
    t.string :family_name, null: false
    t.string :first_name, null: false
    t.string :family_name_kana, null: false
    t.string :first_name_kana, null: false
    t.string :zipcode, null: false,limit:7
    t.string :prefecture, null: false
    t.string :city, null: false
    t.string :town, null: false
    t.string :town_number, null: false
    t.string :building
    t.string :tel
    t.references :user,null: false, foreign_key: true
    t.timestamps
    end
  end
end
