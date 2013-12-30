class CreateAvailabilityZones < ActiveRecord::Migration
  def change
    create_table :availability_zones do |t|
      t.string :name,   null: false
    end

    add_index :availability_zones, [:name], unique: true
  end
end
