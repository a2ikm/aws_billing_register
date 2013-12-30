class CreateUsageTypes < ActiveRecord::Migration
  def change
    create_table :usage_types do |t|
      t.string :name,     null: false
    end

    add_index :usage_types, [:name], unique: true
  end
end
