class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :code,   null: false
      t.string :name,   null: false
    end

    add_index :products, [:code], unique: true
  end
end
