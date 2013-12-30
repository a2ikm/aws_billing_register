class CreateCostAllocations < ActiveRecord::Migration
  def change
    create_table :cost_allocations do |t|
      t.string      :record_id,                 null: false 
      t.datetime    :billing_period_start_date, null: false
      t.datetime    :billing_period_end_date,   null: false
      t.datetime    :invoice_date,              null: false
      t.references  :product,                   null: false
      t.references  :usage_type,                null: false
      t.references  :availability_zone,         null: false
      t.string      :usage_quantity,            null: false
      t.float       :total_cost,                null: false
    end

    add_index :cost_allocations, [:record_id], unique: true
    add_index :cost_allocations, [:billing_period_start_date, :billing_period_end_date], name: "index_cost_allocations_on_billing_period"
    add_index :cost_allocations, [:product_id]
    add_index :cost_allocations, [:usage_type_id]
    add_index :cost_allocations, [:availability_zone_id]
  end
end
